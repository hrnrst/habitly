import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../theme/app_theme.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final completed = habit.isCompletedToday();

    return Dismissible(
      key: Key(habit.id),
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
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: completed
              ? AppTheme.success.withValues(alpha: 0.08)
              : AppTheme.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: completed
                ? AppTheme.success.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Text(habit.emoji, style: const TextStyle(fontSize: 32)),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: completed ? AppTheme.textSecondary : AppTheme.textPrimary,
              decoration: completed ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            child: Text(habit.name),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.local_fire_department,
                  size: 14, color: AppTheme.warning),
              const SizedBox(width: 4),
              Text(
                '${habit.streak} gün seri',
                style: const TextStyle(
                    color: AppTheme.warning, fontSize: 12),
              ),
            ],
          ),
          trailing: _CheckCircle(completed: completed, onTap: onToggle),
        ),
      ),
    );
  }
}

class _CheckCircle extends StatefulWidget {
  final bool completed;
  final VoidCallback onTap;

  const _CheckCircle({required this.completed, required this.onTap});

  @override
  State<_CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<_CheckCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween(begin: 1.0, end: 1.3).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.completed ? AppTheme.success : Colors.transparent,
            border: Border.all(
              color: widget.completed
                  ? AppTheme.success
                  : AppTheme.textSecondary,
              width: 2,
            ),
          ),
          child: widget.completed
              ? const Icon(Icons.check, size: 18, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
