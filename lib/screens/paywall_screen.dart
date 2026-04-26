import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../l10n/app_localizations.dart';
import '../services/purchase_service.dart';
import '../theme/app_theme.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  Offerings? _offerings;
  Package? _selectedPackage;
  bool _loadingOfferings = true;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    final purchases = context.read<PurchaseService>();
    final offerings = await purchases.getOfferings();
    if (mounted) {
      setState(() {
        _offerings = offerings;
        _selectedPackage =
            offerings?.current?.annual ?? offerings?.current?.monthly;
        _loadingOfferings = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(l),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildFeatureList(l),
                    const SizedBox(height: 28),
                    if (!_loadingOfferings) _buildPackageSelector(l),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildFooter(l),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary,
            const Color(0xFF9C27B0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const Text('✨', style: TextStyle(fontSize: 28)),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l.paywallTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l.paywallSubtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList(AppLocalizations l) {
    final features = [
      ('♾️', l.paywallFeature1),
      ('💡', l.paywallFeature2),
      ('📊', l.paywallFeature3),
      ('💰', l.paywallFeature4),
      ('⏰', l.paywallFeature5),
    ];

    return Column(
      children: features
          .map((f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(f.$1,
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        f.$2,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.check_circle,
                        color: AppTheme.success, size: 20),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildPackageSelector(AppLocalizations l) {
    final current = _offerings?.current;
    if (current == null) return const SizedBox.shrink();

    final packages = <Package>[
      if (current.annual != null) current.annual!,
      if (current.monthly != null) current.monthly!,
    ];

    if (packages.isEmpty) return const SizedBox.shrink();

    return Column(
      children: packages.map((pkg) {
        final isSelected = _selectedPackage?.identifier == pkg.identifier;
        final isAnnual = pkg.packageType == PackageType.annual;
        final priceStr = pkg.storeProduct.priceString;
        final period = isAnnual ? l.paywallPerYear : l.paywallPerMonth;

        return GestureDetector(
          onTap: () => setState(() => _selectedPackage = pkg),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primary.withValues(alpha: 0.15)
                  : AppTheme.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppTheme.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primary
                          : AppTheme.textSecondary,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isAnnual ? 'Annual' : 'Monthly',
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          if (isAnnual) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.success,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                l.paywallBestValue,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '$priceStr $period',
                  style: TextStyle(
                    color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooter(AppLocalizations l) {
    return Consumer<PurchaseService>(
      builder: (context, purchases, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: purchases.isLoading || _selectedPackage == null
                      ? null
                      : () async {
                          final success =
                              await purchases.purchase(_selectedPackage!);
                          if (success && context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                  child: purchases.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          _selectedPackage == null
                              ? l.paywallLoading
                              : l.paywallSubscribe,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: purchases.isLoading
                        ? null
                        : () async {
                            final success =
                                await purchases.restorePurchases();
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(success
                                    ? l.paywallRestoreSuccess
                                    : l.paywallRestoreFail),
                                backgroundColor: success
                                    ? AppTheme.success
                                    : AppTheme.error,
                              ),
                            );
                            if (success) Navigator.pop(context);
                          },
                    child: Text(
                      l.paywallRestore,
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      l.paywallDismiss,
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Paywall'ı açmak için helper fonksiyon
Future<void> showPaywall(BuildContext context) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, _) => const PaywallScreen(),
      transitionsBuilder: (_, animation, _, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      ),
    ),
  );
}
