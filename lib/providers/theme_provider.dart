import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  // Default values
  Color _primaryColor = const Color(0xFF155096);
  String _fontFamily = 'Plus Jakarta Sans';
  double _fontSizeScale = 1.0;
  bool _isActive = true;
  Locale _locale = const Locale('en');

  // Getters
  Color get primaryColor => _primaryColor;
  String get fontFamily => _fontFamily;
  double get fontSizeScale => _fontSizeScale;
  bool get isActive => _isActive;
  Locale get locale => _locale;

  // Theme Data Generation
  ThemeData get themeData {
    // Base TextTheme to apply font to
    final baseTextTheme = ThemeData.light().textTheme;
    
    // Get dynamic text theme from GoogleFonts
    TextTheme dynamicTextTheme;
    
    switch (_fontFamily) {
      case 'Roboto':
        dynamicTextTheme = GoogleFonts.robotoTextTheme(baseTextTheme);
        break;
      case 'Open Sans':
        dynamicTextTheme = GoogleFonts.openSansTextTheme(baseTextTheme);
        break;
      case 'Lato':
        dynamicTextTheme = GoogleFonts.latoTextTheme(baseTextTheme);
        break;
      case 'Plus Jakarta Sans':
      default:
        dynamicTextTheme = GoogleFonts.plusJakartaSansTextTheme(baseTextTheme);
        break;
    }

    if (!_isActive) {
      // Inactive "Grey" Theme
      return ThemeData(
        useMaterial3: true,
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: const Color(0xFFE0E0E0),
        textTheme: dynamicTextTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light, 
        ).copyWith(
          primary: Colors.grey[700],
          secondary: Colors.grey[600],
          surface: const Color(0xFFEEEEEE),
        ),
      );
    }

    // Active Custom Theme
    return ThemeData(
      useMaterial3: true,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: const Color(0xFFE8F0FB),
      textTheme: dynamicTextTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
      ),
    );
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
