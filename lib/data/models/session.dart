import 'energy_level.dart';

enum FocusGoal { study, work, skill, custom, focus }

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
  
  Session copyWith({
    String? id,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    FocusGoal? goal,
    bool? wasFocused,
    EnergyLevel? energyLevel,
  }) {
    return Session(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      goal: goal ?? this.goal,
      wasFocused: wasFocused ?? this.wasFocused,
      energyLevel: energyLevel ?? this.energyLevel,
    );
  }
}
