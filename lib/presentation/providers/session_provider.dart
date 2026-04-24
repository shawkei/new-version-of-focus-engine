import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/models/session.dart';
import '../../data/models/daily_stats.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier(ref.read(sessionRepositoryProvider));
});

class SessionState {
  final List<Session> sessions;
  final DailyStats stats;
  
  SessionState({
    this.sessions = const [],
    this.stats = const DailyStats(),
  });
  
  SessionState copyWith({
    List<Session>? sessions,
    DailyStats? stats,
  }) {
    return SessionState(
      sessions: sessions ?? this.sessions,
      stats: stats ?? this.stats,
    );
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  final SessionRepository _repository;
  
  SessionNotifier(this._repository) : super(SessionState()) {
    loadSessions();
  }
  
  Future<void> loadSessions() async {
    final sessions = await _repository.getAllSessions();
    final stats = await _repository.getDailyStats();
    state = state.copyWith(sessions: sessions, stats: stats);
  }
  
  Future<void> rateSession(String sessionId, bool wasFocused) async {
    await _repository.rateSession(sessionId, wasFocused);
    await loadSessions();
  }
  
  Future<void> refresh() async {
    await loadSessions();
  }
  
  Future<void> addSession(Session session) async {
    await _repository.saveSession(session);
    await loadSessions();
  }
}
