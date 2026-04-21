import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'dashboard_screen.dart';
import 'habits_screen.dart';
import 'subscriptions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    HabitsScreen(),
    SubscriptionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: l.navDashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_circle_outline),
            activeIcon: const Icon(Icons.check_circle),
            label: l.navHabits,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.credit_card_outlined),
            activeIcon: const Icon(Icons.credit_card),
            label: l.navSubscriptions,
          ),
        ],
      ),
    );
  }
}
