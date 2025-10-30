# Section 3: Authentication Domain Layer - Quick Reference

## ✅ Status: COMPLETE

## 📁 Files Created

### Core UseCase (1 file)
```
lib/core/usecases/
└── usecase.dart (Base classes for all use cases)
```

### Authentication Use Cases (9 files)
```
lib/features/authentication/domain/usecases/
├── login_usecase.dart
├── signup_usecase.dart
├── logout_usecase.dart
├── get_current_user_usecase.dart
├── check_login_status_usecase.dart
├── forgot_password_usecase.dart
├── verify_otp_usecase.dart
├── reset_password_usecase.dart
└── change_password_usecase.dart
```

## 🎯 Use Cases Overview

| Use Case | Parameters | Validations | Returns |
|----------|-----------|-------------|---------|
| **LoginUseCase** | username, password, rememberMe | Username format, password length | UserEntity |
| **SignupUseCase** | username, password, fullName, mobile, etc. | All fields + email format | UserEntity |
| **LogoutUseCase** | None | None | void |
| **GetCurrentUserUseCase** | None | None | UserEntity |
| **CheckLoginStatusUseCase** | None | None | bool |
| **ForgotPasswordUseCase** | mobile | Mobile format | void |
| **VerifyOtpUseCase** | mobile, otp | Mobile + OTP format | void |
| **ResetPasswordUseCase** | mobile, otp, newPassword, confirmPassword | All + password match | void |
| **ChangePasswordUseCase** | userId, oldPassword, newPassword, confirmPassword | All + passwords different | void |

## 🔑 Key Features

### ✨ Comprehensive Validation
All use cases include input validation:
- ✅ Empty checks
- ✅ Format validation (email, mobile, username)
- ✅ Length validation
- ✅ Pattern matching
- ✅ Business rules (passwords match, etc.)

### ✨ Type Safety
- Strongly-typed parameter classes
- Equatable for value comparison
- Immutable objects
- Factory methods for form data

### ✨ Clean Architecture
- Pure business logic
- No framework dependencies
- Testable with mock repositories
- Single responsibility per use case

### ✨ Error Handling
- `Either<Failure, Success>` pattern
- ValidationFailure for input errors
- ServerFailure, NetworkFailure for system errors
- Clear error messages

### ✨ Dependency Injection
- All use cases registered with @lazySingleton
- Auto-injected dependencies
- Easy to test and maintain

## 💡 Quick Usage

### Login
```dart
final loginUseCase = getIt<LoginUseCase>();

final result = await loginUseCase(
  LoginParams(
    username: 'officer_name',
    password: 'secure_password',
    rememberMe: true,
  ),
);

result.fold(
  (failure) => showError(failure.message),
  (user) => navigateToHome(),
);
```

### Signup
```dart
final signupUseCase = getIt<SignupUseCase>();

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

### Logout
```dart
final logoutUseCase = getIt<LogoutUseCase>();
final result = await logoutUseCase();
```

### Check Login Status
```dart
final checkLoginStatusUseCase = getIt<CheckLoginStatusUseCase>();
final result = await checkLoginStatusUseCase();

result.fold(
  (_) => navigateToLogin(),
  (isLoggedIn) => isLoggedIn ? navigateToHome() : navigateToLogin(),
);
```

### Forgot Password Flow
```dart
// Step 1: Request OTP
await forgotPasswordUseCase(ForgotPasswordParams(mobile: '9876543210'));

// Step 2: Verify OTP
await verifyOtpUseCase(VerifyOtpParams(mobile: '9876543210', otp: '123456'));

// Step 3: Reset Password
await resetPasswordUseCase(ResetPasswordParams(
  mobile: '9876543210',
  otp: '123456',
  newPassword: 'NewPass123',
  confirmPassword: 'NewPass123',
));
```

## 📊 Validation Rules

### Username
- Not empty
- Alphanumeric + underscore only
- Min 3 characters (signup)

### Password
- Not empty
- Min 6 characters (login)
- Min 8 characters with letters & numbers (signup/change)

### Mobile
- Not empty
- Exactly 10 digits
- Pattern: `^[0-9]{10}$`

### Email
- Valid email format
- Pattern: `^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$`

### OTP
- Not empty
- 4-6 digits
- Digits only

## 🏗️ Architecture Benefits

### Testability
```dart
class MockAuthRepository extends Mock implements AuthRepository {}

test('should return ValidationFailure when username is empty', () async {
  final loginUseCase = LoginUseCase(mockRepository);
  final result = await loginUseCase(LoginParams(username: '', password: 'pass'));

  expect(result, isA<Left<ValidationFailure, UserEntity>>());
});
```

### Reusability
- Use cases work across different UI implementations
- Parameter classes can be shared
- Validation logic centralized

### Maintainability
- Each use case has single responsibility
- Easy to locate and modify logic
- Clear separation from data and presentation layers

## 📚 Parameter Classes

All use cases use typed parameter classes with:
- Equatable for comparison
- fromForm() factory for easy creation
- copyWith() for immutability (where needed)
- Automatic trimming of string inputs

Example:
```dart
class LoginParams extends Equatable {
  final String username;
  final String password;
  final bool rememberMe;

  factory LoginParams.fromForm({
    required String username,
    required String password,
    bool rememberMe = false,
  }) {
    return LoginParams(
      username: username.trim(),
      password: password,
      rememberMe: rememberMe,
    );
  }
}
```

## 🚀 Next Steps

### Section 4: Presentation Layer
- Create AuthBloc for state management
- Define AuthEvent and AuthState
- Implement event handlers
- Connect to use cases

### Section 5: UI Screens
- Login screen with form validation
- Signup screen with multi-step form
- Forgot password flow screens
- Profile/settings screens

## ✅ Completed Components

- [x] Base UseCase classes
- [x] LoginUseCase with validation
- [x] SignupUseCase with comprehensive validation
- [x] LogoutUseCase
- [x] GetCurrentUserUseCase
- [x] CheckLoginStatusUseCase
- [x] ForgotPasswordUseCase
- [x] VerifyOtpUseCase
- [x] ResetPasswordUseCase
- [x] ChangePasswordUseCase
- [x] Dependency injection setup
- [x] Code generation complete

## 📖 Documentation

- **Full Documentation**: AUTH_DOMAIN_LAYER_README.md
- **Data Layer**: AUTH_DATA_LAYER_README.md
- **Core Setup**: CORE_SETUP_README.md
- **This Summary**: SECTION_3_SUMMARY.md

## 🎉 Section 3 Complete!

All domain layer business logic is implemented with comprehensive validation and error handling. Ready to build the presentation layer (BLoC) in Section 4!
