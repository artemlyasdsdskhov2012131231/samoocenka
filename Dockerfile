FROM ubuntu:22.04

# Установить зависимости
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3-pip \
    openjdk-11-jdk \
    android-sdk \
    android-sdk-build-tools \
    android-sdk-platform-tools \
    automake \
    autoconf \
    libtool \
    pkg-config \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    libncurses5-dev \
    git \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Установить Android NDK
RUN mkdir -p /opt/android && \
    cd /opt/android && \
    wget -q https://dl.google.com/android/repository/android-ndk-r25b-linux.zip && \
    unzip -q android-ndk-r25b-linux.zip && \
    rm android-ndk-r25b-linux.zip

# Установить переменные окружения
ENV ANDROID_HOME=/opt/android/android-ndk-r25b
ENV ANDROID_SDK_ROOT=/opt/android
ENV PATH=$PATH:$ANDROID_HOME/bin
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Установить buildozer и зависимости
RUN pip3 install --upgrade pip && \
    pip3 install buildozer cython

# Рабочая директория
WORKDIR /app

# Команда по умолчанию
CMD ["buildozer", "android", "debug"]
