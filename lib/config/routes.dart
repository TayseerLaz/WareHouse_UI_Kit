import 'package:flutter/material.dart';
import '../screens/home/screen_selector.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/demos/notification_demo_screen.dart';
import '../screens/home/navigation_menu_screen.dart';
import '../screens/home/receiving_from_vendor_screen.dart';
import '../screens/home/grpo_screen.dart';
import '../screens/home/suppliers_screen.dart';
import '../screens/home/grpo_details_screen.dart';
import '../screens/home/inventory_list_screen.dart';
import '../screens/settings/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/demos/widgets_demo_screen.dart';
import '../screens/admin/administration_screen.dart';
import '../screens/admin/users/users_screen.dart';
import '../screens/admin/users/user_form_screen.dart';
import '../screens/admin/synchronization_screen.dart';
import '../screens/admin/import_screen.dart';
import '../screens/admin/export_screen.dart';
import '../screens/admin/authorizations/authorizations_screen.dart';
import '../screens/admin/authorizations/authorization_details_screen.dart';
import '../screens/admin/company/company_settings_screen.dart';
import '../screens/admin/company/company_form_screen.dart';
import '../screens/notifications/notifications_list_screen.dart';

/// App Routes Configuration
/// Centralized route management for the entire application
class AppRoutes {
  // Route names as constants
  static const String home = '/';
  static const String login = '/login';
  static const String homeScreen = '/home';
  static const String receivingFromVendor = '/receiving_from_vendor';
  static const String grpo = '/grpo';
  static const String suppliers = '/suppliers';
  static const String grpoDetails = '/grpo_details';
  static const String inventoryList = '/inventory_list';
  static const String notificationDemo = '/notification_demo';
  static const String navigationMenu = '/navigation_menu';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String widgetsDemo = '/widgets_demo';
  static const String administration = '/administration';
  static const String users = '/users';
  static const String userForm = '/user_form';
  static const String synchronization = '/synchronization';
  static const String importData = '/import';
  static const String exportData = '/export';
  static const String authorizations = '/authorizations';
  static const String authorizationDetails = '/authorization_details';
  static const String companySettings = '/company_settings';
  static const String companyForm = '/company_form';
  static const String notifications = '/notifications';

  /// Route generator
  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const ScreenSelector(),
        login: (context) => const LoginScreen(),
        homeScreen: (context) => const HomeScreen(),
        receivingFromVendor: (context) => const ReceivingFromVendorScreen(),
        grpo: (context) => const GRPOScreen(),
        suppliers: (context) => const SuppliersScreen(),
        inventoryList: (context) => const InventoryListScreen(),
        notificationDemo: (context) => const NotificationDemoScreen(),
        navigationMenu: (context) => const NavigationMenuScreen(),
        profile: (context) => const ProfileScreen(),
        settings: (context) => const SettingsScreen(),
        widgetsDemo: (context) => const WidgetsDemoScreen(),
        administration: (context) => const AdministrationScreen(),
        users: (context) => const UsersScreen(),
        userForm: (context) => const UserFormScreen(),
        synchronization: (context) => const SynchronizationScreen(),
        importData: (context) => const ImportScreen(),
        exportData: (context) => const ExportScreen(),
        authorizations: (context) => const AuthorizationsScreen(),
        authorizationDetails: (context) => const AuthorizationDetailsScreen(),
        companySettings: (context) => const CompanySettingsScreen(),
        companyForm: (context) => const CompanyFormScreen(),
        notifications: (context) => const NotificationsListScreen(),
      };
}
