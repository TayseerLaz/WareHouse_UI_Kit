import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class ScreenSelector extends StatelessWidget {
  const ScreenSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Title
              const Text(
                'SAPWAVES UI Kit',
                style: TextStyle(
                  color: Color(0xFF155096),
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                localizations.selectScreenToPreview,
                style: const TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 48),
              
              // Screen Cards
              _buildScreenCard(
                context,
                title: localizations.loginScreenTitle,
                description: localizations.loginScreenDesc,
                icon: Icons.login,
                route: '/login',
              ),
              const SizedBox(height: 20),
              _buildScreenCard(
                context,
                title: localizations.homeScreenTitle,
                description: localizations.homeScreenDesc,
                icon: Icons.home_outlined,
                route: '/home',
              ),

              const SizedBox(height: 20),
              _buildScreenCard(
                context,
                title: localizations.navigationMenuTitle,
                description: localizations.navigationMenuDesc,
                icon: Icons.menu,
                route: '/navigation_menu',
              ),
              const SizedBox(height: 20),

              _buildScreenCard(
                context,
                title: localizations.userSettingsTitle,
                description: localizations.userSettingsDesc,
                icon: Icons.settings,
                route: '/settings',
              ),
              const SizedBox(height: 20),
              _buildScreenCard(
                context,
                title: localizations.notificationDemoTitle,
                description: localizations.notificationDemoDesc,
                icon: Icons.notifications_active_outlined,
                route: '/notification_demo',
              ),
              const SizedBox(height: 20),
              _buildScreenCard(
                context,
                title: localizations.widgetsTitle,
                description: localizations.widgetsDesc,
                icon: Icons.widgets,
                route: '/widgets_demo',
              ),
              
              const SizedBox(height: 32),
              
              // Language Switcher Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF155096).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.language,
                            color: Color(0xFF155096),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.language,
                              style: const TextStyle(
                                color: Color(0xFF262626),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              Provider.of<ThemeProvider>(context, listen: false).locale.languageCode == 'ar' 
                                ? 'العربية' 
                                : 'English',
                              style: const TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: Provider.of<ThemeProvider>(context).locale.languageCode == 'ar',
                      onChanged: (value) {
                        final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                        themeProvider.updateLocale(value ? const Locale('ar') : const Locale('en'));
                      },
                      activeColor: const Color(0xFF155096),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Footer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  localizations.flutterUIKitDemo,
                  style: const TextStyle(
                    color: Color(0xFF7F7F7F),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreenCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required String route,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF155096).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF155096),
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF262626),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF7F7F7F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF155096),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
