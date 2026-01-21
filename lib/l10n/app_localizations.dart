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
  /// **'Select Company'**
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

  /// No description provided for @receivingFromVendor.
  ///
  /// In en, this message translates to:
  /// **'Receiving from Vendor'**
  String get receivingFromVendor;

  /// No description provided for @grpo.
  ///
  /// In en, this message translates to:
  /// **'GRPO'**
  String get grpo;

  /// No description provided for @packOfStorage.
  ///
  /// In en, this message translates to:
  /// **'Pack for Storage'**
  String get packOfStorage;

  /// No description provided for @putAway.
  ///
  /// In en, this message translates to:
  /// **'Put Away'**
  String get putAway;

  /// No description provided for @poNumber.
  ///
  /// In en, this message translates to:
  /// **'PO #'**
  String get poNumber;

  /// No description provided for @receivingDate.
  ///
  /// In en, this message translates to:
  /// **'Receiving Date'**
  String get receivingDate;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @searchGRPO.
  ///
  /// In en, this message translates to:
  /// **'Search by PO, Vendor, Reference...'**
  String get searchGRPO;

  /// No description provided for @advancedFilters.
  ///
  /// In en, this message translates to:
  /// **'Advanced Filters'**
  String get advancedFilters;

  /// No description provided for @createNewGRPO.
  ///
  /// In en, this message translates to:
  /// **'Create New GRPO'**
  String get createNewGRPO;

  /// No description provided for @scanQR.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQR;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @suppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get suppliers;

  /// No description provided for @searchSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Search suppliers...'**
  String get searchSuppliers;

  /// No description provided for @supplierCode.
  ///
  /// In en, this message translates to:
  /// **'Supplier Code'**
  String get supplierCode;

  /// No description provided for @supplierName.
  ///
  /// In en, this message translates to:
  /// **'Supplier Name'**
  String get supplierName;

  /// No description provided for @supplierNumber.
  ///
  /// In en, this message translates to:
  /// **'Supplier Number'**
  String get supplierNumber;

  /// No description provided for @additionalItem.
  ///
  /// In en, this message translates to:
  /// **'Additional Item'**
  String get additionalItem;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @itemCode.
  ///
  /// In en, this message translates to:
  /// **'Item Code'**
  String get itemCode;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @poReference.
  ///
  /// In en, this message translates to:
  /// **'PO Reference'**
  String get poReference;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @carton.
  ///
  /// In en, this message translates to:
  /// **'Carton'**
  String get carton;

  /// No description provided for @manual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @inventoryList.
  ///
  /// In en, this message translates to:
  /// **'Inventory List'**
  String get inventoryList;

  /// No description provided for @searchInventory.
  ///
  /// In en, this message translates to:
  /// **'Search by item code, name, barcode...'**
  String get searchInventory;

  /// No description provided for @authorizationGroup.
  ///
  /// In en, this message translates to:
  /// **'Authorization Group'**
  String get authorizationGroup;

  /// No description provided for @barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode;

  /// No description provided for @remainingQty.
  ///
  /// In en, this message translates to:
  /// **'Remaining Qty'**
  String get remainingQty;

  /// No description provided for @bins.
  ///
  /// In en, this message translates to:
  /// **'Bins'**
  String get bins;

  /// No description provided for @uom.
  ///
  /// In en, this message translates to:
  /// **'UOM'**
  String get uom;

  /// No description provided for @batch.
  ///
  /// In en, this message translates to:
  /// **'Batch'**
  String get batch;

  /// No description provided for @productionDate.
  ///
  /// In en, this message translates to:
  /// **'Production Date'**
  String get productionDate;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @enterNotes.
  ///
  /// In en, this message translates to:
  /// **'Enter Notes...'**
  String get enterNotes;

  /// No description provided for @addBatch.
  ///
  /// In en, this message translates to:
  /// **'Add Batch'**
  String get addBatch;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all the fields'**
  String get pleaseFillAllFields;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @selectBin.
  ///
  /// In en, this message translates to:
  /// **'Select Bin'**
  String get selectBin;

  /// No description provided for @enterBatch.
  ///
  /// In en, this message translates to:
  /// **'Enter Batch'**
  String get enterBatch;

  /// No description provided for @enterQuantity.
  ///
  /// In en, this message translates to:
  /// **'Enter Quantity'**
  String get enterQuantity;

  /// No description provided for @recordList.
  ///
  /// In en, this message translates to:
  /// **'Record List'**
  String get recordList;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @prodDate.
  ///
  /// In en, this message translates to:
  /// **'Prod Date'**
  String get prodDate;

  /// No description provided for @expDate.
  ///
  /// In en, this message translates to:
  /// **'ExpDate'**
  String get expDate;

  /// No description provided for @noBatchesAdded.
  ///
  /// In en, this message translates to:
  /// **'No batches added yet'**
  String get noBatchesAdded;

  /// No description provided for @packageList.
  ///
  /// In en, this message translates to:
  /// **'Package List'**
  String get packageList;

  /// No description provided for @packId.
  ///
  /// In en, this message translates to:
  /// **'Pack ID'**
  String get packId;

  /// No description provided for @printed.
  ///
  /// In en, this message translates to:
  /// **'Printed'**
  String get printed;

  /// No description provided for @notPrinted.
  ///
  /// In en, this message translates to:
  /// **'Not Printed'**
  String get notPrinted;

  /// No description provided for @printAll.
  ///
  /// In en, this message translates to:
  /// **'Print All'**
  String get printAll;

  /// No description provided for @printSelected.
  ///
  /// In en, this message translates to:
  /// **'Print Selected'**
  String get printSelected;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @addStatus.
  ///
  /// In en, this message translates to:
  /// **'Add Status'**
  String get addStatus;

  /// No description provided for @batchesSerials.
  ///
  /// In en, this message translates to:
  /// **'Batches / Serials'**
  String get batchesSerials;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @bad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get bad;

  /// No description provided for @damaged.
  ///
  /// In en, this message translates to:
  /// **'Damaged'**
  String get damaged;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @addQuantity.
  ///
  /// In en, this message translates to:
  /// **'Add Quantity'**
  String get addQuantity;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @selectStatus.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get selectStatus;

  /// No description provided for @selectBatch.
  ///
  /// In en, this message translates to:
  /// **'Select Batch'**
  String get selectBatch;

  /// No description provided for @partiallyReceived.
  ///
  /// In en, this message translates to:
  /// **'Partially Received'**
  String get partiallyReceived;

  /// No description provided for @fullyReceived.
  ///
  /// In en, this message translates to:
  /// **'Fully Received'**
  String get fullyReceived;

  /// No description provided for @notReceived.
  ///
  /// In en, this message translates to:
  /// **'Not Received'**
  String get notReceived;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @quitActivity.
  ///
  /// In en, this message translates to:
  /// **'Quit Activity'**
  String get quitActivity;

  /// No description provided for @quitActivityMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save your progress or discard the data?'**
  String get quitActivityMessage;

  /// No description provided for @saveContinueLater.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue Later'**
  String get saveContinueLater;

  /// No description provided for @discardData.
  ///
  /// In en, this message translates to:
  /// **'Discard Data'**
  String get discardData;

  /// No description provided for @bookingDate.
  ///
  /// In en, this message translates to:
  /// **'Booking Date'**
  String get bookingDate;

  /// No description provided for @timeBooking.
  ///
  /// In en, this message translates to:
  /// **'Time Booking'**
  String get timeBooking;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @proceedToPacking.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Packing'**
  String get proceedToPacking;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @inReceiving.
  ///
  /// In en, this message translates to:
  /// **'In Receiving'**
  String get inReceiving;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @bpReference.
  ///
  /// In en, this message translates to:
  /// **'BP Reference'**
  String get bpReference;

  /// No description provided for @driverName.
  ///
  /// In en, this message translates to:
  /// **'Driver Name'**
  String get driverName;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created By'**
  String get createdBy;

  /// No description provided for @saveAsDraft.
  ///
  /// In en, this message translates to:
  /// **'Save as Draft'**
  String get saveAsDraft;

  /// No description provided for @enterBPReference.
  ///
  /// In en, this message translates to:
  /// **'Enter BP Reference'**
  String get enterBPReference;

  /// No description provided for @enterDriverName.
  ///
  /// In en, this message translates to:
  /// **'Enter Driver Name'**
  String get enterDriverName;

  /// No description provided for @enterCarInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter Car Info'**
  String get enterCarInfo;

  /// No description provided for @enterComments.
  ///
  /// In en, this message translates to:
  /// **'Enter Comments'**
  String get enterComments;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @addSignature.
  ///
  /// In en, this message translates to:
  /// **'Add Signature'**
  String get addSignature;

  /// No description provided for @drawYourSignature.
  ///
  /// In en, this message translates to:
  /// **'Draw Your Signature'**
  String get drawYourSignature;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @packaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get packaging;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @totalCartons.
  ///
  /// In en, this message translates to:
  /// **'Total Cartons'**
  String get totalCartons;

  /// No description provided for @totalQuantity.
  ///
  /// In en, this message translates to:
  /// **'Total Quantity'**
  String get totalQuantity;

  /// No description provided for @printStatus.
  ///
  /// In en, this message translates to:
  /// **'Print Status'**
  String get printStatus;

  /// No description provided for @cartonNumber.
  ///
  /// In en, this message translates to:
  /// **'Carton Number'**
  String get cartonNumber;

  /// No description provided for @searchCartons.
  ///
  /// In en, this message translates to:
  /// **'Search cartons, items, or batches'**
  String get searchCartons;

  /// No description provided for @addCarton.
  ///
  /// In en, this message translates to:
  /// **'Add Carton'**
  String get addCarton;

  /// No description provided for @editCarton.
  ///
  /// In en, this message translates to:
  /// **'Edit Carton'**
  String get editCarton;

  /// No description provided for @deleteCarton.
  ///
  /// In en, this message translates to:
  /// **'Delete Carton'**
  String get deleteCarton;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @packForStorage.
  ///
  /// In en, this message translates to:
  /// **'Pack for Storage'**
  String get packForStorage;

  /// No description provided for @packing.
  ///
  /// In en, this message translates to:
  /// **'Packing'**
  String get packing;

  /// No description provided for @scanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get scanBarcode;

  /// No description provided for @receivingNumber.
  ///
  /// In en, this message translates to:
  /// **'Receiving Number'**
  String get receivingNumber;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @startPacking.
  ///
  /// In en, this message translates to:
  /// **'Start Packing'**
  String get startPacking;

  /// No description provided for @fromBins.
  ///
  /// In en, this message translates to:
  /// **'From Bins'**
  String get fromBins;

  /// No description provided for @toBin.
  ///
  /// In en, this message translates to:
  /// **'To Bin'**
  String get toBin;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @binWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Bin Warehouse'**
  String get binWarehouse;

  /// No description provided for @toBins.
  ///
  /// In en, this message translates to:
  /// **'To Bins'**
  String get toBins;

  /// No description provided for @cartonId.
  ///
  /// In en, this message translates to:
  /// **'Carton ID'**
  String get cartonId;

  /// No description provided for @batches.
  ///
  /// In en, this message translates to:
  /// **'Batches'**
  String get batches;

  /// No description provided for @attribute1.
  ///
  /// In en, this message translates to:
  /// **'Attribute1'**
  String get attribute1;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @multiSelect.
  ///
  /// In en, this message translates to:
  /// **'Multi-Select'**
  String get multiSelect;

  /// No description provided for @searchRoles.
  ///
  /// In en, this message translates to:
  /// **'Search roles by name...'**
  String get searchRoles;

  /// No description provided for @noRolesFound.
  ///
  /// In en, this message translates to:
  /// **'No roles found'**
  String get noRolesFound;

  /// No description provided for @editPermissions.
  ///
  /// In en, this message translates to:
  /// **'Edit Permissions'**
  String get editPermissions;

  /// No description provided for @permissionsFor.
  ///
  /// In en, this message translates to:
  /// **'Permissions for'**
  String get permissionsFor;

  /// No description provided for @permissionModules.
  ///
  /// In en, this message translates to:
  /// **'Permission Modules'**
  String get permissionModules;

  /// No description provided for @grantAccess.
  ///
  /// In en, this message translates to:
  /// **'Grant Access'**
  String get grantAccess;

  /// No description provided for @revokeAccess.
  ///
  /// In en, this message translates to:
  /// **'Revoke Access'**
  String get revokeAccess;

  /// No description provided for @representative.
  ///
  /// In en, this message translates to:
  /// **'Representative'**
  String get representative;

  /// No description provided for @warehouseKeeper.
  ///
  /// In en, this message translates to:
  /// **'Warehouse-keeper'**
  String get warehouseKeeper;

  /// No description provided for @clerk.
  ///
  /// In en, this message translates to:
  /// **'Clerk'**
  String get clerk;

  /// No description provided for @wClerk.
  ///
  /// In en, this message translates to:
  /// **'w-clerk'**
  String get wClerk;

  /// No description provided for @customRole.
  ///
  /// In en, this message translates to:
  /// **'Custom Role'**
  String get customRole;

  /// No description provided for @permissionsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Permissions updated successfully'**
  String get permissionsUpdated;

  /// No description provided for @returnToVendorPermission.
  ///
  /// In en, this message translates to:
  /// **'Return To Vendor'**
  String get returnToVendorPermission;

  /// No description provided for @deliveryToCustomerPermission.
  ///
  /// In en, this message translates to:
  /// **'Delivery To Customer'**
  String get deliveryToCustomerPermission;

  /// No description provided for @returnFromCustomerPermission.
  ///
  /// In en, this message translates to:
  /// **'Return From Customer'**
  String get returnFromCustomerPermission;

  /// No description provided for @inventoryTransferPermission.
  ///
  /// In en, this message translates to:
  /// **'Inventory Transfer'**
  String get inventoryTransferPermission;

  /// No description provided for @inventoryTransferInPermission.
  ///
  /// In en, this message translates to:
  /// **'Inventory Transfer In'**
  String get inventoryTransferInPermission;

  /// No description provided for @inventoryMovePermission.
  ///
  /// In en, this message translates to:
  /// **'Inventory Move'**
  String get inventoryMovePermission;

  /// No description provided for @goodReceiptsPermission.
  ///
  /// In en, this message translates to:
  /// **'Good Receipts'**
  String get goodReceiptsPermission;

  /// No description provided for @goodIssuePermission.
  ///
  /// In en, this message translates to:
  /// **'Good Issue'**
  String get goodIssuePermission;

  /// No description provided for @transactionsPermission.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsPermission;

  /// No description provided for @administrationPermission.
  ///
  /// In en, this message translates to:
  /// **'Administration'**
  String get administrationPermission;

  /// No description provided for @synchronizationPermission.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get synchronizationPermission;

  /// No description provided for @receivingFromVendorPermission.
  ///
  /// In en, this message translates to:
  /// **'Receiving From Vendor'**
  String get receivingFromVendorPermission;

  /// No description provided for @companyManagement.
  ///
  /// In en, this message translates to:
  /// **'Company Management'**
  String get companyManagement;

  /// No description provided for @searchCompanies.
  ///
  /// In en, this message translates to:
  /// **'Search companies by name...'**
  String get searchCompanies;

  /// No description provided for @noCompaniesFound.
  ///
  /// In en, this message translates to:
  /// **'No companies found'**
  String get noCompaniesFound;

  /// No description provided for @addCompany.
  ///
  /// In en, this message translates to:
  /// **'Add Company'**
  String get addCompany;

  /// No description provided for @editCompany.
  ///
  /// In en, this message translates to:
  /// **'Edit Company'**
  String get editCompany;

  /// No description provided for @deleteCompany.
  ///
  /// In en, this message translates to:
  /// **'Delete Company'**
  String get deleteCompany;

  /// No description provided for @syncCompany.
  ///
  /// In en, this message translates to:
  /// **'Sync Company'**
  String get syncCompany;

  /// No description provided for @companyCode.
  ///
  /// In en, this message translates to:
  /// **'Company Code'**
  String get companyCode;

  /// No description provided for @enterCompanyCode.
  ///
  /// In en, this message translates to:
  /// **'Enter company code'**
  String get enterCompanyCode;

  /// No description provided for @databaseConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Database Configuration'**
  String get databaseConfiguration;

  /// No description provided for @connectionDatabase.
  ///
  /// In en, this message translates to:
  /// **'Connection Database'**
  String get connectionDatabase;

  /// No description provided for @enterDatabaseName.
  ///
  /// In en, this message translates to:
  /// **'Enter database name'**
  String get enterDatabaseName;

  /// No description provided for @connectionServer.
  ///
  /// In en, this message translates to:
  /// **'Connection Server'**
  String get connectionServer;

  /// No description provided for @enterServerAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter server address'**
  String get enterServerAddress;

  /// No description provided for @connectionUsername.
  ///
  /// In en, this message translates to:
  /// **'Connection Username'**
  String get connectionUsername;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get enterUsername;

  /// No description provided for @connectionPassword.
  ///
  /// In en, this message translates to:
  /// **'Connection Password'**
  String get connectionPassword;

  /// No description provided for @enterConnectionPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter connection password'**
  String get enterConnectionPassword;

  /// No description provided for @connectionPort.
  ///
  /// In en, this message translates to:
  /// **'Connection Port'**
  String get connectionPort;

  /// No description provided for @enterPort.
  ///
  /// In en, this message translates to:
  /// **'Enter port'**
  String get enterPort;

  /// No description provided for @databaseType.
  ///
  /// In en, this message translates to:
  /// **'Database Type'**
  String get databaseType;

  /// No description provided for @selectDatabaseType.
  ///
  /// In en, this message translates to:
  /// **'Select database type'**
  String get selectDatabaseType;

  /// No description provided for @sqlServer.
  ///
  /// In en, this message translates to:
  /// **'SQL Server'**
  String get sqlServer;

  /// No description provided for @mysql.
  ///
  /// In en, this message translates to:
  /// **'MySQL'**
  String get mysql;

  /// No description provided for @postgresql.
  ///
  /// In en, this message translates to:
  /// **'PostgreSQL'**
  String get postgresql;

  /// No description provided for @oracle.
  ///
  /// In en, this message translates to:
  /// **'Oracle'**
  String get oracle;

  /// No description provided for @erpIntegration.
  ///
  /// In en, this message translates to:
  /// **'ERP Integration'**
  String get erpIntegration;

  /// No description provided for @erpUser.
  ///
  /// In en, this message translates to:
  /// **'ERP User'**
  String get erpUser;

  /// No description provided for @enterErpUser.
  ///
  /// In en, this message translates to:
  /// **'Enter ERP user'**
  String get enterErpUser;

  /// No description provided for @erpPassword.
  ///
  /// In en, this message translates to:
  /// **'ERP Password'**
  String get erpPassword;

  /// No description provided for @enterErpPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter ERP password'**
  String get enterErpPassword;

  /// No description provided for @erpAddress.
  ///
  /// In en, this message translates to:
  /// **'ERP Address'**
  String get erpAddress;

  /// No description provided for @enterErpAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter ERP address/endpoint'**
  String get enterErpAddress;

  /// No description provided for @companySaved.
  ///
  /// In en, this message translates to:
  /// **'Company saved successfully'**
  String get companySaved;

  /// No description provided for @companyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Company deleted successfully'**
  String get companyDeleted;

  /// No description provided for @companySynced.
  ///
  /// In en, this message translates to:
  /// **'Company synced successfully'**
  String get companySynced;

  /// No description provided for @confirmDeleteCompany.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this company?'**
  String get confirmDeleteCompany;

  /// No description provided for @pleaseEnterCompanyCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter company code'**
  String get pleaseEnterCompanyCode;

  /// No description provided for @companyInformation.
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get companyInformation;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @loginWithFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Login with Fingerprint'**
  String get loginWithFingerprint;

  /// No description provided for @biometricAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get biometricAuthentication;

  /// No description provided for @touchSensorToLogin.
  ///
  /// In en, this message translates to:
  /// **'Touch sensor to login'**
  String get touchSensorToLogin;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication not available'**
  String get biometricNotAvailable;

  /// No description provided for @biometricAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get biometricAuthFailed;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @signInWith.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get signInWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;
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
