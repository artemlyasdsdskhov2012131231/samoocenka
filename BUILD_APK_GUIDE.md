# 📱 Сборка APK для Android

## 🔧 Требования к системе

- **Windows 10/11** (или Linux/Mac)
- **Python 3.9+**
- **Java Development Kit (JDK) 11+**
- **Android SDK** 
- **Android NDK**
- **Buildozer**
- **Kivy**

## 📥 Шаг 1: Установка необходимых инструментов

### 1.1 Установка Java Development Kit (JDK)

Скачайте JDK 11+ с [oracle.com](https://www.oracle.com/java/technologies/downloads/) или используйте:

```bash
# Windows (через chocolatey, если установлен)
choco install openjdk11

# Или скачайте вручную с Oracle
```

**Установите переменные окружения:**
```bash
$env:JAVA_HOME = "C:\Program Files\Java\jdk-11" # (или путь к вашему JDK)
$env:PATH += ";$env:JAVA_HOME\bin"
```

### 1.2 Установка Android SDK и NDK

Скачайте [Android Command Line Tools](https://developer.android.com/studio/command-line-tools)

```bash
# Распакуйте в папку, например C:\Android\cmdline-tools
# Установите SDK, NDK и другие компоненты:

$env:ANDROID_SDK_ROOT = "C:\Android"
$env:ANDROID_HOME = "C:\Android"
$env:PATH += ";$env:ANDROID_SDK_ROOT\tools\bin;$env:ANDROID_SDK_ROOT\platform-tools"

# Установите необходимые компоненты:
sdkmanager "platforms;android-31" "build-tools;31.0.0" "ndk;25.1.8937393"
```

### 1.3 Установка Buildozer

```bash
pip install buildozer>=1.4.3
pip install Cython
pip install virtualenv
```

### 1.4 Установка зависимостей Python

```bash
pip install -r requirements.txt
pip install flet>=0.83.1
```

## 📂 Шаг 2: Подготовка проекта

Убедитесь, что ваш проект имеет структуру:
```
d:\анкета состояния 2\
├── app.py              (главный файл)
├── storage.py
├── buildozer.spec      (уже создан)
├── requirements.txt
├── assets/             (иконки)
└── ...
```

## 🔨 Шаг 3: Сборка APK

Откройте PowerShell в папке проекта и запустите:

```bash
cd "d:\анкета состояния 2"

# Сборка APK (первый раз будет долго - 15-30 минут)
buildozer android debug

# Для релиза (подписанный APK)
buildozer android release
```

## ✅ Шаг 4: Результат

После успешной сборки APK будет находиться в:
```
bin/samoocenka-1.0.0-debug.apk
```

## 📲 Шаг 5: Установка на телефон

**Способ 1: Через USB (рекомендуется)**
```bash
# Включите "Отладку USB" на телефоне (Параметры → О телефоне → нажмите на "Версия ПО" 7 раз)
# Подключите телефон USB кабелем
# Установите APK:
adb install bin\samoocenka-1.0.0-debug.apk
```

**Способ 2: Вручную**
1. Передайте файл `bin/samoocenka-1.0.0-debug.apk` на телефон
2. Откройте файловый менеджер
3. Найдите APK и нажмите для установки
4. Разрешите установку из неизвестных источников (если нужно)

## 🐛 Решение проблем

### Ошибка: "No module named 'openpyxl'"
Некоторые модули (openpyxl, reportlab) могут быть недоступны на Android. Они уже настроены как опциональные в `app.py` - приложение будет работать без них.

### Ошибка: "Java not found"
Может потребоваться установить JAVA_HOME переменную окружения:
```bash
$env:JAVA_HOME = "C:\Program Files\Java\jdk-11"
```

### Ошибка: "Android SDK not found"
```bash
$env:ANDROID_SDK_ROOT = "C:\Android"
$env:ANDROID_HOME = "C:\Android"
```

### Долгая сборка
Первая сборка может занять 30+ минут. Последующие сборки будут быстрее.

### Приложение не запускается
1. Включите логирование: `adb logcat | grep samoocenka`
2. Проверьте разрешения Android (в app.py уже обработаны)
3. Убедитесь что версия Android на телефоне >= 5.0 (API 21)

## 📝 Дополнительные команды

```bash
# Очистить кэш и сделать полную пересборку
buildozer android debug clean

# Сборка с логированием
buildozer android debug -- log_level=2

# Просмотр логов с телефона
adb logcat
```

## 🔍 Если нужна помощь

1. Проверьте лог сборки в папке `.buildozer/`
2. Убедитесь, что все переменные окружения установлены
3. Попробуйте обновить buildozer: `pip install --upgrade buildozer`
