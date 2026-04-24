import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../data/models/session.dart';

class EnergySelector extends StatelessWidget {
  final EnergyLevel selected;
  final ValueChanged<EnergyLevel> onChanged;

  const EnergySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How is your energy?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: EnergyLevel.values.map((level) {
            final isSelected = level == selected;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () => onChanged(level),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _energyColor(level).withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? _energyColor(level) : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    _energyLabel(level),
                    style: TextStyle(
                      color: isSelected ? _energyColor(level) : AppTheme.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _energyColor(EnergyLevel level) => switch (level) {
        EnergyLevel.low => const Color(0xFF7B8FA1),
        EnergyLevel.normal => AppTheme.primary,
        EnergyLevel.high => AppTheme.accent,
      };

  String _energyLabel(EnergyLevel level) => switch (level) {
        EnergyLevel.low => 'Low',
        EnergyLevel.normal => 'Normal',
        EnergyLevel.high => 'High',
      };
}
