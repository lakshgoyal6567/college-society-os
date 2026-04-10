#!/bin/bash

# Exit on error
set -e

# Define Flutter version
FLUTTER_VERSION="3.38.7"

# Download Flutter
if [ ! -d "flutter" ]; then
    echo "Downloading Flutter..."
    curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
    tar xf flutter.tar.xz
    rm flutter.tar.xz
fi

# Add Flutter to path
export PATH="$PATH:$(pwd)/flutter/bin"

# Fix for git dubious ownership in Vercel
git config --global --add safe.directory "*"

# Pre-download artifacts
flutter config --no-analytics
flutter precache --web

# Build for Web with Environment Variables
echo "Building Flutter Web..."
flutter build web --release \
    --dart-define=FIREBASE_API_KEY_WEB=$FIREBASE_API_KEY_WEB \
    --dart-define=FIREBASE_APP_ID_WEB=$FIREBASE_APP_ID_WEB \
    --dart-define=FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID \
    --dart-define=FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID \
    --dart-define=FIREBASE_AUTH_DOMAIN=$FIREBASE_AUTH_DOMAIN \
    --dart-define=FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET \
    --dart-define=FIREBASE_MEASUREMENT_ID=$FIREBASE_MEASUREMENT_ID

echo "Build complete."
