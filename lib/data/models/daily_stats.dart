class DailyStats {
  final int todayCompleted;
  final int dailyGoal;
  final int weeklyTotal;
  final int weeklyStreak;
  final int weeklySessions;
  
  const DailyStats({
    this.todayCompleted = 0,
    this.dailyGoal = 4,
    this.weeklyTotal = 0,
    this.weeklyStreak = 0,
    this.weeklySessions = 0,
  });
  
  DailyStats copyWith({
    int? todayCompleted,
    int? dailyGoal,
    int? weeklyTotal,
    int? weeklyStreak,
    int? weeklySessions,
  }) {
    return DailyStats(
      todayCompleted: todayCompleted ?? this.todayCompleted,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      weeklyTotal: weeklyTotal ?? this.weeklyTotal,
      weeklyStreak: weeklyStreak ?? this.weeklyStreak,
      weeklySessions: weeklySessions ?? this.weeklySessions,
    );
  }
}
