import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../services/purchase_service.dart';
import '../models/subscription.dart';
import '../theme/app_theme.dart';
import '../widgets/subscription_card.dart';
import 'paywall_screen.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.subscriptionsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.primary),
            onPressed: () => _onAddTapped(context),
          ),
        ],
      ),
      body: Consumer<StorageService>(
        builder: (context, storage, _) {
          final subs = storage.getSubscriptions();
          final totalMonthly = storage.getTotalMonthlySpend();

          return Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: subs.isNotEmpty
                    ? _SummaryCard(
                        totalMonthly: totalMonthly, count: subs.length)
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: subs.isEmpty
                    ? _EmptyState()
                    : ListView.builder(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: subs.length,
                        itemBuilder: (context, index) {
                          return _AnimatedItem(
                            index: index,
                            child: SubscriptionCard(
                              sub: subs[index],
                              onDelete: () => storage
                                  .deleteSubscription(subs[index].id),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onAddTapped(BuildContext context) {
    final isPremium = context.read<PurchaseService>().isPremium;
    final storage = context.read<StorageService>();
    if (!storage.canAddSubscription(isPremium)) {
      showPaywall(context);
      return;
    }
    _showAddSubscriptionSheet(context);
  }

  void _showAddSubscriptionSheet(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    String selectedEmoji = '📺';
    String selectedCurrency = 'TRY';
    String selectedCycle = 'monthly';
    final DateTime nextBilling =
        DateTime.now().add(const Duration(days: 30));

    final emojis = [
      '📺', '🎵', '🎮', '☁️', '📰', '🏋️', '🎬', '📱', '💼', '🛒'
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
              24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.subscriptionsAddTitle,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  children: emojis
                      .map((e) => GestureDetector(
                            onTap: () =>
                                setModalState(() => selectedEmoji = e),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: selectedEmoji == e
                                    ? AppTheme.primary.withValues(alpha: 0.3)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: selectedEmoji == e
                                      ? AppTheme.primary
                                      : Colors.transparent,
                                ),
                              ),
                              child: Text(e,
                                  style: const TextStyle(fontSize: 24)),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  autofocus: true,
                  style: const TextStyle(color: AppTheme.textPrimary),
                  decoration: InputDecoration(
                      hintText: l.subscriptionsAddNameHint),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppTheme.textPrimary),
                        decoration: InputDecoration(
                            hintText: l.subscriptionsAddAmountHint),
                      ),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: selectedCurrency,
                      dropdownColor: AppTheme.surface,
                      style:
                          const TextStyle(color: AppTheme.textPrimary),
                      items: ['TRY', 'USD', 'EUR']
                          .map((c) => DropdownMenuItem(
                              value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) =>
                          setModalState(() => selectedCurrency = v!),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(l.subscriptionsAddPeriod,
                        style: const TextStyle(
                            color: AppTheme.textSecondary)),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: Text(l.subscriptionsAddMonthly),
                      selected: selectedCycle == 'monthly',
                      selectedColor: AppTheme.primary,
                      onSelected: (_) =>
                          setModalState(() => selectedCycle = 'monthly'),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: Text(l.subscriptionsAddYearly),
                      selected: selectedCycle == 'yearly',
                      selectedColor: AppTheme.primary,
                      onSelected: (_) =>
                          setModalState(() => selectedCycle = 'yearly'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) return;
                      if (amountController.text.trim().isEmpty) return;
                      final sub = Subscription(
                        id: const Uuid().v4(),
                        name: nameController.text.trim(),
                        emoji: selectedEmoji,
                        amount: double.tryParse(amountController.text) ?? 0,
                        currency: selectedCurrency,
                        billingCycle: selectedCycle,
                        nextBillingDate: nextBilling,
                      );
                      Provider.of<StorageService>(context, listen: false)
                          .saveSubscription(sub);
                      Navigator.pop(context);
                    },
                    child: Text(l.subscriptionsAdd,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double totalMonthly;
  final int count;

  const _SummaryCard({required this.totalMonthly, required this.count});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF9C27B0)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.subscriptionsSummaryMonthly,
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 4),
              Text(l.subscriptionsSummaryActive,
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: totalMonthly),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (_, value, _) => Text(
                  '₺${value.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(l.subscriptionsSummaryCount(count),
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('💳', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(l.subscriptionsEmpty,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 16)),
          const SizedBox(height: 8),
          Text(l.subscriptionsEmptyHint,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }
}

class _AnimatedItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _AnimatedItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + index * 50),
      curve: Curves.easeOut,
      builder: (_, value, _) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: child,
        ),
      ),
    );
  }
}
