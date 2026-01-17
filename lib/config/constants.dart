/// App Constants
/// Application-wide constant values
class AppConstants {
  // App Info
  static const String appName = 'SAPWAVES UI Kit';
  static const String appVersion = '1.0.0';
  
  // Supported Locales
  static const String defaultLocale = 'en';
  static const List<String> supportedLanguages = ['en', 'ar'];
  
  // Default Font Families
  static const String defaultFontFamily = 'Plus Jakarta Sans';
  static const List<String> availableFonts = [
    'Plus Jakarta Sans',
    'Roboto',
    'Open Sans',
    'Lato',
  ];
  
  // Font Size Options
  static const Map<String, double> fontSizeMap = {
    'Small': 0.8,
    'Medium': 1.0,
    'Large': 1.2,
    'Extra Large': 1.4,
  };
  
  // Mock Companies (for dropdowns)
  static const List<String> companies = [
    'Pegolive_US',
    'Company A',
    'Company B',
    'Company C',
  ];
  
  // User Roles
  static const List<String> userRoles = [
    'Admin',
    'Manager',
    'User',
    'Guest',
  ];
  
  // Data Types for Synchronization
  static const List<String> syncDataTypes = [
    'System',
    'Items',
    'Customers',
    'Inbound',
    'Outbound',
    'Transfer',
    'Move',
    'Transactions',
  ];
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
