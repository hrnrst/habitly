class Habit {
  String id;
  String name;
  String emoji;
  String frequency; // daily, weekly
  List<String> completedDates; // "2024-01-15" formatında
  DateTime createdAt;

  Habit({
    required this.id,
    required this.name,
    required this.emoji,
    this.frequency = 'daily',
    List<String>? completedDates,
    DateTime? createdAt,
  })  : completedDates = completedDates ?? [],
        createdAt = createdAt ?? DateTime.now();

  bool isCompletedToday() {
    final today = DateTime.now();
    final key = '${today.year}-${today.month}-${today.day}';
    return completedDates.contains(key);
  }

  int get streak {
    int count = 0;
    DateTime day = DateTime.now();
    while (true) {
      final key = '${day.year}-${day.month}-${day.day}';
      if (completedDates.contains(key)) {
        count++;
        day = day.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return count;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'emoji': emoji,
        'frequency': frequency,
        'completedDates': completedDates,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Habit.fromMap(Map<String, dynamic> map) => Habit(
        id: map['id'],
        name: map['name'],
        emoji: map['emoji'],
        frequency: map['frequency'],
        completedDates: List<String>.from(map['completedDates']),
        createdAt: DateTime.parse(map['createdAt']),
      );
}