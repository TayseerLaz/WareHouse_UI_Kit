import 'package:flutter/material.dart';
import '../screens/home/screen_selector.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/demos/notification_demo_screen.dart';
import '../screens/home/navigation_menu_screen.dart';
import '../screens/settings/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/demos/widgets_demo_screen.dart';
import '../screens/admin/administration_screen.dart';
import '../screens/admin/users/users_screen.dart';
import '../screens/admin/users/user_form_screen.dart';
import '../screens/admin/synchronization_screen.dart';

/// App Routes Configuration
/// Centralized route management for the entire application
class AppRoutes {
  // Route names as constants
  static const String home = '/';
  static const String login = '/login';
  static const String homeScreen = '/home';
  static const String notificationDemo = '/notification_demo';
  static const String navigationMenu = '/navigation_menu';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String widgetsDemo = '/widgets_demo';
  static const String administration = '/administration';
  static const String users = '/users';
  static const String userForm = '/user_form';
  static const String synchronization = '/synchronization';

  /// Route generator
  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const ScreenSelector(),
        login: (context) => const LoginScreen(),
        homeScreen: (context) => const HomeScreen(),
        notificationDemo: (context) => const NotificationDemoScreen(),
        navigationMenu: (context) => const NavigationMenuScreen(),
        profile: (context) => const ProfileScreen(),
        settings: (context) => const SettingsScreen(),
        widgetsDemo: (context) => const WidgetsDemoScreen(),
        administration: (context) => const AdministrationScreen(),
        users: (context) => const UsersScreen(),
        userForm: (context) => const UserFormScreen(),
        synchronization: (context) => const SynchronizationScreen(),
      };
}
