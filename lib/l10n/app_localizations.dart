import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SAPWAVES UI Kit'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @widgets.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get widgets;

  /// No description provided for @navigationMenu.
  ///
  /// In en, this message translates to:
  /// **'Navigation Menu'**
  String get navigationMenu;

  /// No description provided for @userSettings.
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get userSettings;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @appConfiguration.
  ///
  /// In en, this message translates to:
  /// **'App Configuration'**
  String get appConfiguration;

  /// No description provided for @userGroup.
  ///
  /// In en, this message translates to:
  /// **'User Group'**
  String get userGroup;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font Family'**
  String get fontFamily;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @themeColor.
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get themeColor;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active Status'**
  String get activeStatus;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @settingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Settings Updated Successfully'**
  String get settingsUpdated;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @imeiNumber.
  ///
  /// In en, this message translates to:
  /// **'IMEI Number'**
  String get imeiNumber;

  /// No description provided for @enterImei.
  ///
  /// In en, this message translates to:
  /// **'Enter IMEI Number'**
  String get enterImei;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @demoWidgets.
  ///
  /// In en, this message translates to:
  /// **'Demo Widgets'**
  String get demoWidgets;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cards;

  /// No description provided for @buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SAPWAVES\nTrack inventory, manage movements, and complete daily tasks faster with a system built for the ease of use'**
  String get welcomeMessage;

  /// No description provided for @keepMeLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Keep me logged in'**
  String get keepMeLoggedIn;

  /// No description provided for @resetIt.
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get resetIt;

  /// No description provided for @newUser.
  ///
  /// In en, this message translates to:
  /// **'New User ?'**
  String get newUser;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @helloUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {userName}'**
  String helloUser(String userName);

  /// No description provided for @goodReceipts.
  ///
  /// In en, this message translates to:
  /// **'Good Receipts'**
  String get goodReceipts;

  /// No description provided for @goodReceiptsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recieve goods from vendors'**
  String get goodReceiptsSubtitle;

  /// No description provided for @goodIssue.
  ///
  /// In en, this message translates to:
  /// **'Good Issue'**
  String get goodIssue;

  /// No description provided for @goodIssueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Issue goods to production/others'**
  String get goodIssueSubtitle;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @transactionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all stock movements'**
  String get transactionsSubtitle;

  /// No description provided for @receivingFromVendors.
  ///
  /// In en, this message translates to:
  /// **'Receiving From Vendors'**
  String get receivingFromVendors;

  /// No description provided for @receivingFromVendorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'34 new sales done'**
  String get receivingFromVendorsSubtitle;

  /// No description provided for @returnToVendor.
  ///
  /// In en, this message translates to:
  /// **'Return To vendor'**
  String get returnToVendor;

  /// No description provided for @returnToVendorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'34 new sales done'**
  String get returnToVendorSubtitle;

  /// No description provided for @deliveryToCustomer.
  ///
  /// In en, this message translates to:
  /// **'Delivery To Customer'**
  String get deliveryToCustomer;

  /// No description provided for @deliveryToCustomerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'5 new payments recieved'**
  String get deliveryToCustomerSubtitle;

  /// No description provided for @returnFromCustomer.
  ///
  /// In en, this message translates to:
  /// **'Return From Customer'**
  String get returnFromCustomer;

  /// No description provided for @returnFromCustomerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Some stock need replenishment'**
  String get returnFromCustomerSubtitle;

  /// No description provided for @inventoryTransfer.
  ///
  /// In en, this message translates to:
  /// **'Inventory Transfer'**
  String get inventoryTransfer;

  /// No description provided for @inventoryTransferSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share in .pdf, excel or any format'**
  String get inventoryTransferSubtitle;

  /// No description provided for @inventoryTransferIn.
  ///
  /// In en, this message translates to:
  /// **'Inventory Transfer In'**
  String get inventoryTransferIn;

  /// No description provided for @inventoryTransferInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share in .pdf, excel or any format'**
  String get inventoryTransferInSubtitle;

  /// No description provided for @inventoryMove.
  ///
  /// In en, this message translates to:
  /// **'Inventory Move'**
  String get inventoryMove;

  /// No description provided for @inventoryMoveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share in .pdf, excel or any format'**
  String get inventoryMoveSubtitle;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// No description provided for @companySettings.
  ///
  /// In en, this message translates to:
  /// **'Company Settings'**
  String get companySettings;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @selectCompany.
  ///
  /// In en, this message translates to:
  /// **'Select company'**
  String get selectCompany;

  /// No description provided for @warehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get warehouse;

  /// No description provided for @selectWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Select Warehouse'**
  String get selectWarehouse;

  /// No description provided for @binId.
  ///
  /// In en, this message translates to:
  /// **'Bin ID'**
  String get binId;

  /// No description provided for @enterBinId.
  ///
  /// In en, this message translates to:
  /// **'Enter Bin ID'**
  String get enterBinId;

  /// No description provided for @transitory.
  ///
  /// In en, this message translates to:
  /// **'Transitory'**
  String get transitory;

  /// No description provided for @bin.
  ///
  /// In en, this message translates to:
  /// **'Bin'**
  String get bin;

  /// No description provided for @enterBin.
  ///
  /// In en, this message translates to:
  /// **'Enter Bin'**
  String get enterBin;

  /// No description provided for @inbound.
  ///
  /// In en, this message translates to:
  /// **'Inbound'**
  String get inbound;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile Updated Successfully'**
  String get profileUpdated;

  /// No description provided for @statusBadges.
  ///
  /// In en, this message translates to:
  /// **'Status Badges'**
  String get statusBadges;

  /// No description provided for @pendingState.
  ///
  /// In en, this message translates to:
  /// **'Pending State:'**
  String get pendingState;

  /// No description provided for @doneState.
  ///
  /// In en, this message translates to:
  /// **'Done State:'**
  String get doneState;

  /// No description provided for @errorState.
  ///
  /// In en, this message translates to:
  /// **'Error State:'**
  String get errorState;

  /// No description provided for @itemInfoCard.
  ///
  /// In en, this message translates to:
  /// **'Item Info Card'**
  String get itemInfoCard;

  /// No description provided for @milkMixed.
  ///
  /// In en, this message translates to:
  /// **'Milk-Mixed'**
  String get milkMixed;

  /// No description provided for @categoryMilk.
  ///
  /// In en, this message translates to:
  /// **'Category: Milk'**
  String get categoryMilk;

  /// No description provided for @inventoryEntryCard.
  ///
  /// In en, this message translates to:
  /// **'Inventory Entry Card'**
  String get inventoryEntryCard;

  /// No description provided for @milkCow.
  ///
  /// In en, this message translates to:
  /// **'Milk-Cow'**
  String get milkCow;

  /// No description provided for @paymentStatusCard.
  ///
  /// In en, this message translates to:
  /// **'Payment Status Card'**
  String get paymentStatusCard;

  /// No description provided for @orderSummaryCard.
  ///
  /// In en, this message translates to:
  /// **'Order Summary Card'**
  String get orderSummaryCard;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount: ₹72'**
  String get totalAmount;

  /// No description provided for @gheeCow.
  ///
  /// In en, this message translates to:
  /// **'Ghee-cow'**
  String get gheeCow;

  /// No description provided for @ghee.
  ///
  /// In en, this message translates to:
  /// **'Ghee'**
  String get ghee;

  /// No description provided for @paneer.
  ///
  /// In en, this message translates to:
  /// **'Paneer'**
  String get paneer;

  /// No description provided for @totalAmount720.
  ///
  /// In en, this message translates to:
  /// **'₹720'**
  String get totalAmount720;

  /// No description provided for @administration.
  ///
  /// In en, this message translates to:
  /// **'Administration'**
  String get administration;

  /// No description provided for @synchronization.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get synchronization;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @selectScreenToPreview.
  ///
  /// In en, this message translates to:
  /// **'Select a screen to preview'**
  String get selectScreenToPreview;

  /// No description provided for @loginScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Screen'**
  String get loginScreenTitle;

  /// No description provided for @loginScreenDesc.
  ///
  /// In en, this message translates to:
  /// **'Authentication interface with email/password and social login'**
  String get loginScreenDesc;

  /// No description provided for @homeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Screen'**
  String get homeScreenTitle;

  /// No description provided for @homeScreenDesc.
  ///
  /// In en, this message translates to:
  /// **'Dashboard with inventory management menu items'**
  String get homeScreenDesc;

  /// No description provided for @navigationMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Navigation Menu'**
  String get navigationMenuTitle;

  /// No description provided for @navigationMenuDesc.
  ///
  /// In en, this message translates to:
  /// **'User profile and navigation options'**
  String get navigationMenuDesc;

  /// No description provided for @userSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'User Settings'**
  String get userSettingsTitle;

  /// No description provided for @userSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'App configuration and user settings'**
  String get userSettingsDesc;

  /// No description provided for @notificationDemoTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Demo'**
  String get notificationDemoTitle;

  /// No description provided for @notificationDemoDesc.
  ///
  /// In en, this message translates to:
  /// **'Animated smooth dropdown notification from top'**
  String get notificationDemoDesc;

  /// No description provided for @widgetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get widgetsTitle;

  /// No description provided for @widgetsDesc.
  ///
  /// In en, this message translates to:
  /// **'Status badges and UI cards (Inventory, Payment, etc.)'**
  String get widgetsDesc;

  /// No description provided for @flutterUIKitDemo.
  ///
  /// In en, this message translates to:
  /// **'Flutter UI Kit Demo - No Backend Required'**
  String get flutterUIKitDemo;

  /// No description provided for @pressButtonToSeeNotification.
  ///
  /// In en, this message translates to:
  /// **'Press the button below to see the notification'**
  String get pressButtonToSeeNotification;

  /// No description provided for @showNotification.
  ///
  /// In en, this message translates to:
  /// **'Show Notification'**
  String get showNotification;

  /// No description provided for @showCustomNotification.
  ///
  /// In en, this message translates to:
  /// **'Show Custom Notification'**
  String get showCustomNotification;

  /// No description provided for @newSalesEntry.
  ///
  /// In en, this message translates to:
  /// **'New Sales Entry'**
  String get newSalesEntry;

  /// No description provided for @anotherAlert.
  ///
  /// In en, this message translates to:
  /// **'Another Alert'**
  String get anotherAlert;

  /// No description provided for @dynamicTest.
  ///
  /// In en, this message translates to:
  /// **'This is a dynamic test'**
  String get dynamicTest;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @usersGroup.
  ///
  /// In en, this message translates to:
  /// **'Users Group'**
  String get usersGroup;

  /// No description provided for @authorizations.
  ///
  /// In en, this message translates to:
  /// **'Authorizations'**
  String get authorizations;

  /// No description provided for @companySettingsMenu.
  ///
  /// In en, this message translates to:
  /// **'Company\'s Settings'**
  String get companySettingsMenu;

  /// No description provided for @wmsSettings.
  ///
  /// In en, this message translates to:
  /// **'WMS Settings'**
  String get wmsSettings;

  /// No description provided for @searchUsers.
  ///
  /// In en, this message translates to:
  /// **'Search users...'**
  String get searchUsers;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter by'**
  String get filterBy;

  /// No description provided for @allUsers.
  ///
  /// In en, this message translates to:
  /// **'All Users'**
  String get allUsers;

  /// No description provided for @activeUsers.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeUsers;

  /// No description provided for @inactiveUsers.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactiveUsers;

  /// No description provided for @addNewUser.
  ///
  /// In en, this message translates to:
  /// **'Add New User'**
  String get addNewUser;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @manager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get manager;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this user?'**
  String get confirmDelete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @userDeleted.
  ///
  /// In en, this message translates to:
  /// **'User deleted successfully'**
  String get userDeleted;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsersFound;

  /// No description provided for @userCode.
  ///
  /// In en, this message translates to:
  /// **'User Code'**
  String get userCode;

  /// No description provided for @enterUserCode.
  ///
  /// In en, this message translates to:
  /// **'Enter user code'**
  String get enterUserCode;

  /// No description provided for @foreignName.
  ///
  /// In en, this message translates to:
  /// **'Foreign Name'**
  String get foreignName;

  /// No description provided for @enterForeignName.
  ///
  /// In en, this message translates to:
  /// **'Enter foreign name'**
  String get enterForeignName;

  /// No description provided for @selectUserGroup.
  ///
  /// In en, this message translates to:
  /// **'Select user group'**
  String get selectUserGroup;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @selectFontSize.
  ///
  /// In en, this message translates to:
  /// **'Select font size'**
  String get selectFontSize;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @userSaved.
  ///
  /// In en, this message translates to:
  /// **'User saved successfully'**
  String get userSaved;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importData;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportData;

  /// No description provided for @importFromERPToMobile.
  ///
  /// In en, this message translates to:
  /// **'Import from ERP to Mobile'**
  String get importFromERPToMobile;

  /// No description provided for @exportFromMobileToERP.
  ///
  /// In en, this message translates to:
  /// **'Export from Mobile to ERP'**
  String get exportFromMobileToERP;

  /// No description provided for @selectCompanyToImport.
  ///
  /// In en, this message translates to:
  /// **'Select company to import from'**
  String get selectCompanyToImport;

  /// No description provided for @selectCompanyToExport.
  ///
  /// In en, this message translates to:
  /// **'Select company to export to'**
  String get selectCompanyToExport;

  /// No description provided for @selectDataToImport.
  ///
  /// In en, this message translates to:
  /// **'Select data to import:'**
  String get selectDataToImport;

  /// No description provided for @selectDataToExport.
  ///
  /// In en, this message translates to:
  /// **'Select data to export:'**
  String get selectDataToExport;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @outbound.
  ///
  /// In en, this message translates to:
  /// **'Outbound'**
  String get outbound;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @move.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get move;

  /// No description provided for @confirmImport.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to import data?'**
  String get confirmImport;

  /// No description provided for @confirmExport.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to export data?'**
  String get confirmExport;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data imported successfully'**
  String get importSuccess;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data exported successfully'**
  String get exportSuccess;

  /// No description provided for @selectAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one data type'**
  String get selectAtLeastOne;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
