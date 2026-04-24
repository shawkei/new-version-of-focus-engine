import '../../data/models/session.dart';

class Insight {
  final String text;
  final String type;

  const Insight({required this.text, required this.type});
}

class InsightsService {
  List<Insight> generate(List<Session> sessions) {
    if (sessions.length < 3) return [];

    final insights = <Insight>[];

    // Optimal duration insight
    final optimal = _findOptimalDuration(sessions);
    if (optimal != null) {
      insights.add(Insight(
        text: 'Your optimal session is $optimal minutes',
        type: 'duration',
      ));
    }

    // Time of day insight
    final timeInsight = _findBestTimeOfDay(sessions);
    if (timeInsight != null) {
      insights.add(Insight(
        text: timeInsight,
        type: 'time',
      ));
    }

    // Streak insight
    final streak = _calculateStreak(sessions);
    if (streak >= 3) {
      insights.add(Insight(
        text: '$streak day streak! Keep it up.',
        type: 'streak',
      ));
    }

    return insights;
  }

  int? _findOptimalDuration(List<Session> sessions) {
    final rated = sessions.where((s) => s.wasFocused == true).toList();
    if (rated.length < 3) return null;

    final avg = rated.map((s) => s.durationMinutes).reduce((a, b) => a + b) ~/ rated.length;
    return avg;
  }

  String? _findBestTimeOfDay(List<Session> sessions) {
    final rated = sessions.where((s) => s.wasFocused == true).toList();
    if (rated.length < 5) return null;

    final morning = rated.where((s) => s.startedAt.hour < 12).length;
    final afternoon = rated.where((s) => s.startedAt.hour >= 12 && s.startedAt.hour < 18).length;
    final evening = rated.where((s) => s.startedAt.hour >= 18).length;

    if (evening > afternoon && evening > morning) {
      return 'You focus better in the evening';
    } else if (afternoon > morning && afternoon > evening) {
      return 'You focus better in the afternoon';
    } else if (morning > afternoon && morning > evening) {
      return 'You focus better in the morning';
    }
    return null;
  }

  int _calculateStreak(List<Session> sessions) {
    if (sessions.isEmpty) return 0;

    sessions.sort((a, b) => b.endedAt.compareTo(a.endedAt));

    int streak = 0;
    DateTime checkDate = DateTime.now();

    while (true) {
      final hasSession = sessions.any((s) =>
          s.endedAt.year == checkDate.year &&
          s.endedAt.month == checkDate.month &&
          s.endedAt.day == checkDate.day &&
          s.wasFocused == true);

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
