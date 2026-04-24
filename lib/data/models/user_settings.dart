import 'energy_level.dart';

class UserSettings {
  final int weeklyStreak;
  final EnergyLevel energyLevel;
  final String? lastInsight;
  final int dailyGoal;
  
  const UserSettings({
    this.weeklyStreak = 0,
    this.energyLevel = EnergyLevel.normal,
    this.lastInsight,
    this.dailyGoal = 4,
  });
  
  UserSettings copyWith({
    int? weeklyStreak,
    EnergyLevel? energyLevel,
    String? lastInsight,
    int? dailyGoal,
  }) {
    return UserSettings(
      weeklyStreak: weeklyStreak ?? this.weeklyStreak,
      energyLevel: energyLevel ?? this.energyLevel,
      lastInsight: lastInsight ?? this.lastInsight,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }
}
