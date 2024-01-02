#!/bin/bash

NO_INSTALL_OS=$1

if [ ! $NO_INSTALL_OS ]
then
    apt update
    apt install file libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev android-sdk -y
fi

if [ ! $(echo $ANDROID_HOME) ]
then
    echo 'export ANDROID_HOME=/usr/lib/android-sdk' >> ~/.bashrc
    echo "restart bash to get ANDROID_HOME env var"
fi

if [ ! $(which sdkmanager) ]
then
    wget -P ~/ "https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip"
    unzip ~/commandlinetools-linux-10406996_latest.zip
    CMD_LINE_TOOLS_ROOT="$ANDROID_HOME/cmdline-tools/latest"
    mkdir -p $CMD_LINE_TOOLS_ROOT
    mv ~/cmdline-tools/ $CMD_LINE_TOOLS_ROOT
    echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/cmdline-tools/bin' >> ~/.bashrc
    echo 'refresh bash to get sdkmanager'
fi

if [ ! $(which flutter) ]
then
    wget -P ~/ https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_4.16.5-stable.tar.xz
    tar xf ~/flutter_linux_4.16.5-stable.tar.xz -C ~/
    echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
    echo "refresh the bash shell to get flutter"
fi

if [ ! $(echo $CHROME_EXECUTABLE) ]
then
    wget -P ~/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd65.deb
    dpkg -i ~/google-chrome-stable_current_amd64.deb
    apt --fix-broken install
fi

flutter doctor

#flutter config --android-sdk