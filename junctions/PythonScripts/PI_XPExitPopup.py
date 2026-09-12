import os
import tkinter as tk
from tkinter import messagebox

class PythonInterface:
    def __init__(self):
        self.Name = "X-Plane Exit Popup"
        self.Sig = "user.plugins.xpexitpopup"
        self.Desc = "Shows a popup window when X-Plane closes."

    def XPluginStart(self):
        # Registers the plugin with X-Plane
        return self.Name, self.Sig, self.Desc

    def XPluginStop(self):
        # This code runs exactly when X-Plane is shutting down
        self.show_exit_popup()

    def XPluginEnable(self):
        return 1

    def XPluginDisable(self):
        pass

    def XPluginReceiveMessage(self, inFromWho, inMessage, inParam):
        pass

    def show_exit_popup(self):
        # Create a hidden root window for Tkinter
        root = tk.Tk()
        root.withdraw()
        
        # Bring the popup to the front of the screen
        root.attributes("-topmost", True)
        
        # Display the info box
        messagebox.showinfo("X-Plane Notice", "X-Plane has been closed")
        
        # Clean up and close the Tkinter instance
        root.destroy()