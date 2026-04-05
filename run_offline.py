#!/usr/bin/env python3
"""
Offline mode launcher for SecureNet environment
Launches app in WEB mode with built-in HTTP server (no external downloads)
"""
import os
import sys
import webbrowser
import threading
import time
from pathlib import Path

# Handle both exe and python script execution
if getattr(sys, 'frozen', False):
    # Running as exe via PyInstaller
    script_dir = Path(sys.executable).parent
else:
    # Running as python script
    script_dir = Path(__file__).resolve().parent

sys.path.insert(0, str(script_dir))
os.chdir(str(script_dir))

# Environment configuration for offline mode
os.environ['FLET_AUTO_DOWNLOAD'] = 'false'
os.environ['PYTHONDONTWRITEBYTECODE'] = '1'
os.environ['PYTHONIOENCODING'] = 'utf-8'

try:
    import flet as ft
    # Import app from current directory
    if (script_dir / 'app.py').exists():
        from app import main
    else:
        raise FileNotFoundError(f"app.py not found in {script_dir}\nMake sure app.py is in the same directory")
    
    print("=" * 60)
    print("SAMOOTSENKO - Offline Mode (SecureNet)")
    print("=" * 60)
    print()
    print("Starting application in WEB mode (built-in local server)...")
    print("This mode does NOT require internet or Flet runtime download")
    print()
    
    # Function to open browser after server starts
    def open_browser():
        time.sleep(2)  # Wait for server to start
        print("[*] Opening browser window...")
        webbrowser.open('http://localhost:8550')
    
    # Start browser in background thread
    browser_thread = threading.Thread(target=open_browser, daemon=True)
    browser_thread.start()
    
    # Launch app in WEB mode
    try:
        print("[*] Starting local web server...\n")
        ft.app(
            target=main,
            port=8550,
            assets_dir='assets'
        )
    except Exception as e:
        print(f"[ERROR] WEB mode failed: {e}")
        print("\nTroubleshooting:")
        print("1. Make sure port 8550 is available")
        print("2. Check that browser can access localhost")
        print("3. Try running in administrator mode")
        sys.exit(1)
        
except ImportError as e:
    print(f"[ERROR] Missing dependency: {e}")
    print("\nAttempting to install required packages...")
    import subprocess
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-q", "flet"])
        print("[*] Flet installed successfully")
        print("[*] Please run the script again")
    except Exception as install_error:
        print(f"[ERROR] Failed to install: {install_error}")
        print("\nPlease install manually:")
        print("  pip install flet")
    sys.exit(1)
except FileNotFoundError as e:
    print(f"[ERROR] {e}")
    print(f"\nMake sure script runs from correct directory")
    sys.exit(1)
except Exception as e:
    print(f"[FATAL ERROR] {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)
