import 'package:flutter/material.dart';
import '../../core/theme.dart';

/// Daily progress ring with count-up animation feel.
class ProgressRing extends StatelessWidget {
  final int completed;
  final int goal;
  final double size;

  const ProgressRing({
    super.key,
    required this.completed,
    required this.goal,
    this.size = 160,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (completed / goal).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: AppTheme.primary.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$completed/$goal',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Text(
                'sessions',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
