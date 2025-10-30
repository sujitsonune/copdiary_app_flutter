# Copdiary Authentication Domain Layer - SECTION 3 COMPLETE

## Overview
This document covers the complete implementation of the Authentication Domain Layer (Business Logic) for the Copdiary Flutter application, following Clean Architecture principles.

## Domain Layer Architecture

```
Domain Layer (Business Logic)
├── Entities (Pure Dart objects)
├── Repositories (Interfaces/Contracts)
└── UseCases (Business rules & validation)
```

## Completed Components

### 1. Core UseCase Base Classes (`lib/core/usecases/usecase.dart`)

Abstract base classes for all use cases:

**UseCase<Type, Params>**
- Generic use case with return type and parameters
- Returns: `Future<Either<Failure, Type>>`

**UseCaseNoParams<Type>**
- Use case without parameters
- Returns: `Future<Either<Failure, Type>>`

**UseCaseVoid<Params>**
- Use case that doesn't return data
- Returns: `Future<Either<Failure, void>>`

**UseCaseVoidNoParams**
- No parameters, no return data
- Returns: `Future<Either<Failure, void>>`

**NoParams**
- Marker class for use cases without parameters

### 2. Authentication Use Cases

#### 📝 LoginUseCase (`lib/features/authentication/domain/usecases/login_usecase.dart`)

**Purpose:** Validates credentials and performs login

**Parameters:** `LoginParams`
- `username` (required)
- `password` (required)
- `rememberMe` (optional, default: false)

**Validations:**
1. ✅ Username not empty
2. ✅ Password not empty
3. ✅ Password minimum 6 characters
4. ✅ Username format (alphanumeric + underscore)

**Returns:** `Either<Failure, UserEntity>`

**Usage:**
```dart
final result = await loginUseCase(
  LoginParams(
    username: 'officer_name',
    password: 'secure_password',
    rememberMe: true,
  ),
);
```

---

#### 📝 SignupUseCase (`lib/features/authentication/domain/usecases/signup_usecase.dart`)

**Purpose:** Validates registration data and creates new account

**Parameters:** `SignupParams`
- `username` (required)
- `password` (required)
- `fullName` (required)
- `mobile` (required)
- `buckleNo` (optional)
- `email` (optional)
- `designation` (optional)
- `policeStation` (optional)
- `district` (optional)
- `state` (optional)

**Validations:**
1. ✅ Username: not empty, alphanumeric, min 3 characters
2. ✅ Password: not empty, min 8 characters with letters & numbers
3. ✅ Full name: not empty
4. ✅ Mobile: not empty, 10 digits
5. ✅ Email: valid format (if provided)
6. ✅ Buckle number: min 3 characters (if provided)

**Returns:** `Either<Failure, UserEntity>`

**Usage:**
```dart
final result = await signupUseCase(
  SignupParams(
    username: 'new_officer',
    password: 'SecurePass123',
    fullName: 'Officer Name',
    mobile: '9876543210',
    email: 'officer@police.gov.in',
    buckleNo: '12345',
    designation: 'Constable',
    policeStation: 'City Station',
    district: 'Mumbai',
    state: 'Maharashtra',
  ),
);
```

---

#### 📝 LogoutUseCase (`lib/features/authentication/domain/usecases/logout_usecase.dart`)

**Purpose:** Clears local cache and logs out user

**Parameters:** None

**Actions:**
1. Calls remote logout API (best effort)
2. Clears auth token from local storage
3. Clears user data from cache
4. Preserves credentials if remember me is enabled

**Returns:** `Either<Failure, void>`

**Usage:**
```dart
final result = await logoutUseCase();

result.fold(
  (failure) => print('Logout failed: ${failure.message}'),
  (_) => print('Logged out successfully'),
);
```

---

#### 📝 GetCurrentUserUseCase (`lib/features/authentication/domain/usecases/get_current_user_usecase.dart`)

**Purpose:** Retrieves currently logged-in user from cache

