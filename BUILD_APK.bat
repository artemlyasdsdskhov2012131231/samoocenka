@echo off
REM ======================================
REM Сборка APK для Самооценка состояния
REM ======================================

title Buildozer APK Builder

REM Проверяем наличие buildozer
where buildozer >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo ❌ ОШИБКА: Buildozer не найден!
    echo.
    echo Установите командой:
    echo   pip install buildozer
    echo.
    pause
    exit /b 1
)

color 0B
cls
echo.
echo ========================================
echo   Сборка APK для Самооценка состояния
echo ========================================
echo.
echo Выберите режим:
echo   1 - Debug APK (для тестирования)
echo   2 - Release APK (для PublishPlay Store)
echo   3 - Очистить кэш и пересобрать
echo   4 - Выход
echo.

set /p choice="Введите номер (1-4): "

if "%choice%"=="1" goto debug
if "%choice%"=="2" goto release
if "%choice%"=="3" goto clean
if "%choice%"=="4" goto exit
echo Неверный выбор!
pause
exit /b 1

:debug
cls
color 0A
echo.
echo 🔨 Собираю Debug APK для тестирования...
echo ⏳ Это может занять 15-30 минут при первом запуске
echo.
buildozer android debug
if %ERRORLEVEL% EQU 0 (
    color 0A
    echo.
    echo ✅ APK создан успешно!
    echo 📁 Путь: bin\samoocenka-1.0.0-debug.apk
    echo.
    echo Установить на телефон:
    echo   adb install bin\samoocenka-1.0.0-debug.apk
) else (
    color 0C
    echo.
    echo ❌ Ошибка при сборке!
)
pause
exit /b %ERRORLEVEL%

:release
cls
color 0A
echo.
echo 🔨 Собираю Release APK...
echo ⏳ Это может занять 20-40 минут
echo.
buildozer android release
if %ERRORLEVEL% EQU 0 (
    color 0A
    echo.
    echo ✅ Release APK создан успешно!
    echo 📁 Путь: bin\samoocenka-1.0.0-release.apk
) else (
    color 0C
    echo.
    echo ❌ Ошибка при сборке!
)
pause
exit /b %ERRORLEVEL%

:clean
cls
color 0E
echo.
echo 🗑️  Очищаю кэш...
buildozer android debug clean
color 0A
echo.
echo 🔨 Собираю новый Debug APK...
echo ⏳ Это может занять 15-30 минут
echo.
buildozer android debug
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ APK создан успешно!
    echo 📁 Путь: bin\samoocenka-1.0.0-debug.apk
) else (
    color 0C
    echo.
    echo ❌ Ошибка при сборке!
)
pause
exit /b %ERRORLEVEL%

:exit
exit /b 0
