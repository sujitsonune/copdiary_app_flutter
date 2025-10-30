# Copdiary Core Layer Setup - SECTION 1 COMPLETE

## Overview
This document provides an overview of the Core Layer infrastructure that has been set up for the Copdiary Flutter application.

## Architecture
The project follows **Clean Architecture** with BLoC state management pattern:
- **Data Layer** → **Domain Layer** → **Presentation Layer**

## Completed Components

### 1. Constants (`lib/core/constants/`)

#### `api_constants.dart`
- Base URL configuration: `http://admin.copdiary.com/`
- API endpoint definitions for all features
- Timeout configurations (30 seconds)
- Header constants

#### `app_constants.dart`
- Storage keys for SharedPreferences and SecureStorage
- Pagination settings
- Date/time format patterns
- Language codes (English, Marathi, Hindi)
- Regex patterns for validation
- Error messages

### 2. Network Layer (`lib/core/network/`)

#### `api_client.dart`
- **Features:**
  - Dio-based HTTP client with base configuration
  - Automatic auth token injection via interceptor
  - Request/response logging interceptor
  - Error handling interceptor
  - Support for GET, POST, PUT, DELETE, PATCH methods
  - Automatic conversion of Dio errors to custom exceptions
  - 30-second timeout for requests

#### `network_info.dart`
- **Features:**
  - Real-time connectivity monitoring using `connectivity_plus`
  - Stream-based connectivity status updates
  - Supports mobile, WiFi, ethernet, and VPN connections
  - Abstract interface for easy testing

### 3. Storage Layer (`lib/core/storage/`)

#### `local_storage.dart`
- **Features:**
  - SharedPreferences wrapper for local data persistence
  - Type-safe methods for String, int, double, bool, List<String>
  - Error handling with CacheException
  - Methods: save, get, remove, clear, containsKey, getAllKeys, reload

#### `secure_storage.dart`
- **Features:**
  - FlutterSecureStorage wrapper for sensitive data
  - Encrypted storage for passwords, tokens
  - Methods: write, read, delete, deleteAll, readAll, containsKey
  - Android: Uses encrypted shared preferences

### 4. Error Handling (`lib/core/error/`)

#### `exceptions.dart`
Custom exceptions for the data layer:
- `ServerException` - Server errors with status codes
- `NetworkException` - No internet connection
- `CacheException` - Local storage failures
- `AuthException` - Authentication failures
- `ValidationException` - Validation errors
- `TimeoutException` - Request timeouts

#### `failures.dart`
Domain layer failures extending Equatable:
- `ServerFailure`
- `NetworkFailure`
- `CacheFailure`
- `AuthFailure`
- `ValidationFailure`
- `TimeoutFailure`
- `UnexpectedFailure`

### 5. Theme (`lib/core/theme/`)

