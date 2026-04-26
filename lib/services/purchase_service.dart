import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'notification_service.dart';

// RevenueCat Dashboard'dan alınacak API key'ler:
// https://app.revenuecat.com → Project → API Keys
const _androidApiKey = 'REVENUECAT_ANDROID_API_KEY'; // TODO: buraya kendi key'ini yaz
const _iosApiKey = 'REVENUECAT_IOS_API_KEY'; // TODO: buraya kendi key'ini yaz

// RevenueCat Dashboard'da tanımlanan entitlement ID
const _entitlementId = 'premium';

class PurchaseService extends ChangeNotifier {
  bool _isPremium = false;
  bool _isLoading = false;
  String? _error;

  bool get isPremium => _isPremium || kDebugMode && _debugPremiumOverride;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Debug modda premium'u simüle etmek için toggle edebilirsin
  static bool _debugPremiumOverride = true;
  static void debugTogglePremium() {
    _debugPremiumOverride = !_debugPremiumOverride;
  }

  Future<void> init() async {
    try {
      final apiKey = Platform.isIOS ? _iosApiKey : _androidApiKey;
      final config = PurchasesConfiguration(apiKey);
      await Purchases.configure(config);

      Purchases.addCustomerInfoUpdateListener((info) {
        final wasPremium = _isPremium;
        _isPremium = _checkPremium(info);
        if (_isPremium && !wasPremium) {
          NotificationService.scheduleDailyMotivation().catchError((_) {});
        } else if (!_isPremium && wasPremium) {
          NotificationService.cancelDailyMotivation().catchError((_) {});
        }
        notifyListeners();
      });

      final info = await Purchases.getCustomerInfo();
      _isPremium = _checkPremium(info);
      notifyListeners();
    } catch (e) {
      // API key henüz girilmemişse sessizce devam et
      debugPrint('PurchaseService init error: $e');
    }
  }

  Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('getOfferings error: $e');
      return null;
    }
  }

  Future<bool> purchase(Package package) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final info = await Purchases.purchasePackage(package);
      _isPremium = _checkPremium(info);
      notifyListeners();
      return _isPremium;
    } on PurchasesErrorCode catch (e) {
      if (e != PurchasesErrorCode.purchaseCancelledError) {
        _error = e.toString();
      }
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> restorePurchases() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final info = await Purchases.restorePurchases();
      _isPremium = _checkPremium(info);
      notifyListeners();
      return _isPremium;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _checkPremium(CustomerInfo info) {
    return info.entitlements.active.containsKey(_entitlementId);
  }
}
