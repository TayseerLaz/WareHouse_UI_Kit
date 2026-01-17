import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';


import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeColor = themeProvider.primaryColor;
    final localizations = AppLocalizations.of(context)!;

    // Helper maps
    // These maps serve to translate between UI strings and Provider values
    final Map<String, Color> colorMap = {
      'Blue': const Color(0xFF155096),
      'Red': Colors.red,
      'Green': Colors.green,
      'Purple': Colors.purple,
      'Orange': Colors.orange,
    };
    
    // Reverse lookup for dropdown value
    String? getCurrentColorName() {
      for (var entry in colorMap.entries) {
        if (entry.value.value == themeProvider.primaryColor.value) return entry.key;
      }
      return 'Blue'; // Default
    }

    final Map<String, double> fontSizeMap = {
      'Small': 0.85,
      'Medium': 1.0,
      'Large': 1.15,
      'Extra Large': 1.3,
    };

    String? getCurrentFontSizeName() {
      for (var entry in fontSizeMap.entries) {
        if (entry.value == themeProvider.fontSizeScale) return entry.key;
      }
      return 'Medium';
    }


    return Scaffold(
      backgroundColor: themeProvider.isActive ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFE0E0E0),
      body: Column(
        children: [
          // Custom Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20, 
              right: 20, 
              top: 60, 
              bottom: 40
            ),
            decoration: BoxDecoration(
              color: themeProvider.isActive ? themeColor : Colors.grey[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
             child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Text(
                  localizations.userSettings,
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // Profile Picture Section
                   Center(
                     child: Stack(
                       children: [
                         Container(
                           width: 100,
                           height: 100,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             shape: BoxShape.circle,
                             border: Border.all(color: Colors.white, width: 4),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withValues(alpha: 0.1),
                                 blurRadius: 10,
                                 offset: const Offset(0, 4),
                               ),
                             ],
                           ),
                           child: const CircleAvatar(
                             backgroundColor: Color(0xFFF0F0F0),
                             child: Icon(Icons.person, size: 50, color: Color(0xFFCCCCCC)),
                           ),
                         ),
                         Positioned(
                           bottom: 0,
                           right: 0,
                           child: Container(
                             width: 32,
                             height: 32,
                             decoration: BoxDecoration(
                               color: themeProvider.isActive ? themeColor : Colors.grey,
                               shape: BoxShape.circle,
                               border: Border.all(color: Colors.white, width: 2),
                             ),
                             child: const Icon(Icons.edit, color: Colors.white, size: 16),
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 32),

                  // Personal Information
                  _buildSectionHeader(localizations.personalInformation, context),
                  const SizedBox(height: 16),
                  _buildInputField(localizations.name, localizations.enterName),
                  const SizedBox(height: 12),
                  _buildInputField(localizations.email, localizations.enterEmail),
                  const SizedBox(height: 12),
                  _buildInputField(localizations.phoneNumber, localizations.enterPhoneNumber),
                  const SizedBox(height: 12),
                  _buildInputField(localizations.password, localizations.enterPassword, isPassword: true),
                  const SizedBox(height: 12),
                  _buildInputField(localizations.imeiNumber, localizations.enterImei),

                  const SizedBox(height: 32),

                  // App Settings
                  _buildSectionHeader(localizations.appConfiguration, context),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    context: context,
                    label: localizations.userGroup, 
                    value: 'Admin', // Placeholder
                    items: ['Admin', 'Manager', 'User', 'Guest'],
                    onChanged: (val) {}, // No-op for now
                  ),
                  const SizedBox(height: 12),
                   _buildDropdown(
                    context: context,
                    label: localizations.language, 
                    value: themeProvider.locale.languageCode == 'ar' ? 'Arabic' : 'English',
                    items: ['English', 'Arabic'],
                    onChanged: (val) {
                      if (val == 'Arabic') {
                        themeProvider.updateLocale(const Locale('ar'));
                      } else {
                         themeProvider.updateLocale(const Locale('en'));
                      }
                    },
                  ),
                   const SizedBox(height: 12),
                   _buildDropdown(
                    context: context,
                    label: localizations.fontFamily, 
                    value: themeProvider.fontFamily,
                    // Assuming these fonts are available or fallback cleanly
                    items: ['Plus Jakarta Sans', 'Roboto', 'Open Sans', 'Lato'],
                    onChanged: (val) {
                      if (val != null) themeProvider.updateFontFamily(val);
                    },
                  ),
                   const SizedBox(height: 12),
                   _buildDropdown(
                    context: context,
                    label: localizations.fontSize, 
                    value: getCurrentFontSizeName(),
                    items: fontSizeMap.keys.toList(),
                    onChanged: (val) {
                      if (val != null) themeProvider.updateFontSize(fontSizeMap[val]!);
                    },
                  ),
                   const SizedBox(height: 12),
                   _buildDropdown(
                    context: context,
                    label: localizations.themeColor, 
                    value: getCurrentColorName(),
                    items: colorMap.keys.toList(),
                    onChanged: (val) {
                      if (val != null) themeProvider.updateColor(colorMap[val]!);
                    },
                  ),

                  const SizedBox(height: 24),

                  // Active Status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                         BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SwitchListTile(
                      title: Text(
                        localizations.activeStatus,
                        style: const TextStyle(
                          color: Color(0xFF191919),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      activeColor: themeColor,
                      value: themeProvider.isActive,
                      onChanged: (val) => themeProvider.toggleActiveStatus(val),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Update Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localizations.settingsUpdated)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.isActive ? themeColor : Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        localizations.update,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildInputField(String label, String placeholder, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF595959),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: Color(0xFF999999)),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF155096), width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF595959),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF155096), width: 1.5),
              ),
            ),
            hint: Text('${AppLocalizations.of(context)!.select} $label'),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF595959)),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
