# Copdiary Authentication Data Layer - SECTION 2 COMPLETE

## Overview
This document covers the complete implementation of the Authentication Data Layer for the Copdiary Flutter application, following Clean Architecture principles.

## Architecture Flow
```
Presentation → Domain → Data → Remote/Local
     ↓           ↓        ↓          ↓
   BLoC    → UseCase → Repository → DataSources
```

## Completed Components

### 1. Domain Layer (`lib/features/authentication/domain/`)

#### Entities (`entities/user_entity.dart`)
Pure Dart classes representing core business objects:
- **UserEntity**: Core user data without implementation details
  - Properties: userId, username, fullName, buckleNo, mobile, email, designation, policeStation, district, state, profileImage, isVerified, subscriptionStatus, subscriptionExpiry
  - Extends Equatable for value comparison
  - Helper methods: `hasActiveSubscription`, `fullLocation`

#### Repository Interface (`repositories/auth_repository.dart`)
Defines contracts for authentication operations:
- `login()` - Login with username/password → Either<Failure, UserEntity>
- `signup()` - Register new user → Either<Failure, UserEntity>
- `forgotPassword()` - Send OTP to mobile → Either<Failure, void>
- `verifyOtp()` - Verify OTP code → Either<Failure, void>
- `resetPassword()` - Reset password with OTP → Either<Failure, void>
- `changePassword()` - Change password → Either<Failure, void>
- `logout()` - Logout user → Either<Failure, void>
- `getCachedUser()` - Get locally cached user → Either<Failure, UserEntity>
- `isLoggedIn()` - Check login status → Either<Failure, bool>

### 2. Data Layer (`lib/features/authentication/data/`)

#### Models (`data/models/`)
Data models with JSON serialization (extends domain entities):

**user_model.dart**
- Extends UserEntity
- JSON serialization with @JsonSerializable
- Maps API field names (snake_case) to Dart properties
- Generated file: `user_model.g.dart`

**login_request_model.dart**
```dart
{
  "username": "string",
  "password": "string"
}
```

**login_response_model.dart**
```dart
{
  "success": bool,
  "status": "string",
  "message": "string?",
  "datas": {
    "user": UserModel,
    "token": "string?",
    "auth_token": "string?"
  }
}
```

**signup_request_model.dart**
```dart
{
  "username": "string",
  "password": "string",
  "fullname": "string",
  "buckle_no": "string?",
  "mobile": "string",
  "email": "string?",
  "designation": "string?",
  "police_station": "string?",
  "district": "string?",
  "state": "string?"
}
```

**signup_response_model.dart**
- Similar structure to LoginResponseModel
- Contains user data and auth token

#### Remote Data Source (`data/datasources/auth_remote_datasource.dart`)

**Features:**
- Abstract interface: `AuthRemoteDataSource`
- Retrofit implementation: `AuthRemoteDataSourceRetrofit`
- Injectable implementation: `AuthRemoteDataSourceImpl`

**Endpoints:**
- `POST /Api/login_check` - Login
- `POST /api/register` - Signup
- `POST /api/forgot-password` - Forgot password
- `POST /api/verify-otp` - Verify OTP
- `POST /api/reset-password` - Reset password
- `POST /api/user/change-password` - Change password
- `POST /api/logout` - Logout

**Generated file:** `auth_remote_datasource.g.dart`

#### Local Data Source (`data/datasources/auth_local_datasource.dart`)

**Features:**
- Abstract interface: `AuthLocalDataSource`
- Implementation: `AuthLocalDataSourceImpl`
- Uses LocalStorage (SharedPreferences) for general data
- Uses SecureStorage (FlutterSecureStorage) for credentials

**Methods:**
- `cacheUserData()` - Save user to local storage as JSON
- `getCachedUser()` - Retrieve cached user
- `cacheAuthToken()` - Save auth token
- `getAuthToken()` - Get auth token
- `cacheCredentials()` - Save username/password securely (if remember me)
- `getCachedCredentials()` - Get saved credentials
- `setRememberMe()` - Set remember me flag
- `getRememberMe()` - Get remember me flag
- `clearCache()` - Clear all cached data (respects remember me)
- `isLoggedIn()` - Check if user is logged in

**Cached Data:**
- User JSON (SharedPreferences)
- Auth token (SharedPreferences)
- User ID, username, email (SharedPreferences)
- Credentials (FlutterSecureStorage - encrypted)

