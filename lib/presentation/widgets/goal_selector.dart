import 'package:flutter/material.dart';
import '../../data/models/focus_goal.dart';
import '../../core/theme.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onTap: () => onChanged(goal),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppTheme.primary : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                goal.displayName,
                style: TextStyle(
                  color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
