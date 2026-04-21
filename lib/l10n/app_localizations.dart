import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Habitly'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get navHabits;

  /// No description provided for @navSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get navSubscriptions;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardSectionToday.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get dashboardSectionToday;

  /// No description provided for @dashboardSectionUpcoming.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING PAYMENTS'**
  String get dashboardSectionUpcoming;

  /// No description provided for @dashboardSectionPending.
  ///
  /// In en, this message translates to:
  /// **'PENDING TODAY'**
  String get dashboardSectionPending;

  /// No description provided for @dashboardGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning!'**
  String get dashboardGreetingMorning;

  /// No description provided for @dashboardGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon!'**
  String get dashboardGreetingAfternoon;

  /// No description provided for @dashboardGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening!'**
  String get dashboardGreetingEvening;

  /// No description provided for @dashboardProgressNoHabits.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get dashboardProgressNoHabits;

  /// No description provided for @dashboardProgressCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total} completed'**
  String dashboardProgressCompleted(int completed, int total);

  /// No description provided for @dashboardAllDone.
  ///
  /// In en, this message translates to:
  /// **'🎉 All habits completed for today!'**
  String get dashboardAllDone;

  /// No description provided for @dashboardStatStreak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get dashboardStatStreak;

  /// No description provided for @dashboardStatStreakValue.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String dashboardStatStreakValue(int count);

  /// No description provided for @dashboardStatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly Spend'**
  String get dashboardStatMonthly;

  /// No description provided for @dashboardStatHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get dashboardStatHabits;

  /// No description provided for @dashboardStatHabitsValue.
  ///
  /// In en, this message translates to:
  /// **'{count} total'**
  String dashboardStatHabitsValue(int count);

  /// No description provided for @dashboardStatSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get dashboardStatSubscriptions;

  /// No description provided for @dashboardStatSubscriptionsValue.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String dashboardStatSubscriptionsValue(int count);

  /// No description provided for @dashboardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to get started?'**
  String get dashboardEmptyTitle;

  /// No description provided for @dashboardEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a habit or subscription'**
  String get dashboardEmptySubtitle;

  /// No description provided for @habitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habitsTitle;

  /// No description provided for @habitsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get habitsEmpty;

  /// No description provided for @habitsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add one'**
  String get habitsEmptyHint;

  /// No description provided for @habitsStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} day streak'**
  String habitsStreakDays(int count);

  /// No description provided for @habitsAddTitle.
  ///
  /// In en, this message translates to:
  /// **'New Habit'**
  String get habitsAddTitle;

  /// No description provided for @habitsAddNameHint.
  ///
  /// In en, this message translates to:
  /// **'Habit name (e.g. Drink water, Read)'**
  String get habitsAddNameHint;

  /// No description provided for @habitsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get habitsAdd;

  /// No description provided for @subscriptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptionsTitle;

  /// No description provided for @subscriptionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions yet'**
  String get subscriptionsEmpty;

  /// No description provided for @subscriptionsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add one'**
  String get subscriptionsEmptyHint;

  /// No description provided for @subscriptionsSummaryMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get subscriptionsSummaryMonthly;

  /// No description provided for @subscriptionsSummaryActive.
  ///
  /// In en, this message translates to:
  /// **'Active Subscriptions'**
  String get subscriptionsSummaryActive;

  /// No description provided for @subscriptionsSummaryCount.
  ///
  /// In en, this message translates to:
  /// **'{count} subscriptions'**
  String subscriptionsSummaryCount(int count);

  /// No description provided for @subscriptionsRenewsToday.
  ///
  /// In en, this message translates to:
  /// **'Renews today!'**
  String get subscriptionsRenewsToday;

  /// No description provided for @subscriptionsRenewsInDays.
  ///
  /// In en, this message translates to:
  /// **'Renews in {days} days'**
  String subscriptionsRenewsInDays(int days);

  /// No description provided for @subscriptionsUpcomingDays.
  ///
  /// In en, this message translates to:
  /// **'In {days} days'**
  String subscriptionsUpcomingDays(int days);

  /// No description provided for @subscriptionsCycleMonthly.
  ///
  /// In en, this message translates to:
  /// **'monthly'**
  String get subscriptionsCycleMonthly;

  /// No description provided for @subscriptionsCycleYearly.
  ///
  /// In en, this message translates to:
  /// **'yearly'**
  String get subscriptionsCycleYearly;

  /// No description provided for @subscriptionsAddTitle.
  ///
  /// In en, this message translates to:
  /// **'New Subscription'**
  String get subscriptionsAddTitle;

  /// No description provided for @subscriptionsAddNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name (e.g. Netflix, Spotify)'**
  String get subscriptionsAddNameHint;

  /// No description provided for @subscriptionsAddAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get subscriptionsAddAmountHint;

  /// No description provided for @subscriptionsAddPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period:'**
  String get subscriptionsAddPeriod;

  /// No description provided for @subscriptionsAddMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionsAddMonthly;

  /// No description provided for @subscriptionsAddYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get subscriptionsAddYearly;

  /// No description provided for @subscriptionsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get subscriptionsAdd;

  /// No description provided for @notifHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'{emoji} Habit Time'**
  String notifHabitTitle(String emoji);

  /// No description provided for @notifHabitBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget your {name} habit!'**
  String notifHabitBody(String name);

  /// No description provided for @notifHabitChannelName.
  ///
  /// In en, this message translates to:
  /// **'Habit Reminders'**
  String get notifHabitChannelName;

  /// No description provided for @notifHabitChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily habit reminders'**
  String get notifHabitChannelDesc;

  /// No description provided for @notifSubTitle.
  ///
  /// In en, this message translates to:
  /// **'{emoji} Subscription Renewing'**
  String notifSubTitle(String emoji);

  /// No description provided for @notifSubBody.
  ///
  /// In en, this message translates to:
  /// **'{name} renews in 3 days ({amount})'**
  String notifSubBody(String name, String amount);

  /// No description provided for @notifSubChannelName.
  ///
  /// In en, this message translates to:
  /// **'Subscription Reminders'**
  String get notifSubChannelName;

  /// No description provided for @notifSubChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Subscription renewal reminders'**
  String get notifSubChannelDesc;
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
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
