# Быстрая сборка APK для Android
# Требования: buildozer, Java JDK, Android SDK/NDK установлены

# Цвета вывода
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Сборка APK для Самооценка состояния" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Проверка наличия buildozer
$buildozer = Get-Command buildozer -ErrorAction SilentlyContinue

if (-not $buildozer) {
    Write-Host "❌ Buildozer не установлен!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Установите: pip install buildozer" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Buildozer найден" -ForegroundColor Green

# Проверка наличия requirements.txt
if (-not (Test-Path "requirements.txt")) {
    Write-Host "❌ requirements.txt не найден!" -ForegroundColor Red
    exit 1
}

# Проверка наличия buildozer.spec
if (-not (Test-Path "buildozer.spec")) {
    Write-Host "⚠️  buildozer.spec не найден, создаю..." -ForegroundColor Yellow
    # Создание будет выполнено, но проверка показывает что файл должен быть
}

Write-Host ""
Write-Host "📋 Доступные команды:" -ForegroundColor Cyan
Write-Host "  1 - Debug APK (для тестирования)"
Write-Host "  2 - Release APK (для публикации)"
Write-Host "  3 - Очистить и пересобрать (clean debug)"
Write-Host "  4 - Выход" -ForegroundColor Red
Write-Host ""

$choice = Read-Host "Выберите опцию (1-4)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "🔨 Создаю Debug APK..." -ForegroundColor Cyan
        Write-Host "⏳ Это может занять 15-30 минут при первом запуске..." -ForegroundColor Yellow
        Write-Host ""
        buildozer android debug
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ APK создан успешно!" -ForegroundColor Green
            Write-Host "📁 Путь: bin\samoocenka-1.0.0-debug.apk" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Установить на телефон:" -ForegroundColor Yellow
            Write-Host "  adb install bin\samoocenka-1.0.0-debug.apk"
        } else {
            Write-Host ""
            Write-Host "❌ Ошибка при сборке!" -ForegroundColor Red
            Write-Host "Смотрите ошибки выше"
        }
    }
    "2" {
        Write-Host ""
        Write-Host "🔨 Создаю Release APK..." -ForegroundColor Cyan
        Write-Host "⏳ Это может занять 20-40 минут..." -ForegroundColor Yellow
        Write-Host ""
        buildozer android release
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Release APK создан!" -ForegroundColor Green
            Write-Host "📁 Путь: bin\samoocenka-1.0.0-release.apk" -ForegroundColor Cyan
        } else {
            Write-Host ""
            Write-Host "❌ Ошибка при сборке!" -ForegroundColor Red
        }
    }
    "3" {
        Write-Host ""
        Write-Host "🗑️  Очищаю предыдущие сборки..." -ForegroundColor Cyan
        buildozer android debug clean
        
        Write-Host ""
        Write-Host "🔨 Создаю новый Debug APK..." -ForegroundColor Cyan
        Write-Host "⏳ Это может занять 15-30 минут..." -ForegroundColor Yellow
        Write-Host ""
        buildozer android debug
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ APK создан успешно!" -ForegroundColor Green
            Write-Host "📁 Путь: bin\samoocenka-1.0.0-debug.apk" -ForegroundColor Cyan
        }
    }
    "4" {
        Write-Host "Выход..." -ForegroundColor Yellow
        exit 0
    }
    default {
        Write-Host "❌ Неверный выбор!" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Сборка завершена" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Cyan
