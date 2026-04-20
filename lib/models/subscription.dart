class Subscription {
  String id;
  String name;
  String emoji;
  double amount;
  String currency;
  String billingCycle; // monthly, yearly
  DateTime nextBillingDate;
  String category;

  Subscription({
    required this.id,
    required this.name,
    required this.emoji,
    required this.amount,
    this.currency = 'TRY',
    this.billingCycle = 'monthly',
    required this.nextBillingDate,
    this.category = 'Genel',
  });

  double get monthlyAmount {
    if (billingCycle == 'yearly') return amount / 12;
    return amount;
  }

  int get daysUntilBilling {
    return nextBillingDate.difference(DateTime.now()).inDays;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'emoji': emoji,
        'amount': amount,
        'currency': currency,
        'billingCycle': billingCycle,
        'nextBillingDate': nextBillingDate.toIso8601String(),
        'category': category,
      };

  factory Subscription.fromMap(Map<String, dynamic> map) => Subscription(
        id: map['id'],
        name: map['name'],
        emoji: map['emoji'],
        amount: map['amount'],
        currency: map['currency'],
        billingCycle: map['billingCycle'],
        nextBillingDate: DateTime.parse(map['nextBillingDate']),
        category: map['category'],
      );
}