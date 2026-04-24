import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/user_settings.dart';
import '../../data/models/energy_level.dart';
import '../../data/models/focus_goal.dart';
import '../providers/timer_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/session_provider.dart';
import '../widgets/circular_timer.dart';
import '../widgets/energy_selector.dart';
import '../widgets/goal_selector.dart';
import '../widgets/insight_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final settings = ref.watch(settingsProvider);
    final sessionState = ref.watch(sessionProvider);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Subtle streak indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _StreakIndicator(streak: settings.weeklyStreak),
                ],
              ),
              
              const Spacer(),
              
              // Main timer
              Hero(
                tag: 'timer',
                child: CircularTimer(
                  duration: timerState.durationMinutes,
                  progress: timerState.progress,
                  isRunning: timerState.isRunning,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Energy selector (collapsible, subtle)
              if (!timerState.isRunning) ...[
                EnergySelector(
                  selected: settings.energyLevel,
                  onChanged: (e) => ref.read(settingsProvider.notifier).setEnergy(e),
                ),
                const SizedBox(height: 24),
                
                // Goal selector
                GoalSelector(
                  selected: _convertToFocusGoal(settings.defaultGoal),
                  onChanged: (goal) {
                    final newGoal = _convertToFocusGoalType(goal);
                    ref.read(settingsProvider.notifier).setGoal(newGoal);
                  },
                ),
                const SizedBox(height: 24),
              ],
              
              // Primary action
              _PrimaryButton(
                isRunning: timerState.isRunning,
                onPressed: () {
                  if (timerState.isRunning) {
                    _showCancelDialog(context, ref);
                  } else {
                    ref.read(timerProvider.notifier).start(
                      goal: _convertToFocusGoal(settings.defaultGoal),
                    );
                  }
                },
              ),
              
              const Spacer(),
              
              // Weekly insight (one line, subtle)
              if (settings.lastInsight != null)
                InsightCard(insight: settings.lastInsight!),
                
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  
  // تحويل من FocusGoalType (من user_settings) إلى FocusGoal (من focus_goal)
  FocusGoal _convertToFocusGoal(FocusGoalType type) {
    switch (type) {
      case FocusGoalType.focus:
        return FocusGoal.focus;
      case FocusGoalType.study:
        return FocusGoal.study;
      case FocusGoalType.work:
        return FocusGoal.work;
      case FocusGoalType.skill:
        return FocusGoal.skill;
    }
  }
  
  // تحويل من FocusGoal (من focus_goal) إلى FocusGoalType (من user_settings)
  FocusGoalType _convertToFocusGoalType(FocusGoal goal) {
    switch (goal) {
      case FocusGoal.focus:
        return FocusGoalType.focus;
      case FocusGoal.study:
        return FocusGoalType.study;
      case FocusGoal.work:
        return FocusGoalType.work;
      case FocusGoal.skill:
        return FocusGoalType.skill;
    }
  }
  
  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('End session?'),
        content: const Text('This will count as an interrupted session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep going'),
          ),
          TextButton(
            onPressed: () {
              ref.read(timerProvider.notifier).cancel();
              Navigator.pop(context);
            },
            child: const Text('End', style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onPressed;
  
  const _PrimaryButton({required this.isRunning, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isRunning ? AppTheme.error.withOpacity(0.1) : AppTheme.primary,
          foregroundColor: isRunning ? AppTheme.error : Colors.white,
          minimumSize: const Size(220, 60),
        ),
        child: Text(isRunning ? 'Cancel' : 'Start Focus'),
      ),
    );
  }
}

class _StreakIndicator extends StatelessWidget {
  final int streak;
  
  const _StreakIndicator({required this.streak});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: AppTheme.accent, size: 18),
          const SizedBox(width: 6),
          Text(
            '$streak day${streak == 1 ? '' : 's'}',
            style: const TextStyle(
              color: AppTheme.accent,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
