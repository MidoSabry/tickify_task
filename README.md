# Tickify

A Flutter take-home project demonstrating a ticket wallet and ticket verification results with local mock data. The consumer and staff flows share one demo application so reviewers can explore both features from a single entry point.

## Features

- **Ticket wallet:** Upcoming and Past tabs, event information, and Active, Used, or Expired status labels.
- **Wallet states:** Loading indicator, error message, and empty states, with a menu for demonstrating them.
- **Ticket details:** Event information, ticket holder name, and a QR code generated from the ticket ID using `qr_flutter`.
- **Verification results:** Green Valid, amber Already Used with a check-in timestamp, and red Invalid with a reason.
- **Presentation:** Animated scan results, light and dark themes, and accessibility labels on ticket cards, QR codes, and key controls.

No backend, account, API key, or environment file is required. All ticket and verification data is mocked locally.

## Getting started

The project was reviewed with **Flutter 3.47.2 stable** and **Dart 3.13.2**. The Dart SDK constraint is `^3.13.2`.

For the mobile demo, use an Android device or emulator with the Android SDK configured. A camera-capable device or emulator can display the optional scanner preview; result selection is performed through demo buttons.

```sh
git clone https://github.com/MidoSabry/tickify_task.git
cd tickify_task
flutter pub get
flutter run
```

If multiple devices are connected, run `flutter devices`, then use `flutter run -d <device-id>` with the selected device ID.

### Dependency injection code generation

The generated registration file, `lib/core/di/injection_container.config.dart`, is committed, so generation is not needed for the initial run. After changing injectable registrations, run:

```sh
dart run build_runner build
```

## Exploring the demo

| Action                              | Result                                                                            |
| ----------------------------------- | --------------------------------------------------------------------------------- |
| Open the app                        | The wallet displays a loading indicator, then mock tickets.                       |
| Switch between Upcoming and Past    | Tickets are grouped by event date relative to the current local day.              |
| Tap a ticket                        | Opens its details and QR code.                                                    |
| Open the three-dot menu             | Choose Show tickets, Show empty state, or Show error state.                       |
| Select Show tickets                 | Reloads the mock data after a simulated 500 ms delay.                             |
| Tap the theme icon                  | Switches between light and dark mode.                                             |
| Tap Scan demo                       | Opens the scanner preview and three result buttons.                               |
| Tap Valid, Already Used, or Invalid | Opens the corresponding mock verification result. Go back to try another outcome. |

The mock tickets use fixed dates in August through November 2026. The contents of Upcoming and Past therefore depend on the device date; after the final event date, all sample tickets will appear in Past.

## Architecture and decisions

The project uses a feature-first structure with separate presentation, domain, and data layers:

```text
lib/
  core/
    base/           Shared state classes
    di/             Dependency injection setup and generated registrations
    error/          Failure types
    navigation/     Route definitions
    theme/          Colors, themes, and theme controller
    widgets/        Shared text and button widgets
  features/
    ticket_wallet/
      data/         Mock source, ticket model, repository implementation
      domain/       Ticket entity, repository interface, use case
      presentation/ Cubit, screens, and ticket card
    scan_result/
      data/         Mock source and repository implementation
      domain/       Result entity, repository interface, use case
      presentation/ Cubit, screens, and result widgets
  main.dart
```

- **Cubit for feature state:** `TicketWalletCubit` manages loading, success, and failure states. `ScanResultCubit` exposes the selected mock outcome. Cubit fits the small set of actions without a separate event hierarchy.
- **Shared application states:** I created a reusable `BaseState` hierarchy in `core/base` and use it across the application's feature Cubits and shared button widget. It provides common initial, loading, error, and generic `LoadedState<T>` states, along with button enabled, disabled, and loading states. This keeps common state handling consistent and reduces duplicate state definitions across features. Each Cubit still manages its own state independently, and `LoadedState<T>` carries the data type needed by that feature.
- **Shared widgets:** I use reusable widgets in `core/widgets`, including `AppText` for consistent typography and `AppButton` for consistent button styling and enabled, disabled, and loading states. Sharing these components across screens reduces duplicated UI code and makes common design changes easier to maintain.
- **Repository boundaries:** Use cases depend on repository interfaces. Mock sources sit behind their implementations, allowing a future API source to be added without moving data access into widgets.
- **Dependency injection:** `get_it` and `injectable` register sources, repositories, and use cases as lazy singletons, and Cubits as factories. Route-level providers resolve Cubits through the container and manage their lifecycle.
- **Navigation:** `go_router` connects the wallet, details, scanner demo, and results. Selected tickets and result types are passed through route extras.
- **Error handling:** Wallet loading returns `Either<Failure, List<Ticket>>` using `dartz`. The repository converts data-source exceptions into failures for the Cubit to display.
- **Mock verification:** Result selection is synchronous because it reads local fixtures. It demonstrates the result UI rather than validating a scanned ticket or recording a check-in.
- **Theme state:** The current theme toggle uses a `ValueNotifier`. Moving it to a DI-managed Cubit would make application state management consistent with `flutter_bloc`.

## Tests and analysis

```sh
flutter analyze
flutter test
flutter test --coverage
```

The coverage command writes `coverage/lcov.info`.

The current suite contains 11 tests covering:

- Wallet use-case delegation to the repository.
- Wallet Cubit transitions for success, failure, and an empty result.
- Scan-result use cases and Cubit states for all three outcomes.
- A widget smoke test confirming that the app opens the wallet.

The latest local review passed all 11 tests, and static analysis reported no issues. Native camera behavior and iOS execution have not been validated in that review.

## Current limitations

- The scanner displays a camera preview, but scanned barcode values are not connected to verification. Use the three demo buttons to select a result.
- The iOS camera usage description (`NSCameraUsageDescription`) has not yet been configured. Complete the camera setup before trying the scanner on iOS; desktop camera support is not part of this demo.
- The Invalid button currently demonstrates the Wrong event reason. The result model and UI also support Ticket expired, but there is no demo selector for that reason yet.
- Ticket details require a ticket passed through navigation extras; opening that route directly without a ticket is not handled.
- Theme selection and mock data changes are not persisted between app launches.

# Tickify

A Flutter take-home project for exploring a ticket wallet and ticket verification results. The consumer and staff flows are included in one demo app.

## Features

- **Ticket wallet:** Upcoming and Past tabs, ticket details, and Active, Used, or Expired status labels.
- **Wallet states:** Loading, error, and empty states. Use the three-dot menu to preview them.
- **Ticket details:** Event and holder information, plus a QR code generated from the ticket ID with `qr_flutter`.
- **Verification results:** Valid, Already Used, and Invalid result screens.
- **Presentation:** Animated result header, light and dark themes, responsive layouts, and accessibility labels on key widgets.

All ticket and verification data is mocked locally. The app does not require a backend, account, API key, or environment file.

## Getting started

The project was reviewed with Flutter 3.47.2 stable and Dart 3.13.2. The Dart SDK constraint is `^3.13.2`.

For the mobile demo, use an Android device or emulator with the Android SDK configured. The scanner screen can show a camera preview, while the result is selected with demo buttons.

```sh
git clone https://github.com/MidoSabry/tickify_task.git
cd tickify_task
flutter pub get
flutter run
```