#### Repository Implementation (`data/repositories/auth_repository_impl.dart`)

**Features:**
- Implements `AuthRepository` interface
- Network connectivity check before API calls
- Automatic error handling and conversion
- Caching of user data and tokens
- Returns `Either<Failure, Success>` using dartz

**Error Handling Flow:**
1. Check network connectivity → NetworkFailure if offline
2. Call remote API
3. Handle exceptions:
   - `ServerException` → `ServerFailure`
   - `NetworkException` → `NetworkFailure`
   - `AuthException` → `AuthFailure`
   - `CacheException` → `CacheFailure`
   - Other → `UnexpectedFailure`
4. Cache successful responses locally
5. Return Either<Failure, Success>

**Special Features:**
- Login/Signup: Caches user + token on success
- Logout: Clears cache (respects remember me for credentials)
- Forgot/Reset/Change Password: Pure API calls
- GetCachedUser: Local-only operation
- IsLoggedIn: Checks both flag and token existence

### 3. Dependency Injection (`lib/features/authentication/di/`)

#### auth_module.dart
- Injectable module for auth feature
- Provides `AuthRemoteDataSourceRetrofit` instance
- Uses Dio from core layer

**All components are automatically registered:**
- AuthRemoteDataSourceImpl
- AuthLocalDataSourceImpl
- AuthRepositoryImpl
- NetworkInfo
- LocalStorage
- SecureStorage

## Project Structure

```
lib/features/authentication/
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   └── repositories/
│       └── auth_repository.dart
├── data/
│   ├── models/
│   │   ├── user_model.dart (+ .g.dart)
│   │   ├── login_request_model.dart (+ .g.dart)
│   │   ├── login_response_model.dart (+ .g.dart)
│   │   ├── signup_request_model.dart (+ .g.dart)
│   │   └── signup_response_model.dart (+ .g.dart)
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart (+ .g.dart)
│   │   └── auth_local_datasource.dart
│   └── repositories/
│       └── auth_repository_impl.dart
└── di/
    └── auth_module.dart
```

## API Integration

### Login Endpoint
**URL:** `POST http://admin.copdiary.com/Api/login_check`

**Request:**
```json
{
  "username": "your_username",
  "password": "your_password"
}
```

**Response:**
```json
{
  "success": true,
  "status": "success",
  "message": "Login successful",
  "datas": {
    "user": {
      "user_id": "123",
      "username": "officer_name",
      "fullname": "Officer Full Name",
      "buckle_no": "12345",
      "mobile": "9876543210",
      "email": "officer@police.gov.in",
      "designation": "Police Inspector",
      "police_station": "City Police Station",
      "district": "Mumbai",
      "state": "Maharashtra",
      "profile_image": "https://...",
      "is_verified": true,
      "subscription_status": "active",
      "subscription_expiry": "2025-12-31"
    },
    "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

## Usage Examples

### 1. Login User

```dart
import 'package:dartz/dartz.dart';
import 'core/di/injection.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';

final authRepository = getIt<AuthRepository>();

// Perform login
final result = await authRepository.login(
  username: 'officer_username',
  password: 'secure_password',
);

// Handle result
result.fold(
  (failure) {
    // Handle failure
    print('Login failed: ${failure.message}');
  },
  (user) {
    // Login successful
    print('Welcome ${user.fullName}!');
    print('User ID: ${user.userId}');
    print('Station: ${user.policeStation}');
  },
);
```

### 2. Signup User

```dart
final result = await authRepository.signup(
  username: 'new_officer',
  password: 'secure_password',
  fullName: 'Officer Full Name',
  buckleNo: '12345',
  mobile: '9876543210',
  email: 'officer@police.gov.in',
  designation: 'Police Constable',
  policeStation: 'City Police Station',
  district: 'Mumbai',
  state: 'Maharashtra',
);

result.fold(
  (failure) => print('Signup failed: ${failure.message}'),
  (user) => print('Account created for ${user.fullName}'),
);
```

### 3. Forgot Password Flow

```dart
// Step 1: Request OTP
final otpResult = await authRepository.forgotPassword(
  mobile: '9876543210',
);

// Step 2: Verify OTP
final verifyResult = await authRepository.verifyOtp(
  mobile: '9876543210',
  otp: '123456',
);

