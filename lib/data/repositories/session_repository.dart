import '../models/session.dart';
import '../models/user_settings.dart';

class SessionRepository {
  List<Session> _sessions = [];
  UserSettings _settings = const UserSettings();
  
  Future<List<Session>> getRecentSessions() async {
    // Return last 5 sessions
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
  
  Future<void> saveInterruptedSession(int duration) async {
    // Handle interrupted session
  }
  
  Future<void> rateSession(String sessionId, bool wasFocused) async {
    final index = _sessions.indexWhere((s) => s.id == sessionId);
    if (index != -1) {
      _sessions[index] = Session(
        id: _sessions[index].id,
        startedAt: _sessions[index].startedAt,
        endedAt: _sessions[index].endedAt,
        durationMinutes: _sessions[index].durationMinutes,
        goal: _sessions[index].goal,
        wasFocused: wasFocused,
        energyLevel: _sessions[index].energyLevel,
      );
    }
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository();
});
