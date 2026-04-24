import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../providers/timer_provider.dart';
import '../widgets/circular_timer.dart';
import '../widgets/breathing_background.dart';

/// Full-screen active timer with breathing background.
class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      body: Stack(
        children: [
          const BreathingBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Cancel button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _showCancelDialog(context, ref),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.error.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppTheme.error,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Session label
                  Text(
                    'Focusing',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timerState.activeSession?.goal.name ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 48),
                  // Timer
                  CircularTimer(
                    duration: timerState.durationMinutes,
                    progress: timerState.progress,
                    isRunning: true,
                    displayTime: timerState.displayTime,
                  ),
                  const Spacer(),
                  // Calm reminder
                  Text(
                    'Stay present. Breathe.',
                    style: TextStyle(
                      color: AppTheme.textSecondary.withOpacity(0.6),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
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
              Navigator.pop(context);
            },
            child: const Text('End', style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );
  }
}
