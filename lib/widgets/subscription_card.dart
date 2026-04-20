import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../theme/app_theme.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription sub;
  final VoidCallback onDelete;

  const SubscriptionCard({
    super.key,
    required this.sub,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final urgent = sub.daysUntilBilling <= 3;
    final symbol =
        sub.currency == 'TRY' ? '₺' : (sub.currency == 'USD' ? '\$' : '€');

    return Dismissible(
      key: Key(sub.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.error.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: AppTheme.error),
      ),
      onDismissed: (_) => onDelete(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: urgent ? AppTheme.warning.withValues(alpha: 0.07) : AppTheme.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: urgent
                ? AppTheme.warning.withValues(alpha: 0.4)
                : Colors.transparent,
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Text(sub.emoji, style: const TextStyle(fontSize: 32)),
          title: Text(sub.name,
              style: const TextStyle(
                  color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
          subtitle: Row(
            children: [
              if (urgent)
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.warning_amber_rounded,
                      size: 13, color: AppTheme.warning),
                ),
              Text(
                sub.daysUntilBilling <= 0
                    ? 'Bugün yenileniyor!'
                    : '${sub.daysUntilBilling} gün sonra yenileniyor',
                style: TextStyle(
                  color: urgent ? AppTheme.warning : AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$symbol${sub.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                sub.billingCycle == 'monthly' ? 'aylık' : 'yıllık',
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