**Parameters:** None

**Returns:** `Either<Failure, UserEntity>`

**Usage:**
```dart
final result = await getCurrentUserUseCase();

result.fold(
  (failure) => print('No user found'),
  (user) => print('Current user: ${user.fullName}'),
);
```

---

#### 📝 CheckLoginStatusUseCase (`lib/features/authentication/domain/usecases/check_login_status_usecase.dart`)

**Purpose:** Checks if user is currently logged in

**Parameters:** None

**Returns:** `Either<Failure, bool>`

**Usage:**
```dart
final result = await checkLoginStatusUseCase();

result.fold(
  (failure) => navigateToLogin(),
  (isLoggedIn) {
    if (isLoggedIn) {
      navigateToHome();
    } else {
      navigateToLogin();
    }
  },
);
```

---

#### 📝 ForgotPasswordUseCase (`lib/features/authentication/domain/usecases/forgot_password_usecase.dart`)

**Purpose:** Sends OTP to mobile for password reset

**Parameters:** `ForgotPasswordParams`
- `mobile` (required)

**Validations:**
1. ✅ Mobile not empty
2. ✅ Mobile format (10 digits)

**Returns:** `Either<Failure, void>`

**Usage:**
```dart
final result = await forgotPasswordUseCase(
  ForgotPasswordParams(mobile: '9876543210'),
);
```

---

#### 📝 VerifyOtpUseCase (`lib/features/authentication/domain/usecases/verify_otp_usecase.dart`)

**Purpose:** Verifies OTP sent to mobile

**Parameters:** `VerifyOtpParams`
- `mobile` (required)
- `otp` (required)

**Validations:**
1. ✅ Mobile not empty, valid format
2. ✅ OTP not empty
3. ✅ OTP length (4-6 digits)
4. ✅ OTP format (digits only)

**Returns:** `Either<Failure, void>`

**Usage:**
```dart
final result = await verifyOtpUseCase(
  VerifyOtpParams(
    mobile: '9876543210',
    otp: '123456',
  ),
);
```

---

#### 📝 ResetPasswordUseCase (`lib/features/authentication/domain/usecases/reset_password_usecase.dart`)

**Purpose:** Resets password after OTP verification

**Parameters:** `ResetPasswordParams`
- `mobile` (required)
- `otp` (required)
- `newPassword` (required)
- `confirmPassword` (required)

**Validations:**
1. ✅ Mobile not empty, valid format
2. ✅ OTP not empty
3. ✅ New password not empty
4. ✅ Password strength (min 8 characters with letters & numbers)
5. ✅ Passwords match

**Returns:** `Either<Failure, void>`

**Usage:**
```dart
final result = await resetPasswordUseCase(
  ResetPasswordParams(
    mobile: '9876543210',
    otp: '123456',
    newPassword: 'NewSecure123',
    confirmPassword: 'NewSecure123',
  ),
);
```

---

#### 📝 ChangePasswordUseCase (`lib/features/authentication/domain/usecases/change_password_usecase.dart`)

**Purpose:** Changes password for logged-in user

**Parameters:** `ChangePasswordParams`
- `userId` (required)
- `oldPassword` (required)
- `newPassword` (required)
- `confirmPassword` (required)

**Validations:**
1. ✅ User ID not empty
2. ✅ Old password not empty
3. ✅ New password not empty
4. ✅ New password different from old password
5. ✅ Password strength (min 8 characters with letters & numbers)
6. ✅ Passwords match

**Returns:** `Either<Failure, void>`

**Usage:**
```dart
final result = await changePasswordUseCase(
  ChangePasswordParams(
    userId: currentUser.userId,
    oldPassword: 'OldPass123',
    newPassword: 'NewSecure456',
    confirmPassword: 'NewSecure456',
  ),
);
```

---

## Project Structure

