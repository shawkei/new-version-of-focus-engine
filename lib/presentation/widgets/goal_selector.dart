import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../data/models/session.dart';

class GoalSelector extends StatelessWidget {
  final FocusGoal selected;
  final ValueChanged<FocusGoal> onChanged;

  const GoalSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: FocusGoal.values.map((goal) {
        final isSelected = goal == selected;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () => onChanged(goal),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppTheme.primary : AppTheme.textSecondary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                _goalLabel(goal),
                style: TextStyle(
                  color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _goalLabel(FocusGoal goal) => switch (goal) {
        FocusGoal.study => 'Study',
        FocusGoal.work => 'Work',
        FocusGoal.skill => 'Skill',
        FocusGoal.custom => 'Custom',
      };
}
