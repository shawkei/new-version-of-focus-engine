import 'package:flutter/foundation.dart';
import 'session.dart';

@immutable
class UserSettings {
  final EnergyLevel energyLevel;
  final FocusGoal defaultGoal;
  final int dailyGoal;
  final bool darkMode;
  final String? lastInsight;

  const UserSettings({
    this.energyLevel = EnergyLevel.normal,
    this.defaultGoal = FocusGoal.work,
    this.dailyGoal = 4,
    this.darkMode = false,
    this.lastInsight,
  });

  UserSettings copyWith({
    EnergyLevel? energyLevel,
    FocusGoal? defaultGoal,
    int? dailyGoal,
    bool? darkMode,
    String? lastInsight,
  }) {
    return UserSettings(
      energyLevel: energyLevel ?? this.energyLevel,
      defaultGoal: defaultGoal ?? this.defaultGoal,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      darkMode: darkMode ?? this.darkMode,
      lastInsight: lastInsight ?? this.lastInsight,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'energyLevel': energyLevel.name,
      'defaultGoal': defaultGoal.name,
      'dailyGoal': dailyGoal,
      'darkMode': darkMode,
      'lastInsight': lastInsight,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      energyLevel: EnergyLevel.values.byName(json['energyLevel'] as String),
      defaultGoal: FocusGoal.values.byName(json['defaultGoal'] as String),
      dailyGoal: json['dailyGoal'] as int? ?? 4,
      darkMode: json['darkMode'] as bool? ?? false,
      lastInsight: json['lastInsight'] as String?,
    );
  }
}
