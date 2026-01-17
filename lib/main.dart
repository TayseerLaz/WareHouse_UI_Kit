import 'package:flutter/material.dart';
import 'screens/screen_selector.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notification_demo_screen.dart';
import 'screens/navigation_menu_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/widgets_demo_screen.dart';
import 'screens/administration_screen.dart';
import 'screens/users_screen.dart';
import 'screens/user_form_screen.dart';
import 'screens/synchronization_screen.dart';

import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const SapwavesUIKit(),
    ),
  );
}

class SapwavesUIKit extends StatelessWidget {
  const SapwavesUIKit({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'SAPWAVES UI Kit',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          builder: (context, child) {
            // Apply Global Font Size Scale
            final mediaQueryData = MediaQuery.of(context);
            // Use TextScaler for newer Flutter versions (3.16+)
            // Check if we need to support older versions, but assuming 3.x linear scalar is safe-ish or use deprecated textScaleFactor if unsure.
            // Safe bet for >3.0: data.copyWith(textScaleFactor: ...) is still available but deprecated.
            // Best modern way:
            return MediaQuery(
              data: mediaQueryData.copyWith(
                textScaler: TextScaler.linear(themeProvider.fontSizeScale),
              ),
              child: child!,
            );
          },
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          locale: themeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: '/',
          routes: {
            '/': (context) => const ScreenSelector(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/notification_demo': (context) => const NotificationDemoScreen(),
            '/navigation_menu': (context) => const NavigationMenuScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/widgets_demo': (context) => const WidgetsDemoScreen(),
            '/administration': (context) => const AdministrationScreen(),
            '/users': (context) => const UsersScreen(),
            '/user_form': (context) => const UserFormScreen(),
            '/synchronization': (context) => const SynchronizationScreen(),
          },
        );
      },
    );
  }
}
