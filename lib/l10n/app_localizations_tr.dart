// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Habitly';

  @override
  String get navDashboard => 'Özet';

  @override
  String get navHabits => 'Alışkanlıklar';

  @override
  String get navSubscriptions => 'Abonelikler';

  @override
  String get dashboardTitle => 'Özet';

  @override
  String get dashboardSectionToday => 'BUGÜN';

  @override
  String get dashboardSectionUpcoming => 'YAKLAŞAN ÖDEMELER';

  @override
  String get dashboardSectionPending => 'BUGÜN KALAN';

  @override
  String get dashboardGreetingMorning => 'Günaydın!';

  @override
  String get dashboardGreetingAfternoon => 'İyi günler!';

  @override
  String get dashboardGreetingEvening => 'İyi akşamlar!';

  @override
  String get dashboardProgressNoHabits => 'Henüz alışkanlık yok';

  @override
  String dashboardProgressCompleted(int completed, int total) {
    return '$completed / $total tamamlandı';
  }

  @override
  String get dashboardAllDone => '🎉 Bugünkü hedeflerin tamamlandı!';

  @override
  String get dashboardStatStreak => 'En Uzun Seri';

  @override
  String dashboardStatStreakValue(int count) {
    return '$count gün';
  }

  @override
  String get dashboardStatMonthly => 'Aylık Harcama';

  @override
  String get dashboardStatHabits => 'Alışkanlıklar';

  @override
  String dashboardStatHabitsValue(int count) {
    return '$count toplam';
  }

  @override
  String get dashboardStatSubscriptions => 'Abonelikler';

  @override
  String dashboardStatSubscriptionsValue(int count) {
    return '$count aktif';
  }

  @override
  String get dashboardEmptyTitle => 'Başlamaya hazır mısın?';

  @override
  String get dashboardEmptySubtitle => 'Alışkanlık veya abonelik ekle';

  @override
  String get habitsTitle => 'Alışkanlıklar';

  @override
  String get habitsEmpty => 'Henüz alışkanlık yok';

  @override
  String get habitsEmptyHint => '+ butonuyla ekleyebilirsin';

  @override
  String habitsStreakDays(int count) {
    return '$count gün seri';
  }

  @override
  String get habitsAddTitle => 'Yeni Alışkanlık';

  @override
  String get habitsAddNameHint => 'Alışkanlık adı (ör. Su iç, Kitap oku)';

  @override
  String get habitsAdd => 'Ekle';

  @override
  String get subscriptionsTitle => 'Abonelikler';

  @override
  String get subscriptionsEmpty => 'Henüz abonelik yok';

  @override
  String get subscriptionsEmptyHint => '+ butonuyla ekleyebilirsin';

  @override
  String get subscriptionsSummaryMonthly => 'Aylık Toplam';

  @override
  String get subscriptionsSummaryActive => 'Aktif Abonelikler';

  @override
  String subscriptionsSummaryCount(int count) {
    return '$count abonelik';
  }

  @override
  String get subscriptionsRenewsToday => 'Bugün yenileniyor!';

  @override
  String subscriptionsRenewsInDays(int days) {
    return '$days gün sonra yenileniyor';
  }

  @override
  String subscriptionsUpcomingDays(int days) {
    return '$days gün sonra';
  }

  @override
  String get subscriptionsCycleMonthly => 'aylık';

  @override
  String get subscriptionsCycleYearly => 'yıllık';

  @override
  String get subscriptionsAddTitle => 'Yeni Abonelik';

  @override
  String get subscriptionsAddNameHint => 'Abonelik adı (ör. Netflix, Spotify)';

  @override
  String get subscriptionsAddAmountHint => 'Tutar';

  @override
  String get subscriptionsAddPeriod => 'Dönem:';

  @override
  String get subscriptionsAddMonthly => 'Aylık';

  @override
  String get subscriptionsAddYearly => 'Yıllık';

  @override
  String get subscriptionsAdd => 'Ekle';

  @override
  String notifHabitTitle(String emoji) {
    return '$emoji Alışkanlık Zamanı';
  }

  @override
  String notifHabitBody(String name) {
    return '$name alışkanlığını unutma!';
  }

  @override
  String get notifHabitChannelName => 'Alışkanlık Hatırlatıcıları';

  @override
  String get notifHabitChannelDesc => 'Günlük alışkanlık hatırlatmaları';

  @override
  String notifSubTitle(String emoji) {
    return '$emoji Abonelik Yenileniyor';
  }

  @override
  String notifSubBody(String name, String amount) {
    return '$name 3 gün sonra yenileniyor ($amount)';
  }

  @override
  String get notifSubChannelName => 'Abonelik Hatırlatıcıları';

  @override
  String get notifSubChannelDesc => 'Abonelik yenileme hatırlatmaları';

  @override
  String get paywallTitle => 'Habitly Premium';

  @override
  String get paywallSubtitle => 'Daha iyi alışkanlıklar, daha akıllı yönetim';

  @override
  String get paywallFeature1 => 'Sınırsız alışkanlık ve abonelik';

  @override
  String get paywallFeature2 => 'Günlük ilham bildirimi';

  @override
  String get paywallFeature3 => 'Haftalık & aylık istatistikler';

  @override
  String get paywallFeature4 => 'Harcama analizi grafikleri';

  @override
  String get paywallFeature5 => 'Özel hatırlatıcı saatleri';

  @override
  String get paywallSubscribe => 'Premium\'a Geç';

  @override
  String get paywallRestore => 'Satın Alımları Geri Yükle';

  @override
  String get paywallDismiss => 'Şimdi Değil';

  @override
  String get paywallLoading => 'Yükleniyor...';

  @override
  String get paywallPerMonth => '/ ay';

  @override
  String get paywallPerYear => '/ yıl';

  @override
  String get paywallBestValue => 'En İyi Değer';

  @override
  String get paywallRestoreSuccess => 'Satın alımlar geri yüklendi!';

  @override
  String get paywallRestoreFail => 'Aktif abonelik bulunamadı.';

  @override
  String get freemiumHabitLimit =>
      'Ücretsiz planda 3 alışkanlık ekleyebilirsin. Sınırsız için Premium\'a geç.';

  @override
  String get freemiumSubLimit =>
      'Ücretsiz planda 3 abonelik ekleyebilirsin. Sınırsız için Premium\'a geç.';

  @override
  String get freemiumUpgrade => 'Premium\'a Geç';

  @override
  String get quoteOfTheDay => 'GÜNÜN İLHAMI';

  @override
  String get notifMotivationChannelName => 'Günlük İlham';

  @override
  String get notifMotivationChannelDesc => 'Sabah motivasyon bildirimleri';
}
