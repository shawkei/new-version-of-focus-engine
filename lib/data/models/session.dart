import 'package:flutter/foundation.dart';

enum FocusGoal { study, work, skill, custom }

enum EnergyLevel { low, normal, high }

@immutable
class Session {
  final String id;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationMinutes;
  final FocusGoal goal;
  final bool? wasFocused;
  final EnergyLevel? energyLevel;

  const Session({
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt.toIso8601String(),
      'durationMinutes': durationMinutes,
      'goal': goal.name,
      'wasFocused': wasFocused,
      'energyLevel': energyLevel?.name,
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      durationMinutes: json['durationMinutes'] as int,
      goal: FocusGoal.values.byName(json['goal'] as String),
      wasFocused: json['wasFocused'] as bool?,
      energyLevel: json['energyLevel'] != null
          ? EnergyLevel.values.byName(json['energyLevel'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'Session(id: $id, duration: $durationMinutes min, goal: $goal, focused: $wasFocused)';
  }
}
