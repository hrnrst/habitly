import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _habitsChannelId = 'habits_channel';
  static const _subsChannelId = 'subscriptions_channel';

  static Future<void> init() async {
    tz.initializeTimeZones();
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleHabitReminder({
    required String habitId,
    required String habitName,
    required String emoji,
    int hour = 9,
    int minute = 0,
  }) async {
    await _plugin.zonedSchedule(
      id: _habitNotifId(habitId),
      title: '$emoji Alışkanlık Zamanı',
      body: '$habitName alışkanlığını unutma!',
      scheduledDate: _nextDailyInstance(hour, minute),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _habitsChannelId,
          'Alışkanlık Hatırlatıcıları',
          channelDescription: 'Günlük alışkanlık hatırlatmaları',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleSubscriptionReminder({
    required String subId,
    required String subName,
    required String emoji,
    required DateTime billingDate,
    required double amount,
    required String currency,
  }) async {
    final reminderDate = billingDate.subtract(const Duration(days: 3));
    if (reminderDate.isBefore(DateTime.now())) return;

    final symbol =
        currency == 'TRY' ? '₺' : (currency == 'USD' ? '\$' : '€');
    await _plugin.zonedSchedule(
      id: _subNotifId(subId),
      title: '$emoji Abonelik Yenileniyor',
      body:
          '$subName 3 gün sonra yenileniyor ($symbol${amount.toStringAsFixed(2)})',
      scheduledDate: tz.TZDateTime.from(reminderDate, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _subsChannelId,
          'Abonelik Hatırlatıcıları',
          channelDescription: 'Abonelik yenileme hatırlatmaları',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelHabitReminder(String habitId) =>
      _plugin.cancel(id: _habitNotifId(habitId));

  static Future<void> cancelSubscriptionReminder(String subId) =>
      _plugin.cancel(id: _subNotifId(subId));

  static Future<void> cancelAll() => _plugin.cancelAll();

  static tz.TZDateTime _nextDailyInstance(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  static int _habitNotifId(String id) => _stableHash('h_$id');
  static int _subNotifId(String id) => _stableHash('s_$id');

  static int _stableHash(String s) {
    var hash = 0;
    for (final c in s.codeUnits) {
      hash = (hash * 31 + c) & 0x7FFFFFFF;
    }
    return hash;
  }
}
