@echo off
REM Проверка подготовки системы к сборке APK

color 0B
cls
echo.
echo ========================================
echo   Проверка окружения для сборки APK
echo ========================================
echo.

setlocal enabledelayedexpansion
set all_ok=1

REM Проверка Python
echo Проверка Python...
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VER=%%i
    echo   ✅ Python найден (версия %PYTHON_VER%)
) else (
    echo   ❌ Python НЕ найден!
    set all_ok=0
)
echo.

REM Проверка Buildozer
echo Проверка Buildozer...
buildozer --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   ✅ Buildozer установлен
) else (
    echo   ❌ Buildozer НЕ установлен!
    echo      Установите: pip install buildozer
    set all_ok=0
)
echo.

REM Проверка Java
echo Проверка Java Development Kit (JDK)...
java -version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=2" %%i in ('java -version 2^>^&1 ^| find "version"') do set JAVA_VER=%%i
    echo   ✅ Java найдена (версия %JAVA_VER%)
) else (
    echo   ⚠️  Java НЕ найдена!
    echo      Требуется JDK 11+
    echo      Скачайте с: https://www.oracle.com/java/technologies/downloads/
    set all_ok=0
)
echo.

REM Проверка Android SDK
echo Проверка Android SDK...
if defined ANDROID_HOME (
    if exist "%ANDROID_HOME%" (
        echo   ✅ ANDROID_HOME: %ANDROID_HOME%
    ) else (
        echo   ⚠️  ANDROID_HOME определена, но путь не существует
        set all_ok=0
    )
) else (
    echo   ⚠️  ANDROID_HOME НЕ определена!
    echo      Установите переменную окружения ANDROID_HOME
)
echo.

REM Проверка Android NDK
echo Проверка Android NDK...
if defined ANDROID_NDK_HOME (
    if exist "%ANDROID_NDK_HOME%" (
        echo   ✅ ANDROID_NDK_HOME: %ANDROID_NDK_HOME%
    ) else (
        echo   ⚠️  ANDROID_NDK_HOME определена, но путь не существует
    )
) else (
    echo   ⚠️  ANDROID_NDK_HOME НЕ определена!
    echo      Если у вас есть NDK, установите переменную окружения
)
echo.

REM Проверка ADB
echo Проверка Android Debug Bridge (adb)...
adb version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   ✅ ABD найден (для установки на устройство)
) else (
    echo   ⚠️  adb НЕ найден (опционально для установки)
)
echo.

REM Результат
echo ========================================
if %all_ok% EQU 1 (
    color 0A
    echo ✅ ВСЕ НЕОБХОДИМЫЕ ИНСТРУМЕНТЫ УСТАНОВЛЕНЫ!
    echo.
    echo Сборка готова. Запустите: BUILD_APK.bat
) else (
    color 0C
    echo ❌ ТРЕБУЕТСЯ ДОУСТАНОВКА КОМПОНЕНТОВ
    echo.
    echo Смотрите BUILD_APK_GUIDE.md для подробной инструкции
)

echo ========================================
echo.
pause
