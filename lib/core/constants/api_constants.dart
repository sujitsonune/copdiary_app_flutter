/// API Constants for Copdiary Application
class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://admin.copdiary.com/';

  // API Endpoints
  static const String login = 'api/login';
  static const String register = 'api/register';
  static const String verifyOtp = 'api/verify-otp';
  static const String resendOtp = 'api/resend-otp';
  static const String forgotPassword = 'api/forgot-password';
  static const String resetPassword = 'api/reset-password';
  static const String logout = 'api/logout';

  // User Endpoints
  static const String userProfile = 'api/user/profile';
  static const String updateProfile = 'api/user/update-profile';
  static const String changePassword = 'api/user/change-password';

  // Diary Endpoints
  static const String diaryEntries = 'api/diary/entries';
  static const String createDiaryEntry = 'api/diary/create';
  static const String updateDiaryEntry = 'api/diary/update';
  static const String deleteDiaryEntry = 'api/diary/delete';
  static const String diaryDetails = 'api/diary/details';

  // Travel Log Endpoints
  static const String travelLogs = 'api/travel/logs';
  static const String createTravelLog = 'api/travel/create';
  static const String updateTravelLog = 'api/travel/update';
  static const String deleteTravelLog = 'api/travel/delete';

  // Notification Endpoints
  static const String notifications = 'api/notifications';
  static const String markNotificationRead = 'api/notifications/mark-read';
  static const String registerDevice = 'api/notifications/register-device';

  // Payment Endpoints
  static const String createOrder = 'api/payment/create-order';
  static const String verifyPayment = 'api/payment/verify';
  static const String subscriptionStatus = 'api/payment/subscription-status';

  // Timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
