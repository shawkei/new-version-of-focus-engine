import '../../data/models/user_settings.dart';
import '../../data/models/energy_level.dart';
// تأكد من وجود جميع الـ imports الصحيحة
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/session.dart';
import '../../data/models/daily_stats.dart';
import '../../domain/services/insights_service.dart';
import '../providers/timer_provider.dart';
import '../providers/session_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/circular_timer.dart';
import '../widgets/energy_selector.dart';
import '../widgets/goal_selector.dart';
import '../widgets/insight_card.dart';
import '../widgets/breathing_background.dart';
import 'feedback_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(timerProvider.notifier).addListener((state) {
        if (!state.isRunning && state.progress >= 1.0 && mounted) {
          _onTimerComplete();
        }
      });
    });
  }

  void _onTimerComplete() async {
    final notifier = ref.read(timerProvider.notifier);
    final session = await notifier.completeSession();

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FeedbackScreen(session: session),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final settings = ref.watch(settingsProvider);
    final sessionState = ref.watch(sessionProvider);

    return Scaffold(
      body: timerState.isRunning
          ? _ActiveTimerView(timerState: timerState)
          : _HomeView(
              timerState: timerState,
              settings: settings,
              stats: sessionState.stats,
            ),
    );
  }
}

class _HomeView extends ConsumerWidget {
  final TimerState timerState;
  final UserSettings settings;
  final DailyStats stats;

  const _HomeView({
    required this.timerState,
    required this.settings,
    required this.stats,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _StreakIndicator(streak: stats.weeklyStreak),
              ],
            ),
            const Spacer(),
            Hero(
              tag: 'timer',
              child: CircularTimer(
                duration: timerState.durationMinutes,
                progress: timerState.progress,
                isRunning: timerState.isRunning,
                timeText: timerState.formattedTime,
              ),
            ),
            const SizedBox(height: 48),
            EnergySelector(
              selected: settings.energyLevel,
              onChanged: (e) => ref.read(settingsProvider.notifier).setEnergy(e),
            ),
            const SizedBox(height: 20),
            GoalSelector(
              selected: settings.defaultGoal,
              onChanged: (g) => ref.read(settingsProvider.notifier).setGoal(g),
            ),
            const SizedBox(height: 40),
            _PrimaryButton(
              isRunning: timerState.isRunning,
              onPressed: () {
                HapticFeedback.lightImpact();
                ref.read(timerProvider.notifier).start();
              },
            ),
            const Spacer(),
            if (settings.lastInsight != null)
              InsightCard(
                insight: Insight(text: settings.lastInsight!, type: 'general'),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ActiveTimerView extends ConsumerWidget {
  final TimerState timerState;

  const _ActiveTimerView({required this.timerState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BreathingBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _showCancelDialog(context, ref),
                    icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                timerState.currentGoal.name.toUpperCase(),
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),
              CircularTimer(
                duration: timerState.durationMinutes,
                progress: timerState.progress,
                isRunning: timerState.isRunning,
                timeText: timerState.formattedTime,
              ),
              const SizedBox(height: 48),
              const Text(
                'Stay focused',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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
