"""
Кроссплатформный модуль для управления хранилищем приложения.
Поддерживает Windows и Android с полной обработкой ошибок.
"""

import os
import sys
from pathlib import Path

# Определяем платформу
IS_ANDROID = sys.platform == "android"
IS_WINDOWS = sys.platform == "win32"
IS_WEB = sys.platform == "emscripten"

APP_NAME = "Самооценка состояния"


def get_platform_name() -> str:
    """Возвращает название текущей платформы."""
    if IS_ANDROID:
        return "android"
    elif IS_WINDOWS:
        return "windows"
    elif IS_WEB:
        return "web"
    else:
        return "unknown"


def get_app_storage_dir() -> Path:
    r"""
    Возвращает путь к директории хранилища приложения.
    
    Windows: C:\Users\<User>\Documents\Самооценка состояния\
    Android: Flet's private storage (самый безопасный вариант)
    
    На защищённых Android устройствах использует приватное хранилище,
    которое не требует специальных разрешений.
    """
    
    if IS_ANDROID:
        # ==== ПРИВАТНОЕ ХРАНИЛИЩЕ ANDROID (ПРОСТОЙ СПОСОБ) ====
        try:
            # Самый надежный способ: прямой путь к приватному хранилищу
            private_dir = Path("/data/data/org.test.samoocenka/files")
            private_dir.mkdir(parents=True, exist_ok=True)
            storage_path = private_dir / APP_NAME
            return storage_path
        except (OSError, ValueError):
            pass
        
        # Fallback: использовать стандартную Android директорию
        try:
            import flet as ft
            if hasattr(ft, 'app_storage_dir') and ft.app_storage_dir:
                return Path(ft.app_storage_dir) / APP_NAME
        except Exception:
            pass
        
        # ==== FALLBACK: ИСПОЛЬЗОВАНИЕ ПЕРЕМЕННЫХ ОКРУЖЕНИЯ ====
        # На некоторых Android системах хранилище доступно через переменные окружения
        try:
            external_storage = os.getenv("EXTERNAL_STORAGE")
            if external_storage and external_storage != "/":
                storage_path = Path(external_storage) / "Android" / "data" / "com.example.samoocenka" / "files" / APP_NAME
                return storage_path
        except (OSError, ValueError):
            pass
        
        # ==== FALLBACK: СТАНДАРТНАЯ ПРИВАТНАЯ ПАПКА ANDROID ====
        # /data/data/<package>/files/ (всегда доступна для приложения)
        try:
            # Стандартный путь для Android приложений (НЕ требует разрешений)
            private_storage = Path("/data/data/com.example.samoocenka/files")
            if private_storage.parent.exists():
                return private_storage
        except (OSError, ValueError):
            pass
        
        # ==== FALLBACK: ВРЕМЕННАЯ ДИРЕКТОРИЯ ====
        try:
            temp_dir = Path("/tmp")
            if temp_dir.exists() and temp_dir.is_dir():
                return temp_dir / APP_NAME
        except (OSError, ValueError):
            pass
        
        # ==== FALLBACK: ТЕКУЩАЯ РАБОЧАЯ ДИРЕКТОРИЯ ====
        try:
            cwd = Path.cwd()
            if cwd and cwd != Path("/") and cwd.exists():
                return cwd / APP_NAME
        except (OSError, ValueError, RuntimeError):
            pass
        
        # ==== ПОСЛЕДНИЙ FALLBACK ====
        # Возвращаем путь, даже если он может быть недоступен
        # (лучше вернуть что-то, чем упасть)
        return Path("/storage/emulated/0/Documents/Самооценка состояния")
    
    
    elif IS_WINDOWS:
        # ==== WINDOWS: ДОКУМЕНТЫ ИЛИ APPDATA ====
        try:
            home = Path.home()
            if home and home != Path("/"):
                documents = home / "Documents"
                if documents.exists() or home.exists():
                    return documents / APP_NAME
        except (RuntimeError, OSError, ValueError):
            pass
        
        # Fallback: используем APPDATA
        try:
            appdata = os.environ.get("APPDATA")
            if appdata and appdata != "":
                return Path(appdata) / "Самооценка состояния"
        except (OSError, ValueError):
            pass
        
        # Последний fallback: текущая директория
        try:
            cwd = Path.cwd()
            if cwd and cwd != Path("/"):
                return cwd / APP_NAME
        except (OSError, ValueError, RuntimeError):
            pass
        
        # Защита на случай полного отказа
        return Path.cwd() / APP_NAME
    
    else:
        # ==== LINUX/MACOS ====
        try:
            home = Path.home()
            config_dir = home / ".config" / APP_NAME
            if config_dir.parent.exists():
                return config_dir
        except (RuntimeError, OSError, ValueError):
            pass
        
        # Fallback
        try:
            return Path.cwd() / APP_NAME
        except (OSError, ValueError, RuntimeError):
            return Path("/tmp") / APP_NAME


def get_results_dir() -> Path:
    """Директория для хранения результатов анкет."""
    base = get_app_storage_dir()
    return base / "results" if base else Path("/tmp/results")


def get_logs_dir() -> Path:
    """Директория для логов."""
    base = get_app_storage_dir()
    return base / "logs" if base else Path("/tmp/logs")


def get_exports_dir() -> Path:
    """Директория для экспортированных файлов."""
    base = get_app_storage_dir()
    return base / "exports" if base else Path("/tmp/exports")


def get_backups_dir() -> Path:
    """Директория для резервных копий."""
    base = get_app_storage_dir()
    return base / "backups" if base else Path("/tmp/backups")


def ensure_storage_dirs():
    """
    Создаёт все необходимые директории.
    НИКОГДА не выбрасывает исключения - всегда успешно завершается.
    """
    try:
        dirs_to_create = [
            get_results_dir(),
            get_logs_dir(),
            get_exports_dir(),
            get_backups_dir(),
        ]
        
        created_count = 0
        for directory in dirs_to_create:
            if not directory:
                continue
                
            try:
                # Создаём директорию с родителями
                directory.mkdir(parents=True, exist_ok=True)
                created_count += 1
            except (OSError, ValueError) as e:
                # Логируем, но ПРОДОЛЖАЕМ (не падаем)
                print(f"DEBUG: Could not create {directory}: {e}")
            except Exception as e:
                # Неожиданные ошибки - также продолжаем
                print(f"WARNING: Unexpected error creating {directory}: {e}")
        
        print(f"DEBUG: Storage initialization complete ({created_count}/{len(dirs_to_create)} dirs)")
        
    except Exception as e:
        # Критическая ошибка - логируем, но не падаем
        print(f"WARNING: Critical storage initialization error: {e}")
        import traceback
        traceback.print_exc()


def get_platform_info() -> dict:
    """Возвращает информацию о платформе для отладки."""
    try:
        platform = get_platform_name()
    except Exception:
        platform = "unknown"
    
    try:
        storage_path = str(get_app_storage_dir())
    except Exception:
        storage_path = "unknown"
    
    return {
        "platform": platform,
        "python_version": sys.version,
        "app_storage": storage_path,
        "is_frozen": getattr(sys, "frozen", False),
        "sys_platform": sys.platform,
    }


# ==== ИНИЦИАЛИЗАЦИЯ ПРИ ИМПОРТЕ ====
# Всегда вызываем, даже если Web (но Web игнорирует)
if not IS_WEB:
    try:
        ensure_storage_dirs()
    except Exception as e:
        print(f"ERROR: Failed to initialize storage on module import: {e}")
