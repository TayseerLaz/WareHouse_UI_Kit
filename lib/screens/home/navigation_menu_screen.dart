import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NavigationMenuScreen extends StatelessWidget {
  const NavigationMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FB),
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(localizations.navigation, style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // User Profile Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: themeColor),
                  // In a real app, use NetworkImage or AssetImage:
                  // backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Color(0xFFD4FBF6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),

          // Menu Buttons
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildMenuButton(context, 'Pegolive_US', Icons.business, themeColor),
                const SizedBox(height: 12),
                _buildMenuButton(context, localizations.generalSettings, Icons.settings_outlined, themeColor),
                const SizedBox(height: 12),
                _buildMenuButton(context, localizations.userSettings, Icons.person_outline, themeColor),
                const SizedBox(height: 12),
                _buildMenuButton(context, localizations.administration, Icons.admin_panel_settings_outlined, themeColor),
                const SizedBox(height: 12),
                _buildMenuButton(context, localizations.synchronization, Icons.sync, themeColor),
                const SizedBox(height: 12),
                _buildMenuButton(
                  context, 
                  localizations.logOut, 
                  Icons.logout, 
                  Colors.red, // specialized color for logout
                  textColor: Colors.red
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, 
    String title, 
    IconData icon, 
    Color iconColor, 
    {Color textColor = const Color(0xFF262626)} // Default text color
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle navigation here
            // Note: We use title matching here, which depends on localization.
            // In a real app, use an enum or id, but for now we match the string.
            // BUT: Since I passed localized string, matching 'Log Out' might fail in Arabic.
            // I should change logic to match action or use keys.
            // For now I'll just check against the known localized string if possible or assume simple demo structure.
            // Better: use callback or hardcode logic for now since I don't want to overengineer the demo logic too much,
            // but matching logic logic needs to be robust. 
            // I will use `localizations.logOut` for comparison.
            final localizations = AppLocalizations.of(context)!;
            if (title == localizations.logOut) {
               Navigator.popUntil(context, ModalRoute.withName('/'));
            } else if (title == localizations.generalSettings) {
               Navigator.pushNamed(context, '/profile');
            } else if (title == localizations.userSettings) {
               Navigator.pushNamed(context, '/settings');
            } else if (title == localizations.administration) {
               Navigator.pushNamed(context, '/administration');
            } else if (title == localizations.synchronization) {
               Navigator.pushNamed(context, '/synchronization');
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