// Step 3: Reset Password
final resetResult = await authRepository.resetPassword(
  mobile: '9876543210',
  otp: '123456',
  newPassword: 'new_secure_password',
);
```

### 4. Change Password

```dart
final result = await authRepository.changePassword(
  userId: currentUser.userId,
  oldPassword: 'old_password',
  newPassword: 'new_password',
);
```

### 5. Logout

```dart
final result = await authRepository.logout();

result.fold(
  (failure) => print('Logout failed: ${failure.message}'),
  (_) => print('Logged out successfully'),
);
```

### 6. Check Login Status

```dart
final result = await authRepository.isLoggedIn();

result.fold(
  (failure) => print('Error checking status'),
  (isLoggedIn) {
    if (isLoggedIn) {
      // Navigate to home
    } else {
      // Navigate to login
    }
  },
);
```

### 7. Get Cached User

```dart
final result = await authRepository.getCachedUser();

result.fold(
  (failure) => print('No cached user'),
  (user) => print('Cached user: ${user.fullName}'),
);
```

## Error Handling

### Failure Types

1. **NetworkFailure** - No internet connection
2. **ServerFailure** - API error (with status code and message)
3. **AuthFailure** - Authentication failed
4. **CacheFailure** - Local storage error
5. **ValidationFailure** - Input validation failed
6. **TimeoutFailure** - Request timeout
7. **UnexpectedFailure** - Unknown error

### Example Error Handling

```dart
result.fold(
  (failure) {
    if (failure is NetworkFailure) {
      showSnackbar('No internet connection');
    } else if (failure is ServerFailure) {
      showSnackbar(failure.message);
    } else if (failure is AuthFailure) {
      showSnackbar('Invalid credentials');
    } else {
      showSnackbar('An error occurred');
    }
  },
  (user) {
    // Success
  },
);
```

## Testing

### Unit Test Example

```dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late AuthRepository authRepository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    authRepository = AuthRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfo,
    );
  });

  group('login', () {
    test('should return UserEntity when login is successful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(any)).thenAnswer(
        (_) async => tLoginResponse,
      );

      // Act
      final result = await authRepository.login(
        username: 'test',
        password: 'test',
      );

      // Assert
      expect(result, equals(Right(tUserEntity)));
      verify(mockLocalDataSource.cacheUserData(any));
      verify(mockLocalDataSource.cacheAuthToken(any));
    });

    test('should return NetworkFailure when device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await authRepository.login(
        username: 'test',
        password: 'test',
      );

      // Assert
      expect(result, equals(const Left(NetworkFailure())));
      verifyNever(mockRemoteDataSource.login(any));
    });
  });
}
```

## Code Generation

The project uses code generation for:
1. **JSON Serialization** - json_serializable
2. **Retrofit API** - retrofit_generator
3. **Dependency Injection** - injectable_generator

### Run Code Generation

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on changes)
flutter pub run build_runner watch --delete-conflicting-outputs

# Clean and rebuild
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## Next Steps

### Section 3: Authentication Use Cases (Domain Layer)
Create use cases for:
- LoginUseCase
- SignupUseCase
- ForgotPasswordUseCase
- LogoutUseCase
- GetCurrentUserUseCase
- etc.

### Section 4: Authentication BLoC (Presentation Layer)
Create BLoC for state management:
- AuthBloc
- AuthEvent
- AuthState
- Login/Signup screens
- Form validation

### Section 5: UI Screens
Create UI for:
- Login screen
- Signup screen
- Forgot password screen
- OTP verification screen

## Important Notes

1. **API Endpoint:** The login endpoint uses `Api/login_check` (with capital 'A') as per Android reference.

2. **Token Handling:** The API may return either `token` or `auth_token`. The code handles both cases.

3. **Remember Me:** When enabled, user credentials are stored securely and persist after logout.

4. **Network Check:** All API calls check network connectivity first to avoid unnecessary errors.

5. **Caching Strategy:**
   - User data and tokens are cached on successful login/signup
   - Cache is cleared on logout (except credentials if remember me is enabled)
   - Cached data is used for offline access

6. **Error Messages:** API error messages are passed through to the UI layer for display.

## Section 2 Status: ✅ COMPLETE

All authentication data layer components are implemented, tested with code generation, and ready for use. The next step is to implement use cases in the domain layer.
