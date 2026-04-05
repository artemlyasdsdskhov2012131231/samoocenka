# 🐳 Docker сборка APK

## 📥 Установить Docker

### Windows 10/11

1. Скачайте [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
2. Запустите установщик
3. Перезагрузитесь
4. Проверьте установку:

```powershell
docker --version
```

---

## 🚀 Шаг 1: Построить Docker образ

Откройте **PowerShell** и вставьте эту команду:

```powershell
cd "d:\анкета состояния 2"
docker build -t samoocenka-builder .
```

⏳ Это займёт 10-15 минут (скачивание образа и зависимостей)

---

## 🔨 Шаг 2: Собрать APK в Docker контейнере

После успешной сборки образа, вставьте эту команду:

```powershell
docker run -v "${PWD}:/app" samoocenka-builder buildozer android debug
```

⏳ Это займёт 15-30 минут

---

## 📁 Шаг 3: Найти готовый APK

После завершения сборки, проверьте папку `bin/`:

```powershell
ls bin/*.apk
```

APK будет в: **`bin/samoocenka-1.0.0-debug.apk`**

---

## 📱 Шаг 4: Установить на телефон

```powershell
adb install bin/samoocenka-1.0.0-debug.apk
```

---

## 🔄 Полные команды (скопируйте целиком)

### Вариант 1: Всё вместе

```powershell
# 1. Перейти в папку проекта
cd "d:\анкета состояния 2"

# 2. Построить образ (первый раз)
docker build -t samoocenka-builder .

# 3. Собрать APK
docker run -v "${PWD}:/app" samoocenka-builder buildozer android debug

# 4. Установить на телефон (если подключён)
adb install bin/samoocenka-1.0.0-debug.apk
```

### Вариант 2: С выводом логов

```powershell
docker run -it -v "${PWD}:/app" samoocenka-builder buildozer android debug
```

Флаг `-it` показывает логи в реальном времени

---

## ⚡ Советы

### Если образ уже построен
Напрямую собирайте APK без `docker build`:
```powershell
docker run -v "${PWD}:/app" samoocenka-builder buildozer android debug
```

### Очистить кэш Docker
```powershell
docker system prune -a
```

### Если хотите заново
```powershell
# Удалить образ
docker rmi samoocenka-builder

# Построить заново
docker build -t samoocenka-builder .
```

### Просмотреть доступные образы
```powershell
docker images
```

### Просмотреть все контейнеры
```powershell
docker ps -a
```

---

## 🐛 Решение проблем

### Ошибка: "docker: command not found"
```powershell
# Docker не установлен
# Скачайте и установите: https://www.docker.com/products/docker-desktop
```

### Ошибка: "Cannot connect to Docker daemon"
```powershell
# Запустите Docker Desktop (нужно открыть приложение)
```

### Ошибка при сборке образа
```powershell
# Может быть проблема с интернетом
# Попробуйте ещё раз
docker build --no-cache -t samoocenka-builder .
```

### APK не создался
1. Проверьте логи сборки (выше всё должно быть видно)
2. Убедитесь что `buildozer.spec` правильный
3. Проверьте что папка `bin/` существует:
```powershell
ls bin/
```

---

## &#10004;️ Преимущества Docker

✅ Не нужно устанавливать ничего локально
✅ Всё работает изолированно
✅ 100% совместимость (Linux окружение)
✅ Можно удалить образ и контейнеры после использования
✅ Работает на Windows/Mac/Linux

---

## 🎯 Готово!

После установки Docker и выполнения команд выше - у вас будет готовый APK! 🎉
