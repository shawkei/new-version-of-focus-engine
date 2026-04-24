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
  
  Future<List<Session>> getAllSessions() async {
    return _sessions;
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
  
  Future<void> updateSession(Session session) async {
    final index = _sessions.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      _sessions[index] = session;
    }
  }
  
  Future<void> saveInterruptedSession(int duration) async {}
  
  Future<void> rateSession(String sessionId, bool wasFocused) async {
    final index = _sessions.indexWhere((s) => s.id == sessionId);
    if (index != -1) {
      final old = _sessions[index];
      _sessions[index] = old.copyWith(wasFocused: wasFocused);
    }
  }
  
  Future<DailyStats> getDailyStats() async {
    final today = DateTime.now();
    final weekAgo = DateTime.now().subtract(Duration(days: 7));
    
    final todaySessions = _sessions.where((s) => 
      s.startedAt.day == today.day && 
      s.startedAt.month == today.month && 
      s.wasFocused == true);
    
    final weekSessions = _sessions.where((s) => 
      s.startedAt.isAfter(weekAgo));
    
    final totalMinutes = weekSessions.fold(0, (sum, s) => sum + s.durationMinutes);
    final avgLength = weekSessions.isEmpty ? 0 : totalMinutes ~/ weekSessions.length;
    
    return DailyStats(
      todayCompleted: todaySessions.length,
      dailyGoal: _settings.dailyGoal,
      weeklyTotal: totalMinutes,
      weeklyStreak: _settings.weeklyStreak,
      weeklySessions: weekSessions.length,
      averageSessionLength: avgLength,
    );
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository();
});
