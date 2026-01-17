import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // Default values
  Color _primaryColor = const Color(0xFF155096);
  String _fontFamily = 'Plus Jakarta Sans';
  double _fontSizeScale = 1.0;
  bool _isActive = true;
  Locale _locale = const Locale('en');

  // Additional state for dropdowns (placeholders for now or strictly UI state)
  // For now we will store the values that affect the theme directly.
  
  // Getters
  Color get primaryColor => _primaryColor;
  String get fontFamily => _fontFamily;
  double get fontSizeScale => _fontSizeScale;
  bool get isActive => _isActive;
  Locale get locale => _locale;

  // Theme Data Generation
  ThemeData get themeData {
    if (!_isActive) {
      // Inactive "Grey" Theme
      return ThemeData(
        useMaterial3: true,
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: const Color(0xFFE0E0E0), // Dimmed background
        fontFamily: _fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light, 
        ).copyWith(
          primary: Colors.grey[700],
          secondary: Colors.grey[600],
          surface: const Color(0xFFEEEEEE),
        ),
        textTheme: _buildTextTheme(),
      );
    }

    // Active Custom Theme
    return ThemeData(
      useMaterial3: true,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: const Color(0xFFE8F0FB), // Original background
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
      ),
      textTheme: _buildTextTheme(),
    );
  }

  TextTheme? _buildTextTheme() {
    // A simple way to scale font size is to let the app handle it via MediaQuery,
    // but here we can try to scale the base theme or return null to use default with fontFamily.
    // If we want to strictly apply scale, we might need a more complex TextTheme construction.
    // For this task, changing the scale factor in a custom way might be tricky without access to the default typography easily.
    // However, we can use the `apply` method on the default text theme if we had context, but we don't here.
    // We will rely on the `fontFamily` being set. 
    // For font size scale, we usually use `MediaQuery` textScaleFactor. 
    // But since we want to toggle "Font Size" in settings (Small, Medium, Large), we can expose the scale 
    // and use it in a builder or try to bake it into the theme's text styles.
    // Baking it in is safer for "app-wide" changes.
    
    // Let's create a base text theme and scale it.
    // Since we don't have the original default text theme here easily, we can just return null 
    // and handle scaling by wrapping MaterialApp in a builder or Media query override.
    // That is often the cleaner way to handle "Global Font Size" changes.
    return null; 
  }

  // Setters
  void updateColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  void updateFontFamily(String family) {
    _fontFamily = family;
    notifyListeners();
  }

  void updateFontSize(double scale) {
    _fontSizeScale = scale;
    notifyListeners();
  }

  void toggleActiveStatus(bool status) {
    _isActive = status;
    notifyListeners();
  }

  void updateLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
