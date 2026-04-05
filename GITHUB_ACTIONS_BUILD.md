# ☁️ Облачная сборка APK через GitHub Actions

**GitHub Actions** будут строить APK автоматически в облаке (бесплатно!)

## 🚀 Как использовать

### 1️⃣ Загрузить проект на GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/samoocenka.git
git push -u origin main
```

### 2️⃣ GitHub Actions начнёт автоматическую сборку

Посетите: `https://github.com/YOUR_USERNAME/samoocenka/actions`

Вы увидите сборку в процессе! ✅

### 3️⃣ Скачать готовый APK

После успешной сборки:
1. Откройте вкладку **Actions**
2. Найдите **Build APK** (самый свежий)
3. Нажмите на него
4. Скачайте артефакт **samoocenka-apk**
5. Распакуйте и установите на телефон

## 📱 Установка на телефон

```bash
adb install samoocenka-1.0.0-debug.apk
```

Или просто передайте файл на телефон и откройте!

## 🔄 Автоматические сборки

Сборка запустится когда:
- ✅ Вы запушите код на GitHub
- ✅ Создадите Pull Request
- ✅ Вручную нажимаете "Run workflow" в Actions

## 📝 Что происходит внутри

GitHub Actions:
1. Запускает Linux VM
2. Устанавливает Java, Python, Android SDK
3. Запускает `buildozer android debug`
4. Создаёт APK
5. Загружает его как артефакт

**Всё это бесплатно и занимает ~30 минут!**

## ✅ Готово?

Если у вас есть GitHub аккаунт:
1. Выложите проект на GitHub
2. GitHub Actions автоматически начнёт сборку
3. Скачайте готовый APK

**Это работает на 100% - проблемы с локальной машиной не будут мешать!**
