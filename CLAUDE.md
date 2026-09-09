# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Lint / static analysis
flutter analyze

# Regenerate localization files after editing .arb files
flutter gen-l10n

# Build Android release bundle
flutter build appbundle --release
```

There are no test files in this project currently, despite `bloc_test` being listed as a dev dependency.

## Architecture

This is a Flutter mobile game built with the **Flame** game engine (v1.30+). The app targets Android/iOS.

### Screen flow

`SplashScreen` → `HomeScreen` → `MusclesBuilderGameScreen` (a `GameWidget` wrapper) → game over/pause shown as Flutter overlays on top of the Flame canvas.

### Flame game (`lib/games/muscles_builder_game.dart`)

`MusclesBuilderGame extends FlameGame with HasCollisionDetection` is the core game loop. It:
- Receives `ThemeData` and `MusclesBuilderTheme` as constructor arguments because `FlameGame.buildContext` is not reliably available for theming — theme must be passed in at construction time from `MusclesBuilderGameScreen`.
- Holds a reference to `HudGameStatusCubit` to drive score/timer state that the Flutter HUD overlay reads.
- Manages all Flame component lifecycle: joystick, player, viruses, collectibles (dumbbells, protein, vaccine), spawn timers, and collision bounce logic.
- Uses `overlays.add/remove` to show/hide the pause and game-over Flutter screens.

### Flame components (`lib/components/`)

| Component | Role |
|---|---|
| `Player2Component` | Player sprite with 8-direction animation, collision callbacks, vaccination/freeze state |
| `VirusAnimatedComponent` | Bounces around screen; freezes player and decreases score on hit |
| `DumbbellComponent` | Collectible; increases score (light +1, medium +2, heavy +3) |
| `ProteinComponent` | Collectible; grants a random 0–8 bonus score |
| `VaccineComponent` | Collectible; grants 5-second immunity; starts `VaccineTimerBarComponent` |
| `VaccineTimerBarComponent` | Renders a draining timer bar during vaccination |
| `PlayerAnimations` | Encapsulates 8-direction `SpriteAnimation` objects and idle/movement logic |

### State management (Bloc/Cubit)

All cubits live in `lib/cubits/`. Three are app-scoped (provided in `main.dart`):

- `ThemeCubit` — light/dark mode toggle
- `SettingsCubit` — settings screen UI state, delegates persistence to `GameSettingsRepository`
- `GoogleAdsCubit` — loads banner and interstitial ads; interstitial is triggered on exit/quit

One is game-session–scoped (provided in `HomeScreen` before navigation):

- `HudGameStatusCubit` — warmup countdown, exercise timer, score, and protein bonus; consumed by both the Flame game and the `HudGameStatusWidget` overlay

### Data layer

`LocalStorageDatasource` (SharedPreferences) → `GameSettingsRepository` / `GoogleAdsRepository` → registered as lazy singletons via **GetIt** (`serviceLocator`) in `lib/dependencyInjection/application_di.dart`.

Settings persisted: sound on/off, difficulty (easy/medium/hard), exercise time (30s/45s/1min), joystick position (left/right), warmup time (0/3/5s).

### Theme system

`MusclesBuilderTheme` is a `ThemeExtension<MusclesBuilderTheme>` with semantic color slots (background, primaryText, accentText, button, etc.). Access it anywhere in widget code via the `context.musclesBuilderTheme` extension defined in `lib/extensions/muscles_builder_theme_context.dart`. The dark variant is defined inline in `main.dart`.

### Localization

ARB source files are in `lib/l10n/`. Generated Dart files live in `lib/l10n/translations/` — do not edit them by hand. Configuration is in `l10n.yaml`. After editing any `.arb` file run `flutter gen-l10n`.

### Asset conventions

Flame loads images relative to `assets/images/` by default (no path prefix needed in `Globals` sprite path constants). Audio files in `assets/audio/` are similarly loaded by `FlameAudio` without a path prefix. Virus sprite sheets use a numbered-frame naming convention: `virus_low_0.png … virus_low_6.png`.
