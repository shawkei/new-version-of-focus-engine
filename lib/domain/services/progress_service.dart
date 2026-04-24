import '../../core/constants.dart';
import '../../data/models/session.dart';
import '../../data/models/daily_stats.dart';

class ProgressService {
  DailyStats calculateStats(List<Session> sessions, {int dailyGoal = AppConstants.defaultDailyGoal}) {
    final now = DateTime.now();

    // Today's completed sessions
    final todaySessions = sessions.where((s) {
      return s.endedAt.year == now.year &&
          s.endedAt.month == now.month &&
          s.endedAt.day == now.day &&
          s.wasFocused == true;
    }).toList();

    // Weekly stats
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weeklySessions = sessions.where((s) {
      return s.endedAt.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          s.wasFocused == true;
    }).toList();

    final weeklyTotal = weeklySessions.fold<int>(
      0,
      (sum, s) => sum + s.durationMinutes,
    );

    // Streak calculation
    final streak = _calculateStreak(sessions);

    // Average session length
    final completed = sessions.where((s) => s.wasFocused == true).toList();
    final avgLength = completed.isEmpty
        ? 0.0
        : completed.fold<int>(0, (sum, s) => sum + s.durationMinutes) / completed.length;

    return DailyStats(
      todayCompleted: todaySessions.length,
      dailyGoal: dailyGoal,
      weeklyTotal: weeklyTotal,
      weeklyStreak: streak,
      weeklySessions: weeklySessions.length,
      averageSessionLength: avgLength,
    );
  }

  int _calculateStreak(List<Session> sessions) {
    if (sessions.isEmpty) return 0;

    final completed = sessions.where((s) => s.wasFocused == true).toList();
    completed.sort((a, b) => b.endedAt.compareTo(a.endedAt));

    int streak = 0;
    DateTime checkDate = DateTime.now();

    while (true) {
      final hasSession = completed.any((s) =>
          s.endedAt.year == checkDate.year &&
          s.endedAt.month == checkDate.month &&
          s.endedAt.day == checkDate.day);

      if (hasSession) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }
}
