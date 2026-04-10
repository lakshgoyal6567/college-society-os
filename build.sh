#!/bin/bash

# Exit on error
set -e

# Download Flutter using git clone (more reliable on Vercel)
if [ ! -d "flutter" ]; then
    echo "Cloning Flutter SDK..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Add Flutter to path
export PATH="$PATH:$(pwd)/flutter/bin"

# Ensure flutter is initialized
flutter doctor -v

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
