# 📱 Muscles Builder

A fun and engaging Flutter game where players dodge viruses and collect dumbbells to achieve the highest score.

## 🚀 Getting Started

Muscles Builder is a fast, lightweight mobile game built with Flutter and Flame. Players maneuver around viruses, pick up energy items, and increase their score while facing gradually increasing difficulty.

## 🎮 Features

List the key features your app provides.

- Smooth gameplay at 60 FPS 
- Sprite-based animations using Flame 
- Localized UI 
- State management using Bloc / Cubit 
- Offline support 
- Custom player & virus animations 
- Energy drinks for bonus points 
- Virus protection drink (temporary shield)
- Adjustable difficulty levels 
- Joystick position selection 
- Audio enable/disable toggle 
- Auto-saving settings

## 🛠️ Tech Stack

### Frontend / App:

- Flutter (≥ X.X.X)
- Dart (≥ X.X.X)
- Flutter Bloc
- Shared preferences
- Intl
- GetIt (dependency injection)

### Game Engine:

- Flame 
- Flame Components / Collisions 
- SpriteAnimationComponent

### Tools:

- Localization via ARB files

## 📦 Installation
### Prerequisites

- Flutter SDK installed
- Dart installed
- Android Studio / Xcode for building

### Clone the project
```shell
git clone https://github.com/FaaiqKhan/muscles_builder
cd yourproject
```

### Install dependencies
```shell
flutter pub get
```

### Run
```shell
flutter run
```

🌍 Localization

The app uses **flutter_localizations** and `.arb` files for translations.
- Using .arb files located in /lib/l10n
- Run Flutter localization tool:
```shell
flutter gen-l10n
```

Using .arb files located in /l10n

Run Flutter localization tool:

🔥 Production Build

### Android

```shell
flutter build appbundle --release
```

## 📤 Deployment & Releases

Currently, deployments are done manually to the Google Play Store.

## ✨ Roadmap

- Add environment setup (development, production)
- Add GitHub Actions for CI/CD 
- Introduce Fastlane for automated releases

## 📄 License

Specify the license here (MIT, Apache 2.0, custom, etc.)