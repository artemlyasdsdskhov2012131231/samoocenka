# 🚀 Выложить на GitHub и включить GitHub Actions

## 📋 Пошагово (5 минут)

### Шаг 1: Создать GitHub аккаунт (если нет)
- Откройте https://github.com/signup
- Заполните данные
- Подтвердите email

### Шаг 2: Создать репозиторий

1. Откройте https://github.com/new
2. Назовите репозиторий: **samoocenka**
3. Описание (опционально): **Samoocenka - Psychological self-assessment app**
4. Выберите **Public** (чтобы все видели)
5. Нажмите **Create repository**

### Шаг 3: Загрузить код на GitHub

Откройте PowerShell и выполните:

```bash
# Перейти в папку проекта
cd "d:\анкета состояния 2"

# Инициализировать Git репозиторий
git init

# Добавить все файлы
git add .

# Сделать первый коммит
git commit -m "Initial commit: Samoocenka app"

# Переименовать ветку на main (если нужно)
git branch -M main

# Добавить удалённый репозиторий (замените YOUR_USERNAME на ваш username)
git remote add origin https://github.com/YOUR_USERNAME/samoocenka.git

# Загрузить код на GitHub
git push -u origin main
```

### Шаг 4: GitHub Actions автоматически начнёт сборку!

1. Откройте вкладку **Actions** на GitHub
2. Вы увидите **Build APK** в процессе
3. Подождите 15-30 минут
4. Когда галочка ✅ - сборка успешна!

### Шаг 5: Скачать готовый APK

1. Откройте **Actions** → **Build APK** (свежий)
2. В разделе **Artifacts** нажмите **samoocenka-apk**
3. Распакуйте ZIP и установите APK на телефон:

```bash
adb install samoocenka-1.0.0-debug.apk
```

---

## 🔄 Автоматические сборки в будущем

Каждый раз, когда вы делаете `git push`:
- ✅ GitHub Actions автоматически собирать APK
- ✅ АПК будет доступен в Actions артефактах
- ✅ Вы всегда можете скачать свежий апк

---

## ⚡ Если что-то не работает

### Ошибка: Permission denied
```bash
# Проверьте что Git установлен:
git --version

# Если Git не установлен - скачайте:
# https://git-scm.com/download/win
```

### Ошибка при push
```bash
# Может потребоваться авторизация GitHub:
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

# Или используйте SSH ключ:
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh
```

### Сборка не запускается
- Проверьте что `.github/workflows/build-apk.yml` загружен
- Откройте вкладку **Actions** и нажмите **Run workflow**

---

## 📱 Установка APK на телефон

**Способ 1: Через adb (USB)**
```bash
adb install samoocenka-1.0.0-debug.apk
```

**Способ 2: Вручную**
1. Передайте APK на телефон (Email, Bluetooth, облако)
2. Откройте на телефоне
3. Разрешите установку

---

## ✅ После выполнения:

- ✅ Код на GitHub
- ✅ GitHub Actions собирает APK автоматически
- ✅ АПК готов к установке на телефон
- ✅ Следующие обновления будут автоматическими

**Успехов!** 🎉
