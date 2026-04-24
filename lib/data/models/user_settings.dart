import 'energy_level.dart';

enum FocusGoal { study, work, skill, custom }

class UserSettings {
  final int weeklyStreak;
  final EnergyLevel energyLevel;
  final String? lastInsight;
  final int dailyGoal;
  final FocusGoal defaultGoal;
  
  const UserSettings({
    this.weeklyStreak = 0,
    this.energyLevel = EnergyLevel.normal,
    this.lastInsight,
    this.dailyGoal = 4,
    this.defaultGoal = FocusGoal.focus,
  });
  
  UserSettings copyWith({
    int? weeklyStreak,
    EnergyLevel? energyLevel,
    String? lastInsight,
    int? dailyGoal,
    FocusGoal? defaultGoal,
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
