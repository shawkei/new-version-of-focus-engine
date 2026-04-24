import '../local/local_storage.dart';
import '../models/session.dart';
import '../models/user_settings.dart';
import '../../core/constants.dart';

class SessionRepository {
  final LocalStorage _storage;

  SessionRepository({LocalStorage? storage}) : _storage = storage ?? LocalStorage();

  Future<List<Session>> getAllSessions() async {
    return await _storage.getSessions();
  }

  Future<List<Session>> getRecentSessions() async {
    final sessions = await getAllSessions();
    sessions.sort((a, b) => b.endedAt.compareTo(a.endedAt));
    return sessions.take(AppConstants.lookbackWindow).toList();
  }

  Future<List<Session>> getTodaySessions() async {
    final sessions = await getAllSessions();
    final now = DateTime.now();
    return sessions.where((s) {
      return s.endedAt.year == now.year &&
          s.endedAt.month == now.month &&
          s.endedAt.day == now.day;
    }).toList();
  }

  Future<void> saveSession(Session session) async {
    final sessions = await getAllSessions();
    sessions.add(session);
    await _storage.saveSessions(sessions);
  }

  Future<void> updateSession(Session updated) async {
    final sessions = await getAllSessions();
    final index = sessions.indexWhere((s) => s.id == updated.id);
    if (index != -1) {
      sessions[index] = updated;
      await _storage.saveSessions(sessions);
    }
  }

  Future<void> saveInterruptedSession(int durationMinutes) async {
    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startedAt: DateTime.now().subtract(Duration(minutes: durationMinutes)),
      endedAt: DateTime.now(),
      durationMinutes: durationMinutes,
      goal: FocusGoal.work,
      wasFocused: false,
    );
    await saveSession(session);
  }

  Future<UserSettings> getSettings() async {
    return await _storage.getSettings();
  }

  Future<void> saveSettings(UserSettings settings) async {
    await _storage.saveSettings(settings);
  }
}
