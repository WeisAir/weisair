#!/usr/bin/env python3
"""Upload the static webapp to a remote host over SFTP."""

import argparse
import subprocess
import sys
from pathlib import Path, PurePosixPath

SCRIPT_DIR = Path(__file__).resolve().parent
WEBAPP_DIRECTORY = SCRIPT_DIR / "webapp"


def quote_sftp_path(path):
    value = str(path)
    if "\n" in value or "\r" in value:
        raise ValueError(f"SFTP paths cannot contain newlines: {value!r}")
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


def remote_directory_commands(remote_directory):
    path = PurePosixPath(remote_directory)
    if not path.parts or path == PurePosixPath("/") or ".." in path.parts:
        raise ValueError("Remote directory must be a non-root path without '..'")
    if "\n" in remote_directory or "\r" in remote_directory:
        raise ValueError("Remote directory cannot contain newlines")

    directories = []
    current = PurePosixPath("/") if path.is_absolute() else PurePosixPath()
    for part in path.parts:
        if part == "/":
            continue
        current /= part
        directories.append(current)
    return directories


def build_sftp_batch(local_root, remote_directory):
    local_root = Path(local_root)
    if not local_root.is_dir():
        raise OSError(f"Webapp directory is missing or unreadable: {local_root}")
    if local_root.is_symlink():
        raise OSError(f"Webapp directory cannot be a symbolic link: {local_root}")

    remote_directories = remote_directory_commands(remote_directory)
    directories = set(remote_directories)
    files = []

    for path in local_root.rglob("*"):
        if path.is_symlink():
            raise OSError(f"Cannot deploy symbolic link: {path}")
        if path.is_dir():
            relative = path.relative_to(local_root).as_posix()
            directories.add(PurePosixPath(remote_directory) / relative)
        elif path.is_file():
            relative = path.relative_to(local_root).as_posix()
            if "\n" in relative or "\r" in relative:
                raise ValueError(f"SFTP paths cannot contain newlines: {path}")
            files.append((path, PurePosixPath(remote_directory) / relative))
        else:
            raise OSError(f"Unsupported webapp entry: {path}")

    commands = [
        f"-mkdir {quote_sftp_path(directory)}"
        for directory in sorted(directories, key=lambda item: (len(item.parts), str(item)))
    ]
    for local_path, remote_path in sorted(files, key=lambda item: item[1].as_posix()):
        commands.append(
            f"put {quote_sftp_path(local_path)} {quote_sftp_path(remote_path)}"
        )
    return commands, len(files)


def main():
    parser = argparse.ArgumentParser(
        description=(
            "Upload webapp/ to an SFTP destination using OpenSSH key authentication. "
            "Remote-only files are not deleted."
        )
    )
    parser.add_argument(
        "host",
        help="SSH config alias or user@host (configure key authentication in ~/.ssh/config)",
    )
    parser.add_argument(
        "remote_directory",
        help="Remote web root, for example public_html/weisair",
    )
    parser.add_argument(
        "--identity",
        type=Path,
        help="Optional SSH private-key file (a passphrase-protected key should be in ssh-agent)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Validate and count local files without connecting",
    )
    args = parser.parse_args()

    if args.host.startswith("-") or any(char.isspace() for char in args.host):
        parser.error("host must be an SSH alias or user@host without whitespace")

    commands, file_count = build_sftp_batch(WEBAPP_DIRECTORY, args.remote_directory)
    if args.dry_run:
        print(
            f"Dry run: {file_count} files from {WEBAPP_DIRECTORY} "
            f"would be uploaded to {args.host}:{args.remote_directory}"
        )
        return 0

    command = ["sftp", "-b", "-", "-oBatchMode=yes"]
    if args.identity is not None:
        command.extend(["-i", str(args.identity.expanduser())])
    command.append(args.host)

    print(f"Uploading {file_count} files to {args.host}:{args.remote_directory}")
    subprocess.run(
        command,
        input="\n".join(commands) + "\n",
        text=True,
        check=True,
    )
    print("SFTP deployment completed")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print(f"ERROR: Webapp deployment failed: {error}", file=sys.stderr)
        raise SystemExit(1) from error
