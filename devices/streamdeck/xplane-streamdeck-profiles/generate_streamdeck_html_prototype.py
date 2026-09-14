#!/usr/bin/env python3
"""Generate a navigable HTML view of a 32-key Stream Deck YAML tree."""

"""run command: python3 generate_streamdeck_html.py B737-800X/sd32 \
  --icons-dir icons \
  --output streamdeck.html"""

import argparse
import base64
import json
import mimetypes
import sys
from pathlib import Path
from typing import Any

import yaml


KEY_COUNT = 32


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate a self-contained HTML viewer for Stream Deck YAML actions."
    )
    parser.add_argument(
        "config_dir",
        type=Path,
        help="Directory containing actions.yaml and its child YAML files.",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        help="HTML output path (default: streamdeck.html next to config_dir).",
    )
    parser.add_argument(
        "--icons-dir",
        type=Path,
        help="Directory containing icon PNGs. Icons are embedded into the HTML.",
    )
    return parser.parse_args()


def load_actions(path: Path) -> dict[int, dict[str, Any]]:
    with path.open(encoding="utf-8") as stream:
        document = yaml.safe_load(stream) or {}

    actions = document.get("actions")
    if not isinstance(actions, list):
        raise ValueError(f"{path}: expected an 'actions' list")

    result: dict[int, dict[str, Any]] = {}
    for action in actions:
        if not isinstance(action, dict):
            raise ValueError(f"{path}: every action must be a mapping")
        index = action.get("index")
        if not isinstance(index, int) or isinstance(index, bool) or not 0 <= index < KEY_COUNT:
            raise ValueError(f"{path}: index must be an integer from 0 to 31: {index!r}")
        if index in result:
          print(
            f"Warning: {path}: duplicate action index {index}; using the last entry",
            file=sys.stderr,
          )
        result[index] = action
    return result


def collect_tree(config_dir: Path) -> dict[str, list[dict[str, Any]]]:
    files = sorted(config_dir.glob("*.yaml"))
    if not (config_dir / "actions.yaml").is_file():
        raise FileNotFoundError(f"Missing root file: {config_dir / 'actions.yaml'}")

    tree: dict[str, list[dict[str, Any]]] = {}
    for path in files:
        actions = load_actions(path)
        tree[path.stem] = [actions.get(index) for index in range(KEY_COUNT)]
    return tree


def icon_data_uri(icon_name: str | None, icons_dir: Path | None) -> str | None:
    if not icon_name or not icons_dir:
        return None

    candidates = [icons_dir / f"{icon_name}.png"]
    candidates.extend(icons_dir.glob(f"{icon_name}.*.png"))
    for path in candidates:
        if path.is_file():
            mime_type = mimetypes.guess_type(path.name)[0] or "image/png"
            encoded = base64.b64encode(path.read_bytes()).decode("ascii")
            return f"data:{mime_type};base64,{encoded}"
    return None


def embed_icons(tree: dict[str, list[dict[str, Any]]], icons_dir: Path | None) -> None:
    if not icons_dir:
        return
    for actions in tree.values():
        for action in actions:
            if action and action.get("icon"):
                action["_icon_data"] = icon_data_uri(action["icon"], icons_dir)