```
lib/
├── core/
│   └── usecases/
│       └── usecase.dart (Base classes)
└── features/
    └── authentication/
        └── domain/
            ├── entities/
            │   └── user_entity.dart ✓ (From Section 2)
            ├── repositories/
            │   └── auth_repository.dart ✓ (From Section 2)
            └── usecases/
                ├── login_usecase.dart ✓
                ├── signup_usecase.dart ✓
                ├── logout_usecase.dart ✓
                ├── get_current_user_usecase.dart ✓
                ├── check_login_status_usecase.dart ✓
                ├── forgot_password_usecase.dart ✓
                ├── verify_otp_usecase.dart ✓
                ├── reset_password_usecase.dart ✓
                └── change_password_usecase.dart ✓
```

## Use Case Features

### ✅ Comprehensive Validation
Every use case includes business rule validation:
- Input format validation
- Length validation
- Pattern matching (email, phone, password)
- Custom business rules

### ✅ Clean Separation of Concerns
- **Domain Layer:** Pure business logic (no framework dependencies)
- **Data Layer:** Implementation details (API, database)
- **Presentation Layer:** UI logic (BLoC, widgets)

### ✅ Type Safety
- All parameters use strongly-typed classes
- Equatable for value comparison
- Immutable parameter objects

### ✅ Error Handling
- Returns `Either<Failure, Success>` using dartz
- ValidationFailure for input errors
- ServerFailure, NetworkFailure, etc. for system errors

### ✅ Dependency Injection
- All use cases registered with @lazySingleton
- Auto-injected repository dependencies
- Easy to test with mock repositories

### ✅ Testability
- Pure functions without side effects
- Repository interface for mocking
- Parameter classes for test data builders

## Validation Rules Summary

### Username
- ✅ Not empty
- ✅ Alphanumeric + underscore only
- ✅ Minimum 3 characters (signup)

### Password
- ✅ Not empty
- ✅ Minimum 6 characters (login)
- ✅ Minimum 8 characters with letters & numbers (signup, change)

### Mobile
- ✅ Not empty
- ✅ Exactly 10 digits
- ✅ Pattern: `^[0-9]{10}$`

### Email
- ✅ Valid email format (if provided)
- ✅ Pattern: `^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$`

### OTP
- ✅ Not empty
- ✅ 4-6 digits
- ✅ Digits only

### Buckle Number
- ✅ Minimum 3 characters (if provided)

## Usage Examples

### Complete Login Flow

```dart
import 'package:dartz/dartz.dart';
import 'core/di/injection.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';

class LoginScreen extends StatelessWidget {
  final LoginUseCase loginUseCase = getIt<LoginUseCase>();

  Future<void> handleLogin(String username, String password) async {
    // Create parameters
    final params = LoginParams.fromForm(
      username: username,
      password: password,
      rememberMe: true,
    );

    // Execute use case
    final result = await loginUseCase(params);

    // Handle result
    result.fold(
      (failure) {
        // Handle failure
        if (failure is ValidationFailure) {
          showError('Validation Error: ${failure.message}');
        } else if (failure is NetworkFailure) {
          showError('No internet connection');
        } else if (failure is ServerFailure) {
          showError('Login failed: ${failure.message}');
        }
      },
      (user) {
        // Login successful
        print('Welcome ${user.fullName}!');
        navigateToHome();
      },
    );
  }
}
```

### Complete Signup Flow

```dart
final SignupUseCase signupUseCase = getIt<SignupUseCase>();

Future<void> handleSignup(Map<String, String> formData) async {
  // Create parameters from form
  final params = SignupParams.fromForm(
    username: formData['username']!,
    password: formData['password']!,
    fullName: formData['fullName']!,
    mobile: formData['mobile']!,
    email: formData['email'],
    buckleNo: formData['buckleNo'],
    designation: formData['designation'],
    policeStation: formData['policeStation'],
    district: formData['district'],
    state: formData['state'],
  );

  // Execute use case
  final result = await signupUseCase(params);

  result.fold(
    (failure) => showError(failure.message),
    (user) {
      showSuccess('Account created successfully!');
      navigateToHome();
    },
  );
}
```

