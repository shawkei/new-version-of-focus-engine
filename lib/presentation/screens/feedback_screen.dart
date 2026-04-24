import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/session.dart';
import '../providers/settings_provider.dart';
import '../providers/timer_provider.dart';
import 'progress_screen.dart';

class FeedbackScreen extends ConsumerWidget {
  final Session session;

  const FeedbackScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.check_circle_outline,
                size: 64,
                color: AppTheme.success,
              ),
              const SizedBox(height: 32),
              Text(
                'Session Complete',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                '${session.durationMinutes} minutes of ${session.goal.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 64),
              Text(
                'Did you stay focused?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _FeedbackButton(
                      label: 'Yes',
                      icon: Icons.thumb_up_outlined,
                      color: AppTheme.success,
                      onPressed: () => _handleFeedback(context, ref, true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _FeedbackButton(
                      label: 'No',
                      icon: Icons.thumb_down_outlined,
                      color: AppTheme.error,
                      onPressed: () => _handleFeedback(context, ref, false),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFeedback(BuildContext context, WidgetRef ref, bool wasFocused) async {
    HapticFeedback.mediumImpact();

    await ref.read(sessionProvider.notifier).rateSession(session.id, wasFocused);
    await ref.read(sessionProvider.notifier).refresh();

    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProgressScreen()),
      );
    }
  }
}

class _FeedbackButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _FeedbackButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