HTML_TEMPLATE = r"""<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Stream Deck Configuration</title>
  <style>
    :root { color-scheme: dark; font-family: system-ui, sans-serif; }
    body { margin: 0; min-height: 100vh; background: #101318; color: #edf2f7; }
    header { display: flex; gap: 1rem; align-items: center; padding: 1rem 1.5rem; border-bottom: 1px solid #303743; }
    h1 { margin: 0; font-size: 1.25rem; font-weight: 650; }
    .path { color: #8fa2b8; font-size: .9rem; }
    main { display: grid; grid-template-columns: minmax(32rem, 1fr) minmax(18rem, 26rem); gap: 1rem; padding: 1rem; }
    .deck { display: grid; grid-template-columns: repeat(8, minmax(5rem, 1fr)); gap: .65rem; align-content: start; }
    button { font: inherit; color: inherit; }
    .key { aspect-ratio: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: .35rem; padding: .45rem; border: 1px solid #394352; border-radius: .55rem; background: #1b222c; cursor: pointer; overflow: hidden; }
    .key:hover, .key:focus-visible { border-color: #55c2ff; background: #243344; outline: none; }
    .key.empty { cursor: default; opacity: .38; }
    .key.dir { border-color: #d99d45; }
    .key img { width: 62%; height: 62%; object-fit: contain; }
    .key-label { max-width: 100%; overflow: hidden; text-align: center; text-overflow: ellipsis; white-space: nowrap; font-size: .72rem; }
    .index { position: absolute; align-self: flex-start; color: #718096; font-size: .7rem; }
    .key { position: relative; }
    aside { min-width: 0; padding: 1rem; border: 1px solid #303743; border-radius: .55rem; background: #171c24; }
    aside h2 { margin: 0 0 .8rem; font-size: 1rem; }
    .hint { color: #8fa2b8; }
    dl { margin: 0; }
    dt { margin-top: .7rem; color: #8fa2b8; font-size: .75rem; }
    dd { margin: .15rem 0 0; overflow-wrap: anywhere; white-space: pre-wrap; }
    .controls { display: flex; gap: .5rem; margin-left: auto; }
    .controls button { padding: .35rem .7rem; border: 1px solid #4a5666; border-radius: .35rem; background: #202a36; cursor: pointer; }
    .controls button:disabled { cursor: default; opacity: .4; }
    @media (max-width: 850px) { main { grid-template-columns: 1fr; } }
    @media (max-width: 600px) { main { padding: .5rem; } .deck { grid-template-columns: repeat(4, minmax(4rem, 1fr)); gap: .4rem; } header { padding: .8rem; } }
  </style>
</head>
<body>
  <header>
    <div><h1>Stream Deck Configuration</h1><div class="path" id="path"></div></div>
    <div class="controls"><button id="back" type="button">Back</button><button id="root" type="button">Root</button></div>
  </header>
  <main>
    <section class="deck" id="deck" aria-label="Stream Deck keys"></section>
    <aside id="details"><h2>Button properties</h2><p class="hint">Select a key to inspect its YAML properties.</p></aside>
  </main>
  <script>
    const tree = __TREE__;
    const root = "actions";
    let current = root;
    const history = [];
    const deck = document.getElementById("deck");
    const details = document.getElementById("details");
    const path = document.getElementById("path");

    function text(value) {
      if (value === null || value === undefined) return "";
      if (typeof value === "object") return JSON.stringify(value, null, 2);
      return String(value);
    }

    function showDetails(action, index) {
      details.replaceChildren();
      const heading = document.createElement("h2");
      heading.textContent = `Key ${index} properties`;
      details.append(heading);
      if (!action) {
        const empty = document.createElement("p");
        empty.className = "hint";
        empty.textContent = "This key has no action.";
        details.append(empty);
        return;
      }
      const list = document.createElement("dl");
      for (const [name, value] of Object.entries(action)) {
        if (name === "_icon_data") continue;
        const term = document.createElement("dt");
        term.textContent = name;
        const description = document.createElement("dd");
        description.textContent = text(value);
        list.append(term, description);
      }
      details.append(list);
    }

    function render() {
      const actions = tree[current] || [];
      path.textContent = current === root ? "actions.yaml" : `${current}.yaml`;
      deck.replaceChildren();
      actions.forEach((action, index) => {
        const key = document.createElement("button");
        key.type = "button";
        key.className = `key${action ? "" : " empty"}${action?.type === "dir" ? " dir" : ""}`;
        key.disabled = !action;
        const number = document.createElement("span");
        number.className = "index";
        number.textContent = index;
        key.append(number);
        if (action?._icon_data) {
          const image = document.createElement("img");
          image.src = action._icon_data;
          image.alt = action.icon || "";
          key.append(image);
        }
        const label = document.createElement("span");
        label.className = "key-label";
        label.textContent = action?.label || action?.name || "";
        key.append(label);
        if (action) key.addEventListener("click", () => {
          showDetails(action, index);
          if (action.type === "dir") {
            const target = action.name;
            if (tree[target]) {
              history.push(current);
              current = target;
              render();
            } else if (target === "return" && history.length) {
              current = history.pop();
              render();
            }
          }
        });
        deck.append(key);
      });
      document.getElementById("back").disabled = history.length === 0;
    }

    document.getElementById("back").addEventListener("click", () => {
      if (history.length) { current = history.pop(); render(); }
    });
    document.getElementById("root").addEventListener("click", () => {
      history.length = 0; current = root; render();
    });
    render();
  </script>
</body>
</html>
"""


def generate_html(config_dir: Path, output: Path, icons_dir: Path | None) -> None:
    tree = collect_tree(config_dir)
    embed_icons(tree, icons_dir)
    html = HTML_TEMPLATE.replace("__TREE__", json.dumps(tree, ensure_ascii=True))
    output.write_text(html, encoding="utf-8")


def main() -> None:
    arguments = parse_arguments()
    config_dir = arguments.config_dir.resolve()
    output = arguments.output or config_dir.parent / "streamdeck.html"
    icons_dir = arguments.icons_dir.resolve() if arguments.icons_dir else None
    generate_html(config_dir, output.resolve(), icons_dir)
    print(f"Wrote {output.resolve()}")


if __name__ == "__main__":
    main()