// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Habitly';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navHabits => 'Habits';

  @override
  String get navSubscriptions => 'Subscriptions';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get dashboardSectionToday => 'TODAY';

  @override
  String get dashboardSectionUpcoming => 'UPCOMING PAYMENTS';

  @override
  String get dashboardSectionPending => 'PENDING TODAY';

  @override
  String get dashboardGreetingMorning => 'Good morning!';

  @override
  String get dashboardGreetingAfternoon => 'Good afternoon!';

  @override
  String get dashboardGreetingEvening => 'Good evening!';

  @override
  String get dashboardProgressNoHabits => 'No habits yet';

  @override
  String dashboardProgressCompleted(int completed, int total) {
    return '$completed / $total completed';
  }

  @override
  String get dashboardAllDone => '🎉 All habits completed for today!';

  @override
  String get dashboardStatStreak => 'Best Streak';

  @override
  String dashboardStatStreakValue(int count) {
    return '$count days';
  }

  @override
  String get dashboardStatMonthly => 'Monthly Spend';

  @override
  String get dashboardStatHabits => 'Habits';

  @override
  String dashboardStatHabitsValue(int count) {
    return '$count total';
  }

  @override
  String get dashboardStatSubscriptions => 'Subscriptions';

  @override
  String dashboardStatSubscriptionsValue(int count) {
    return '$count active';
  }

  @override
  String get dashboardEmptyTitle => 'Ready to get started?';

  @override
  String get dashboardEmptySubtitle => 'Add a habit or subscription';

  @override
  String get habitsTitle => 'Habits';

  @override
  String get habitsEmpty => 'No habits yet';

  @override
  String get habitsEmptyHint => 'Tap + to add one';

  @override
  String habitsStreakDays(int count) {
    return '$count day streak';
  }

  @override
  String get habitsAddTitle => 'New Habit';

  @override
  String get habitsAddNameHint => 'Habit name (e.g. Drink water, Read)';

  @override
  String get habitsAdd => 'Add';

  @override
  String get subscriptionsTitle => 'Subscriptions';

  @override
  String get subscriptionsEmpty => 'No subscriptions yet';

  @override
  String get subscriptionsEmptyHint => 'Tap + to add one';

  @override
  String get subscriptionsSummaryMonthly => 'Monthly Total';

  @override
  String get subscriptionsSummaryActive => 'Active Subscriptions';

  @override
  String subscriptionsSummaryCount(int count) {
    return '$count subscriptions';
  }

  @override
  String get subscriptionsRenewsToday => 'Renews today!';

  @override
  String subscriptionsRenewsInDays(int days) {
    return 'Renews in $days days';
  }

  @override
  String subscriptionsUpcomingDays(int days) {
    return 'In $days days';
  }

  @override
  String get subscriptionsCycleMonthly => 'monthly';

  @override
  String get subscriptionsCycleYearly => 'yearly';

  @override
  String get subscriptionsAddTitle => 'New Subscription';

  @override
  String get subscriptionsAddNameHint => 'Name (e.g. Netflix, Spotify)';

  @override
  String get subscriptionsAddAmountHint => 'Amount';

  @override
  String get subscriptionsAddPeriod => 'Period:';

  @override
  String get subscriptionsAddMonthly => 'Monthly';

  @override
  String get subscriptionsAddYearly => 'Yearly';

  @override
  String get subscriptionsAdd => 'Add';

  @override
  String notifHabitTitle(String emoji) {
    return '$emoji Habit Time';
  }

  @override
  String notifHabitBody(String name) {
    return 'Don\'t forget your $name habit!';
  }

  @override
  String get notifHabitChannelName => 'Habit Reminders';

  @override
  String get notifHabitChannelDesc => 'Daily habit reminders';

  @override
  String notifSubTitle(String emoji) {
    return '$emoji Subscription Renewing';
  }

  @override
  String notifSubBody(String name, String amount) {
    return '$name renews in 3 days ($amount)';
  }

  @override
  String get notifSubChannelName => 'Subscription Reminders';

  @override
  String get notifSubChannelDesc => 'Subscription renewal reminders';

  @override
  String get paywallTitle => 'Habitly Premium';

  @override
  String get paywallSubtitle => 'Build better habits, manage smarter';

  @override
  String get paywallFeature1 => 'Unlimited habits & subscriptions';

  @override
  String get paywallFeature2 => 'Daily inspiration notification';

  @override
  String get paywallFeature3 => 'Weekly & monthly statistics';

  @override
  String get paywallFeature4 => 'Spending analysis charts';

  @override
  String get paywallFeature5 => 'Custom reminder times';

  @override
  String get paywallSubscribe => 'Start Premium';

  @override
  String get paywallRestore => 'Restore Purchases';

  @override
  String get paywallDismiss => 'Maybe Later';

  @override
  String get paywallLoading => 'Loading...';

  @override
  String get paywallPerMonth => '/ month';

  @override
  String get paywallPerYear => '/ year';

  @override
  String get paywallBestValue => 'Best Value';

  @override
  String get paywallRestoreSuccess => 'Purchases restored!';

  @override
  String get paywallRestoreFail => 'No active subscription found.';

  @override
  String get freemiumHabitLimit =>
      'Free plan allows 3 habits. Upgrade to Premium for unlimited.';

  @override
  String get freemiumSubLimit =>
      'Free plan allows 3 subscriptions. Upgrade to Premium for unlimited.';

  @override
  String get freemiumUpgrade => 'Upgrade';

  @override
  String get quoteOfTheDay => 'QUOTE OF THE DAY';

  @override
  String get notifMotivationChannelName => 'Daily Inspiration';

  @override
  String get notifMotivationChannelDesc => 'Morning motivation quotes';
}
