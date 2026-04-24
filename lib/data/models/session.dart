import 'energy_level.dart';

enum FocusGoal { study, work, skill, custom }

class Session {
  final String id;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationMinutes;
  final FocusGoal goal;
  final bool? wasFocused;
  final EnergyLevel? energyLevel;
  
  Session({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.durationMinutes,
    required this.goal,
    this.wasFocused,
    this.energyLevel,
  });
}
