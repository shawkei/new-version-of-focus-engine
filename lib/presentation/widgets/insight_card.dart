import 'package:flutter/material.dart';
import '../../core/theme.dart';

class InsightCard extends StatelessWidget {
  final String insight;
  
  const InsightCard({
    super.key,
    required this.insight,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lightbulb_outline, color: AppTheme.accent, size: 18),
          const SizedBox(width: 8),
          Text(
            insight,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
