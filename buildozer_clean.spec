[app]
# Название приложения
title = Самооценка состояния

# Имя пакета
package.name = samoocenka

# Домен пакета
package.domain = org.samoocenka

# Директория исходного кода
source.dir = .

# Включить эти расширения файлов
source.include_exts = py,png,jpg,kv,atlas,json

# Версия приложения
version = 1.0.0

# Требуемая версия Python
python_requires = 3.9

# Зависимости Python
requirements = python3,flet>=0.83.1,typing_extensions,httpx,certifi,openpyxl,reportlab,Pillow

# Иконка приложения (если есть)
# icon.filename = %(source.dir)s/assets/icon.png

# Ориентация (portrait или landscape)
orientation = portrait

# На Android нам не нужны Java классы
android.java_classes = no

# Разрешения Android
android.permissions = INTERNET,WRITE_EXTERNAL_STORAGE,READ_EXTERNAL_STORAGE

# Целевой API
android.api = 31

# Минимальный API
android.minapi = 21

# NDK версия
android.ndk = 25b

# Архитектуры для сборки
android.archs = arm64-v8a,armeabi-v7a

# Bootstrap
p4a.bootstrap = webview

# Use legacy toolchain, set to 0 for new
android.use_legacy_toolchain = False

# Target API
android.target_api = 31

# Features
android.features = android.hardware.touchscreen

# Internet требуется
android.uses_internet = True

[buildozer]
# Уровень логирования
log_level = 2

# Warn если запускаем как root
warn_on_root = 1
