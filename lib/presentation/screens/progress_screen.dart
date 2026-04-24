import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/daily_stats.dart';
import '../../domain/services/insights_service.dart';
import '../providers/session_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/insight_card.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(sessionProvider).stats;
    final sessions = ref.watch(sessionProvider).sessions;
    final insightsService = InsightsService();
    final insights = insightsService.generate(sessions);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Your Progress',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 48),
              _DailyProgressRing(
                completed: stats.todayCompleted,
                goal: stats.dailyGoal,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatCard(
                    label: 'Today',
                    value: '${stats.todayCompleted}',
                    unit: 'sessions',
                  ),
                  _StatCard(
                    label: 'This Week',
                    value: '${stats.weeklyTotal}',
                    unit: 'minutes',
                  ),
                  _StatCard(
                    label: 'Streak',
                    value: '${stats.weeklyStreak}',
                    unit: 'days',
                  ),
                ],
              ),
              const Spacer(),
              if (insights.isNotEmpty)
                InsightCard(insight: insights.first),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (insights.isNotEmpty) {
                      ref.read(settingsProvider.notifier).setInsight(insights.first.text);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyProgressRing extends StatelessWidget {
  final int completed;
  final int goal;

  const _DailyProgressRing({required this.completed, required this.goal});

  @override
  Widget build(BuildContext context) {
    final progress = (completed / goal).clamp(0.0, 1.0);

    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 12,
            backgroundColor: AppTheme.primary.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$completed/$goal',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 36,
                ),
              ),
              const Text(
                'sessions',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          unit,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
