import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/habit.dart';
import '../models/subscription.dart';
import 'notification_service.dart';

class StorageService extends ChangeNotifier {
  static const String _habitsBox = 'habits';
  static const String _subscriptionsBox = 'subscriptions';

  late Box _habits;
  late Box _subscriptions;

  Future<void> init() async {
    await Hive.initFlutter();
    _habits = await Hive.openBox(_habitsBox);
    _subscriptions = await Hive.openBox(_subscriptionsBox);
  }

  // HABITS
  List<Habit> getHabits() {
    return _habits.values
        .map((e) => Habit.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveHabit(Habit habit) async {
    await _habits.put(habit.id, habit.toMap());
    await NotificationService.scheduleHabitReminder(
      habitId: habit.id,
      habitName: habit.name,
      emoji: habit.emoji,
    );
    notifyListeners();
  }

  Future<void> deleteHabit(String id) async {
    await _habits.delete(id);
    await NotificationService.cancelHabitReminder(id);
    notifyListeners();
  }

  Future<void> toggleHabitToday(String id) async {
    final habits = getHabits();
    final habit = habits.firstWhere((h) => h.id == id);
    final today = DateTime.now();
    final key = '${today.year}-${today.month}-${today.day}';

    if (habit.completedDates.contains(key)) {
      habit.completedDates.remove(key);
    } else {
      habit.completedDates.add(key);
    }

    await _habits.put(habit.id, habit.toMap());
    notifyListeners();
  }

  // SUBSCRIPTIONS
  List<Subscription> getSubscriptions() {
    return _subscriptions.values
        .map((e) => Subscription.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveSubscription(Subscription subscription) async {
    await _subscriptions.put(subscription.id, subscription.toMap());
    await NotificationService.scheduleSubscriptionReminder(
      subId: subscription.id,
      subName: subscription.name,
      emoji: subscription.emoji,
      billingDate: subscription.nextBillingDate,
      amount: subscription.amount,
      currency: subscription.currency,
    );
    notifyListeners();
  }

  Future<void> deleteSubscription(String id) async {
    await _subscriptions.delete(id);
    await NotificationService.cancelSubscriptionReminder(id);
    notifyListeners();
  }

  double getTotalMonthlySpend() {
    return getSubscriptions().fold(0, (sum, s) => sum + s.monthlyAmount);
  }
}