#### `app_theme.dart`
- **Primary Colors:**
  - Primary: Police Blue (#1565C0)
  - Primary Dark: #0D47A1
  - Primary Light: #42A5F5
  - Accent: Orange (#FFA726)
  - Secondary: Dark Grey (#424242)

- **Comprehensive Theme Configuration:**
  - AppBar theme with police blue
  - Card theme with elevation and rounded corners
  - Input decoration theme with outlined borders
  - Button themes (Elevated, Outlined, Text)
  - Bottom navigation theme
  - Dialog theme
  - Chip theme
  - Text theme supporting Marathi and English
  - Status colors (success, error, warning, info)

### 6. Dependency Injection (`lib/core/di/`)

#### `injection.dart`
- **Setup using:**
  - `get_it` for service locator
  - `injectable` for code generation
  - Registers external dependencies:
    - SharedPreferences
    - FlutterSecureStorage (with encrypted preferences)
    - Connectivity

- **Usage:** Call `configureDependencies()` in `main.dart` before `runApp()`

### 7. Dependencies (`pubspec.yaml`)

#### State Management
- flutter_bloc ^8.1.6
- equatable ^2.0.5

#### Dependency Injection
- get_it ^7.7.0
- injectable ^2.4.4

#### Networking
- dio ^5.8.0+1
- retrofit ^4.4.1
- json_annotation ^4.9.0

#### Storage
- shared_preferences ^2.3.2
- flutter_secure_storage ^9.2.2
- connectivity_plus ^6.0.5

#### Navigation
- go_router ^14.3.0

#### Firebase
- firebase_core ^3.6.0
- firebase_messaging ^15.1.3
- firebase_analytics ^11.3.3
- firebase_dynamic_links ^6.0.8

#### Payments
- razorpay_flutter ^1.3.7

#### UI Components
- flutter_svg, cached_network_image, shimmer
- flutter_spinkit, fluttertoast, lottie

#### Utilities
- intl, dartz, logger, uuid
- image_picker, image_cropper
- permission_handler, url_launcher
- geolocator, path_provider, file_picker
- pdf, printing

#### Dev Dependencies
- build_runner, code generators
- flutter_lints, testing tools

## Project Structure

```
lib/
└── core/
    ├── constants/
    │   ├── api_constants.dart
    │   └── app_constants.dart
    ├── network/
    │   ├── api_client.dart
    │   └── network_info.dart
    ├── storage/
    │   ├── local_storage.dart
    │   └── secure_storage.dart
    ├── error/
    │   ├── exceptions.dart
    │   └── failures.dart
    ├── theme/
    │   └── app_theme.dart
    └── di/
        └── injection.dart
```

## Next Steps

### To run the project:

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate dependency injection code:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Update `main.dart`** to initialize dependencies:
   ```dart
   import 'package:flutter/material.dart';
   import 'core/di/injection.dart';
   import 'core/theme/app_theme.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();

     // Initialize dependencies
     await configureDependencies();

     runApp(const MyApp());
   }

   class MyApp extends StatelessWidget {
     const MyApp({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Copdiary',
         theme: AppTheme.lightTheme,
         home: // Your home screen
       );
     }
   }
   ```

4. **Create assets folders** (already created):
   - `assets/images/`
   - `assets/icons/`
   - `assets/animations/`

5. **Optional: Download Noto Sans fonts** for Marathi support:
   - Download from Google Fonts
   - Place in `assets/fonts/`
   - Uncomment font section in `pubspec.yaml`

## Testing the Core Layer

### Example: Using API Client
```dart
final apiClient = getIt<ApiClient>();

// GET request
final response = await apiClient.get('api/user/profile');

// POST request
final loginResponse = await apiClient.post(
  'api/login',
  data: {'email': 'test@example.com', 'password': 'password'},
);
```

### Example: Using Local Storage
```dart
final localStorage = getIt<LocalStorage>();

// Save data
await localStorage.saveString('auth_token', 'your_token');
await localStorage.saveBool('is_logged_in', true);

// Get data
final token = await localStorage.getString('auth_token');
final isLoggedIn = await localStorage.getBool('is_logged_in');
```

### Example: Using Secure Storage
```dart
final secureStorage = getIt<SecureStorage>();

// Save sensitive data
await secureStorage.write('password', 'user_password');

// Read sensitive data
final password = await secureStorage.read('password');
```

### Example: Checking Network Connectivity
```dart
final networkInfo = getIt<NetworkInfo>();

// Check connection
final isConnected = await networkInfo.isConnected;

// Listen to changes
networkInfo.onConnectivityChanged.listen((isConnected) {
  print('Connected: $isConnected');
});
```

## Important Notes

1. **Security:**
   - Replace `YOUR_RAZORPAY_KEY` in `app_constants.dart` with actual key
   - Never commit sensitive keys to version control
   - Use environment variables for production keys

2. **Code Generation:**
   - Run build_runner after adding new injectable classes
   - The `injection.config.dart` file will be auto-generated

3. **Error Handling:**
   - All network errors are automatically converted to typed exceptions
   - Use try-catch blocks to handle exceptions appropriately
   - Convert exceptions to failures in the repository layer

4. **Theme:**
   - The police blue theme is ready to use
   - Dark theme is defined but not fully configured
   - Customize colors in `app_theme.dart` as needed

## Section 1 Status: ✅ COMPLETE

All core infrastructure components are implemented and ready to use. You can now proceed to Section 2 (Authentication feature implementation).
