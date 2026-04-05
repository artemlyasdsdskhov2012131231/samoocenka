# 🖥️ Подготовка системы по ОС

Инструменты необходимые для сборки APK зависят от вашей ОС.

## 🪟 Windows 10/11

### Требуемые компоненты

- ✅ Python 3.9+ (проверить: `python --version`)
- ✅ Java Development Kit 11+ (скачать выше)
- ✅ Buildozer (`pip install buildozer`)
- ✅ Android SDK (скачать command-line tools)
- ✅ Android NDK (установить через SDK)

### Установка (Windows)

**1. Python** (если нет)
```bash
# Скачайте с python.org или:
choco install python39
```

**2. Java** (обязательно)
```bash
# Способ 1: Adoptium (рекомендуется)
choco install temurin17

# Способ 2: Oracle
# Скачайте с oracle.com
```

**3. Buildozer**
```bash
pip install buildozer
pip install Cython
pip install virtualenv
```

**4. Android SDK/NDK**
```bash
# Скачайте Command Line Tools с:
# https://developer.android.com/studio/command-line-tools

# Распакуйте в C:\Android\

# Установите SDK:
$env:ANDROID_HOME = "C:\Android"
sdkmanager "platforms;android-31" "build-tools;31.0.0" "ndk;25.1.8937393"
```

### Проверка готовности

```bash
# Запустите батник:
CHECK_ENVIRONMENT.bat
```

## 🐧 Linux (Ubuntu/Debian)

### Установка

```bash
# Обновите пакеты
sudo apt update && sudo apt upgrade

# Python
sudo apt install python3.9 python3.9-dev python3-pip

# Java
sudo apt install openjdk-17-jdk-headless

# Buildozer зависимости
sudo apt install -y \
    git \
    python3-pip \
    python3-dev \
    libssl-dev \
    libffi-dev \
    libjpeg-dev \
    zlib1g-dev \
    autoconf \
    libtool \
    pkg-config \
    make \
    autoconf \
    automake \
    libtool

# Buildozer
pip install buildozer Cython virtualenv

# Android SDK
mkdir -p ~/Android/cmdline-tools
cd ~/Android/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-*.zip
unzip commandlinetools-linux-*.zip
mv cmdline-tools/* .

# Установите SDK
~/Android/cmdline-tools/bin/sdkmanager \
    "platforms;android-31" \
    "build-tools;31.0.0" \
    "ndk;25.1.8937393"

# Установите переменные окружения
echo 'export ANDROID_HOME=~/Android' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/bin' >> ~/.bashrc
source ~/.bashrc
```

## 🍎 macOS

### Установка через Homebrew

```bash
# Java
brew install openjdk@17
sudo ln -sfn $(brew --prefix openjdk@17)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk

# Buildozer зависимости
brew install python3 autoconf automake libtool pkg-config

# Buildozer
pip3 install buildozer Cython virtualenv

# Android SDK
mkdir -p ~/Library/Android/sdk
# Скачайте command-line tools с developer.android.com
# Распакуйте в ~/Library/Android/sdk/

# Настройка переменных окружения
echo 'export ANDROID_HOME=~/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.zshrc
source ~/.zshrc

# Установите SDK компоненты
sdkmanager "platforms;android-31" "build-tools;31.0.0" "ndk;25.1.8937393"
```

## 📋 Чек-лист подготовки

### Перед сборкой убедитесь:

- [ ] Python 3.9+ установлен (`python --version`)
- [ ] Java установлена (`java -version`)
- [ ] Buildozer установлен (`buildozer --version`)
- [ ] ANDROID_HOME переменная установлена
- [ ] Android SDK установлен в ANDROID_HOME
- [ ] Android NDK (v25+) установлен
- [ ] ~5 ГБ свободного места на диске
- [ ] Интернет соединение (для скачивания зависимостей)

### Быстрая проверка (для Windows)

```bash
CHECK_ENVIRONMENT.bat
```

Для Linux/Mac:
```bash
python3 --version
java -version
buildozer --version
echo $ANDROID_HOME
```

## 🚨 Частые ошибки

### "java: command not found"
**Решение**: Установите Java (смотрите выше) или установите JAVA_HOME

### "buildozer: command not found"
**Решение**: `pip install --upgrade buildozer`

### "Android SDK not found"
**Решение**: 
```bash
export ANDROID_HOME=/path/to/android/sdk
export PATH=$PATH:$ANDROID_HOME/tools/bin
```

### "gcc: command not found" (Linux)
**Решение**: 
```bash
sudo apt install build-essential
```

### "Permission denied" (Linux/Mac)
**Часто может помешать Python окружение**:
```bash
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
# или:
venv\Scripts\activate  # Windows
pip install --upgrade -r requirements.txt
```

## 🎯 Когда готово

После установки всех компонентов:

1. Запустите проверку (Windows):
   ```bash
   CHECK_ENVIRONMENT.bat
   ```

2. Или для Linux/Mac проверьте все команды выше

3. Если всё зелено - готово к сборке:
   ```bash
   BUILD_APK.bat  # Windows
   # или buildozer android debug  # Linux/Mac
   ```

## 📞 Если помощь нужна

Смотрите документы в порядке:
1. QUICK_START_APK.md
2. BUILD_APK_GUIDE.md
3. Этот файл для вашей ОС
4. Документация Buildozer на GitHub
