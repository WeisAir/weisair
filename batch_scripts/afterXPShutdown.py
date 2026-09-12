import subprocess
import tkinter as tk
from tkinter import messagebox

subprocess.run(
    ["powershell", "-NoProfile", "-Command",
     "Wait-Process -Name X-Plane"],
    check=False,
)

root = tk.Tk()
root.withdraw()
messagebox.showinfo("X-Plane Notice", "X-Plane has been closed")
root.destroy()