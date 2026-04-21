import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../models/habit.dart';
import '../theme/app_theme.dart';
import '../widgets/habit_card.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.habitsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.primary),
            onPressed: () => _showAddHabitSheet(context),
          ),
        ],
      ),
      body: Consumer<StorageService>(
        builder: (context, storage, _) {
          final habits = storage.getHabits();
          if (habits.isEmpty) {
            return _EmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              return _AnimatedItem(
                index: index,
                child: HabitCard(
                  habit: habits[index],
                  onToggle: () => storage.toggleHabitToday(habits[index].id),
                  onDelete: () => storage.deleteHabit(habits[index].id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddHabitSheet(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    String selectedEmoji = '⭐';
    final emojis = ['⭐', '💪', '📚', '🏃', '💧', '🧘', '🎯', '🍎', '😴', '✍️'];

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.habitsAddTitle,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                children: emojis
                    .map((e) => GestureDetector(
                          onTap: () => setModalState(() => selectedEmoji = e),
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
                decoration: InputDecoration(hintText: l.habitsAddNameHint),
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
                    final habit = Habit(
                      id: const Uuid().v4(),
                      name: nameController.text.trim(),
                      emoji: selectedEmoji,
                    );
                    Provider.of<StorageService>(context, listen: false)
                        .saveHabit(habit);
                    Navigator.pop(context);
                  },
                  child: Text(l.habitsAdd,
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
          const Text('🌱', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(l.habitsEmpty,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 16)),
          const SizedBox(height: 8),
          Text(l.habitsEmptyHint,
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
