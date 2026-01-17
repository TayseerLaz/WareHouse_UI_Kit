# SAPWAVES UI Kit

A professional Flutter UI Kit for an Android inventory management application with web support.

## 📱 Features

- **Login Screen**: Complete authentication interface with email/password fields and social login options (Apple & Google)
- **Home Screen**: Dashboard with inventory management menu items and bottom navigation
- Clean, modern design with consistent color scheme
- Responsive layout optimized for mobile devices
- Web support enabled for Chrome testing

## 🎨 Design System

- **Primary Color**: `#155096` (Blue)
- **Background Color**: `#E8F0FB` (Light Blue)
- **Font Family**: Plus Jakarta Sans (system fallback available)
- **UI Components**: Material Design 3

## 📂 Project Structure

```
UI_kit/
├── lib/
│   ├── main.dart                 # App entry point with navigation
│   └── screens/
│       ├── login_screen.dart     # Login/authentication screen
│       └── home_screen.dart      # Home dashboard screen
├── web/
│   ├── index.html               # Web entry point
│   └── manifest.json            # Web app manifest
├── pubspec.yaml                 # Dependencies configuration
└── README.md                    # This file
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Chrome browser (for web testing)

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Enable web support (if not already enabled):
```bash
flutter config --enable-web
```

### Running the App

#### On Chrome Web:
```bash
flutter run -d chrome
```

#### On Android Device/Emulator:
```bash
flutter run
```

#### Build for Web:
```bash
flutter build web
```

The web build will be available in `build/web/` directory.

## 📱 Screens

### 1. Login Screen
- Email and password input fields
- "Forgot password?" link
- Primary login button with navigation to home
- Social login options (Apple & Google)
- "Create Account" link for new users

### 2. Home Screen
- Header with user greeting and date
- Notification icon
- Menu items:
  - Receiving From Vendors
  - Return To Vendor
  - Delivery To Customer
  - Return From Customer
  - Inventory Transfer
  - Inventory Transfer In
  - Inventory Move
- Bottom navigation bar (Home, Inventory, Analytics, Navigation)

## 🎯 Navigation Flow

```
LoginScreen (/) → HomeScreen (/home)
```

## 💼 For Customers

This UI kit provides:
- ✅ Production-ready Flutter code
- ✅ Well-structured and organized files
- ✅ Clean, maintainable codebase
- ✅ Material Design 3 components
- ✅ Responsive layouts
- ✅ Web support for easy preview
- ✅ Easy to extend and customize

## 🛠️ Customization

To customize colors, fonts, or styles, edit the `ThemeData` in [lib/main.dart](lib/main.dart):

```dart
theme: ThemeData(
  primaryColor: const Color(0xFF155096),
  scaffoldBackgroundColor: const Color(0xFFE8F0FB),
  fontFamily: 'Plus Jakarta Sans',
  // ... more theme properties
),
```

## 📝 Notes

- The app uses placeholder images and icons
- Social login buttons are UI-only (functionality not implemented)
- Navigation items in bottom bar are UI-only (routes not implemented)
- This is a UI kit focusing on visual design and structure

## 📄 License

This is a deliverable UI kit for client use.

---

**Version**: 1.0.0
**Last Updated**: January 2026
