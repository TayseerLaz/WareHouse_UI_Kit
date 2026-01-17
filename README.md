# SAPWAVES UI Kit

A comprehensive Flutter UI Kit with dynamic theming, full localization (English/Arabic with RTL support), and a complete set of screens for warehouse management applications.

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point
├── config/                            # App configuration
│   ├── routes.dart                    # Centralized route management
│   ├── theme.dart                     # Theme configuration & design tokens
│   └── constants.dart                 # App-wide constants
├── core/                              # Core utilities
│   ├── utils/                         # Helper functions
│   └── extensions/                    # Dart extensions
├── data/                              # Data layer
│   └── models/                        # Data models
├── l10n/                              # Localization
│   ├── app_en.arb                     # English translations
│   ├── app_ar.arb                     # Arabic translations
│   └── app_localizations*.dart        # Generated localization files
├── providers/                         # State management
│   └── theme_provider.dart            # Theme & locale provider
├── screens/                           # Feature-based screens
│   ├── auth/                          # Authentication
│   │   └── login_screen.dart
│   ├── home/                          # Home & navigation
│   │   ├── screen_selector.dart
│   │   ├── home_screen.dart
│   │   └── navigation_menu_screen.dart
│   ├── admin/                         # Administration
│   │   ├── administration_screen.dart
│   │   ├── synchronization_screen.dart
│   │   └── users/                     # User management
│   │       ├── users_screen.dart
│   │       └── user_form_screen.dart
│   ├── settings/                      # Settings & profile
│   │   ├── settings_screen.dart
│   │   └── profile_screen.dart
│   └── demos/                         # Demo screens
│       ├── widgets_demo_screen.dart
│       └── notification_demo_screen.dart
└── widgets/                           # Reusable widgets
    ├── common/                        # Common widgets
    │   ├── notification.dart
    │   └── status_badge.dart
    └── cards/                         # Card widgets
        ├── base_card.dart
        ├── item_info_card.dart
        ├── inventory_entry_card.dart
        ├── order_summary_card.dart
        └── payment_status_card.dart
```

## ✨ Features

### 🎨 Dynamic Theming
- **Theme Colors**: Blue (default), Red, Green, Purple
- **Font Families**: Plus Jakarta Sans, Roboto, Open Sans, Lato
- **Font Sizes**: Small, Medium, Large, Extra Large
- **Active Status**: Toggle between active and dimmed (grey) theme
- All settings persist and affect the entire app globally

### 🌍 Localization
- **Languages**: English, Arabic
- **RTL Support**: Full right-to-left layout for Arabic
- **Language Switcher**: Available on Screen Selector and Settings
- All UI text is fully localized

### 📱 Screens

#### Authentication
- **Login Screen**: Email/password login with social auth options

#### Home & Navigation
- **Screen Selector**: Main entry point with screen previews
- **Home Screen**: Dashboard with menu grid
- **Navigation Menu**: Sidebar navigation with user profile

#### Administration
- **Administration Panel**: Access to admin features
- **Users Management**: 
  - List view with search and filters
  - Add/Edit user form with comprehensive fields
  - Delete with confirmation
- **Synchronization**: Import/Export data with ERP systems

#### Settings & Profile
- **Settings**: Theme, language, font customization
- **Profile**: Company and warehouse settings

#### Demos
- **Widgets Demo**: Showcase of UI components
- **Notification Demo**: Animated notification examples

### 🧩 Reusable Widgets
- **Status Badge**: Colored status indicators
- **Notification**: Animated dropdown notifications
- **Cards**: Item Info, Inventory Entry, Order Summary, Payment Status

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)

### Installation

```bash
# Clone the repository
git clone https://github.com/TayseerLaz/WareHouse_UI_Kit.git

# Navigate to project directory
cd WareHouse_UI_Kit

# Install dependencies
flutter pub get

# Generate localization files
flutter gen-l10n

# Run the app
flutter run
```

### Running on Different Platforms

```bash
# Web
flutter run -d chrome

# iOS
flutter run -d ios

# Android
flutter run -d android
```

## 📝 Configuration

### Adding New Routes
Edit `lib/config/routes.dart`:
```dart
static const String newRoute = '/new_route';

static Map<String, WidgetBuilder> get routes => {
  // ... existing routes
  newRoute: (context) => const NewScreen(),
};
```

### Adding Translations
1. Add keys to `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`
2. Run `flutter gen-l10n`
3. Use in code: `AppLocalizations.of(context)!.yourKey`

### Customizing Theme
Edit `lib/config/theme.dart` to modify colors, spacing, and other design tokens.

## 🎯 Architecture Principles

- **Feature-based organization**: Screens grouped by functionality
- **Centralized configuration**: Routes, theme, and constants in config folder
- **Separation of concerns**: Clear distinction between screens, widgets, and business logic
- **Scalability**: Easy to add new features without cluttering
- **Maintainability**: Consistent structure across the project

## 📦 Dependencies

- `provider`: State management
- `intl`: Internationalization
- `flutter_localizations`: Flutter localization support

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Tayseer Laz**
- GitHub: [@TayseerLaz](https://github.com/TayseerLaz)

---

**Note**: This is a UI Kit demonstration project. No backend integration is required - all data is mocked for demonstration purposes.
