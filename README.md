# CompassApp

A fun little app that points you with a compass toward the nearest amenity.

## Project structure

This is a Flutter monorepo using Dart workspaces. The packages are laid out like this:

```
packages/
  app/
    random_compass_app/    # The main Flutter app
  features/
    compass/               # Compass feature
    home/                  # Home screen feature
  utilities/
    app_state/             # App-wide state management
    location_service/      # Location handling
    permission_service/    # Permission handling
```

## Getting set up

### 1. Install FVM

We use [FVM](https://fvm.app/) to pin the Flutter version. If you don't have it yet:

```bash
dart pub global activate fvm
```

### 2. Install the right Flutter version

From the project root, run:

```bash
fvm install
```

This reads the `.fvmrc` file and pulls down Flutter **3.41.2** (or whatever version is pinned at the time).

Make sure you're using the FVM version going forward — either prefix commands with `fvm flutter` / `fvm dart`, or set your IDE to use the FVM SDK path (`.fvm/flutter_sdk`).

### 3. Grab dependencies

```bash
fvm flutter pub get
```

Because this is a Dart workspace, that single command resolves dependencies for every package in the repo.

### 4. Activate Melos

Melos is listed as a dev dependency, so you can run it via `dart run`:

```bash
fvm dart run melos bootstrap
```

Or if you'd rather have the `melos` command available globally:

```bash
fvm dart pub global activate melos
```

### 5. Run code generation

Some packages use `build_runner` (e.g. auto_route). Generate the necessary files with:

```bash
fvm dart run melos run build_runner:all
```

### 6. Run the app

```bash
fvm flutter run
```

## Running tests

To run tests across all packages that have them:

```bash
fvm dart run melos run test
```

This kicks off `flutter test` in every package that contains a `test/` directory.

## Other useful commands

**Analyze all packages:**

```bash
fvm dart run melos run analyze
```

**Format everything:**

```bash
fvm dart run melos run format
```

You can see all available melos scripts in the root `pubspec.yaml` under the `melos:` section.
