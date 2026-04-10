#!/bin/bash

# Exit on error
set -e

# Define Flutter version
FLUTTER_VERSION="3.24.0"

# Download Flutter
if [ ! -d "flutter" ]; then
    echo "Downloading Flutter..."
    curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
    tar xf flutter.tar.xz
    rm flutter.tar.xz
fi

# Add Flutter to path
export PATH="$PATH:$(pwd)/flutter/bin"

# Pre-download artifacts
flutter config --no-analytics
flutter precache --web

# Build for Web
echo "Building Flutter Web..."
flutter build web --release

echo "Build complete."
