import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/session.dart';
import '../models/user_settings.dart';
import '../models/daily_stats.dart';

class SessionRepository {
  List<Session> _sessions = [];
  UserSettings _settings = const UserSettings();
  
  Future<List<Session>> getRecentSessions() async {
    return _sessions.reversed.take(5).toList();
  }
  
  Future<UserSettings> getSettings() async {
    return _settings;
  }
  
  Future<void> saveSettings(UserSettings settings) async {
    _settings = settings;
  }
  
  Future<void> saveSession(Session session) async {
    _sessions.add(session);
  }
  
  Future<void> saveInterruptedSession(int duration) async {}
  
  Future<void> rateSession(String sessionId, bool wasFocused) async {
    final index = _sessions.indexWhere((s) => s.id == sessionId);
    if (index != -1) {
      final old = _sessions[index];
      _sessions[index] = Session(
        id: old.id,
        startedAt: old.startedAt,
        endedAt: old.endedAt,
        durationMinutes: old.durationMinutes,
        goal: old.goal,
        wasFocused: wasFocused,
        energyLevel: old.energyLevel,
      );
    }
  }
  
  Future<DailyStats> getDailyStats() async {
    return DailyStats(
      todayCompleted: _sessions.where((s) => 
        s.startedAt.day == DateTime.now().day && s.wasFocused == true).length,
      weeklyTotal: _sessions.where((s) => 
        s.startedAt.difference(DateTime.now()).inDays.abs() < 7).fold(0, (sum, s) => sum + s.durationMinutes),
      weeklyStreak: _settings.weeklyStreak,
      weeklySessions: _sessions.length,
    );
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository();
});
