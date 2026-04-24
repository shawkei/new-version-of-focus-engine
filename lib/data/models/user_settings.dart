import 'energy_level.dart';

enum FocusGoalType { 
  focus,
  study,
  work,
  skill
}

class UserSettings {
  final int weeklyStreak;
  final EnergyLevel energyLevel;
  final String? lastInsight;
  final int dailyGoal;
  final FocusGoalType defaultGoal;
  
  const UserSettings({
    this.weeklyStreak = 0,
    this.energyLevel = EnergyLevel.normal,
    this.lastInsight,
    this.dailyGoal = 4,
    this.defaultGoal = FocusGoalType.focus,
  });
  
  UserSettings copyWith({
    int? weeklyStreak,
    EnergyLevel? energyLevel,
    String? lastInsight,
    int? dailyGoal,
    FocusGoalType? defaultGoal,
  }) {
    return UserSettings(
      weeklyStreak: weeklyStreak ?? this.weeklyStreak,
      energyLevel: energyLevel ?? this.energyLevel,
      lastInsight: lastInsight ?? this.lastInsight,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      defaultGoal: defaultGoal ?? this.defaultGoal,
    );
  }
}
