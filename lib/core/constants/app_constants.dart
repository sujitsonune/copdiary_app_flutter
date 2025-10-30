/// App-level Constants for Copdiary Application
class AppConstants {
  // App Info
  static const String appName = 'Copdiary';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyUserName = 'user_name';
  static const String keyRememberMe = 'remember_me';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyFcmToken = 'fcm_token';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';

  // Secure Storage Keys
  static const String secureKeyPassword = 'secure_password';
  static const String secureKeyEmail = 'secure_email';

  // Pagination
  static const int defaultPageSize = 20;
  static const int firstPage = 1;

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'dd/MM/yyyy hh:mm a';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Languages
  static const String englishCode = 'en';
  static const String marathiCode = 'mr';
  static const String hindiCode = 'hi';

  // Razorpay
  static const String razorpayKey = 'YOUR_RAZORPAY_KEY'; // Replace with actual key

  // Firebase
  static const String firebaseDynamicLinkPrefix = 'https://copdiary.page.link';

  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^[0-9]{10}$';
  static const String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$';

  // Error Messages
  static const String networkError = 'No internet connection';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'An unknown error occurred';
  static const String cacheError = 'Failed to load cached data';
}
