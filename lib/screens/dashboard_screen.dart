import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../models/subscription.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.dashboardTitle)),
      body: Consumer<StorageService>(
        builder: (context, storage, _) {
          final habits = storage.getHabits();
          final subs = storage.getSubscriptions();
          final completedToday =
              habits.where((h) => h.isCompletedToday()).length;
          final totalMonthly = storage.getTotalMonthlySpend();
          final maxStreak = habits.isEmpty
              ? 0
              : habits.map((h) => h.streak).reduce((a, b) => a > b ? a : b);
          final completionRate =
              habits.isEmpty ? 0.0 : completedToday / habits.length;

          final upcomingSubs = subs
              .where(
                  (s) => s.daysUntilBilling <= 7 && s.daysUntilBilling >= 0)
              .toList()
            ..sort(
                (a, b) => a.daysUntilBilling.compareTo(b.daysUntilBilling));

          final pendingHabits =
              habits.where((h) => !h.isCompletedToday()).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Greeting(),
                const SizedBox(height: 20),
                _sectionLabel(l.dashboardSectionToday),
                const SizedBox(height: 10),
                _ProgressCard(
                  completed: completedToday,
                  total: habits.length,
                  rate: completionRate,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        emoji: '🔥',
                        label: l.dashboardStatStreak,
                        value: l.dashboardStatStreakValue(maxStreak),
                        color: AppTheme.warning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        emoji: '💳',
                        label: l.dashboardStatMonthly,
                        value: '₺${totalMonthly.toStringAsFixed(0)}',
                        color: AppTheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        emoji: '✅',
                        label: l.dashboardStatHabits,
                        value: l.dashboardStatHabitsValue(habits.length),
                        color: AppTheme.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        emoji: '📋',
                        label: l.dashboardStatSubscriptions,
                        value:
                            l.dashboardStatSubscriptionsValue(subs.length),
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
                if (upcomingSubs.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _sectionLabel(l.dashboardSectionUpcoming),
                  const SizedBox(height: 10),
                  ...upcomingSubs.map((s) => _UpcomingPaymentTile(sub: s)),
                ],
                if (pendingHabits.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _sectionLabel(l.dashboardSectionPending),
                  const SizedBox(height: 10),
                  ...pendingHabits.map((h) => _PendingHabitTile(
                        emoji: h.emoji,
                        name: h.name,
                        streak: h.streak,
                      )),
                ],
                if (habits.isEmpty && subs.isEmpty) ...[
                  const SizedBox(height: 60),
                  Center(
                    child: Column(
                      children: [
                        const Text('🚀', style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 16),
                        Text(
                          l.dashboardEmptyTitle,
                          style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l.dashboardEmptySubtitle,
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTheme.textSecondary,
          letterSpacing: 1.2,
        ),
      );
}

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    final String greeting;
    final String emoji;
    if (hour < 12) {
      greeting = l.dashboardGreetingMorning;
      emoji = '☀️';
    } else if (hour < 18) {
      greeting = l.dashboardGreetingAfternoon;
      emoji = '👋';
    } else {
      greeting = l.dashboardGreetingEvening;
      emoji = '🌙';
    }
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary),
        children: [
          TextSpan(text: greeting),
          TextSpan(text: ' $emoji'),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final int completed;
  final int total;
  final double rate;

  const _ProgressCard({
    required this.completed,
    required this.total,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, AppTheme.primary.withValues(alpha: 0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                total == 0
                    ? l.dashboardProgressNoHabits
                    : l.dashboardProgressCompleted(completed, total),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${(rate * 100).toInt()}%',
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: rate),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (_, value, _) => LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                minHeight: 8,
              ),
            ),
          ),
          if (total > 0 && completed == total) ...[
            const SizedBox(height: 10),
            Text(
              l.dashboardAllDone,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}

class _UpcomingPaymentTile extends StatelessWidget {
  final Subscription sub;

  const _UpcomingPaymentTile({required this.sub});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final urgent = sub.daysUntilBilling <= 3;
    final symbol =
        sub.currency == 'TRY' ? '₺' : (sub.currency == 'USD' ? '\$' : '€');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: urgent
                ? AppTheme.warning.withValues(alpha: 0.5)
                : Colors.transparent),
      ),
      child: Row(
        children: [
          Text(sub.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sub.name,
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600)),
                Text(
                  sub.daysUntilBilling == 0
                      ? l.subscriptionsRenewsToday
                      : l.subscriptionsUpcomingDays(sub.daysUntilBilling),
                  style: TextStyle(
                      color:
                          urgent ? AppTheme.warning : AppTheme.textSecondary,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '$symbol${sub.amount.toStringAsFixed(2)}',
            style: const TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _PendingHabitTile extends StatelessWidget {
  final String emoji;
  final String name;
  final int streak;

  const _PendingHabitTile({
    required this.emoji,
    required this.name,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name,
                style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600)),
          ),
          if (streak > 0) ...[
            const Icon(Icons.local_fire_department,
                size: 14, color: AppTheme.warning),
            const SizedBox(width: 4),
            Text('$streak',
                style: const TextStyle(
                    color: AppTheme.warning,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}