### Forgot Password Flow

```dart
final ForgotPasswordUseCase forgotPasswordUseCase = getIt<ForgotPasswordUseCase>();
final VerifyOtpUseCase verifyOtpUseCase = getIt<VerifyOtpUseCase>();
final ResetPasswordUseCase resetPasswordUseCase = getIt<ResetPasswordUseCase>();

// Step 1: Request OTP
Future<void> requestOtp(String mobile) async {
  final result = await forgotPasswordUseCase(
    ForgotPasswordParams(mobile: mobile),
  );

  result.fold(
    (failure) => showError(failure.message),
    (_) => showSuccess('OTP sent to $mobile'),
  );
}

// Step 2: Verify OTP
Future<void> verifyOtp(String mobile, String otp) async {
  final result = await verifyOtpUseCase(
    VerifyOtpParams(mobile: mobile, otp: otp),
  );

  result.fold(
    (failure) => showError(failure.message),
    (_) {
      showSuccess('OTP verified');
      navigateToResetPassword();
    },
  );
}

// Step 3: Reset Password
Future<void> resetPassword(String mobile, String otp, String newPassword) async {
  final result = await resetPasswordUseCase(
    ResetPasswordParams(
      mobile: mobile,
      otp: otp,
      newPassword: newPassword,
      confirmPassword: newPassword,
    ),
  );

  result.fold(
    (failure) => showError(failure.message),
    (_) {
      showSuccess('Password reset successfully');
      navigateToLogin();
    },
  );
}
```

## Testing Use Cases

### Unit Test Example

```dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    test('should return ValidationFailure when username is empty', () async {
      // Arrange
      final params = LoginParams(username: '', password: 'password');

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<Left<ValidationFailure, UserEntity>>());
      verifyNever(mockRepository.login(username: any, password: any));
    });

    test('should return UserEntity when login is successful', () async {
      // Arrange
      final params = LoginParams(
        username: 'officer',
        password: 'password123',
      );
      when(mockRepository.login(username: any, password: any))
          .thenAnswer((_) async => Right(tUserEntity));

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, equals(Right(tUserEntity)));
      verify(mockRepository.login(
        username: 'officer',
        password: 'password123',
      ));
    });

    test('should return ValidationFailure for invalid username format', () async {
      // Arrange
      final params = LoginParams(
        username: 'officer@123!',  // Invalid characters
        password: 'password',
      );

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<Left<ValidationFailure, UserEntity>>());
    });
  });
}
```

## Benefits of This Architecture

### 1. **Testability**
- Pure business logic functions
- Easy to mock repository
- No framework dependencies

### 2. **Maintainability**
- Clear separation of concerns
- Single responsibility per use case
- Easy to locate and modify logic

### 3. **Reusability**
- Use cases can be reused across different UI
- Parameter classes can be shared
- Validation logic centralized

### 4. **Type Safety**
- Strongly-typed parameters
- Compile-time error checking
- Immutable parameter objects

### 5. **Error Handling**
- Consistent Either<Failure, Success> pattern
- Type-safe error handling
- Clear error messages

## Next Steps

### Section 4: Presentation Layer (BLoC)
Create BLoC for state management:
- AuthBloc
- AuthEvent (LoginEvent, SignupEvent, LogoutEvent, etc.)
- AuthState (Initial, Loading, Authenticated, Unauthenticated, Error)

### Section 5: UI Screens
Create UI screens:
- Login screen with form validation
- Signup screen with multi-step form
- Forgot password screen
- OTP verification screen
- Change password screen

## Section 3 Status: ✅ COMPLETE

All authentication domain layer components (business logic) are implemented:
- ✅ 9 Use cases with comprehensive validation
- ✅ Parameter classes for type safety
- ✅ Base UseCase classes for consistency
- ✅ Dependency injection configured
- ✅ Ready for presentation layer (BLoC)
