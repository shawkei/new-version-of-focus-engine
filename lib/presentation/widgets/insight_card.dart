import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../domain/services/insights_service.dart';

class InsightCard extends StatelessWidget {
  final Insight insight;

  const InsightCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.accent.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _iconForType(insight.type),
            color: AppTheme.accent,
            size: 18,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              insight.text,
              style: const TextStyle(
                color: AppTheme.accent,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForType(String type) => switch (type) {
        'duration' => Icons.timer_outlined,
        'time' => Icons.wb_sunny_outlined,
        'streak' => Icons.local_fire_department_outlined,
        _ => Icons.lightbulb_outline,
      };
}
