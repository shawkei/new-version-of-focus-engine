import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/session.dart';
import '../../data/models/daily_stats.dart';
import '../../data/repositories/session_repository.dart';
import '../../domain/services/progress_service.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository();
});

class SessionState {
  final List<Session> sessions;
  final DailyStats stats;
  final bool isLoading;

  const SessionState({
    this.sessions = const [],
    this.stats = const DailyStats(),
    this.isLoading = false,
  });

  SessionState copyWith({
    List<Session>? sessions,
    DailyStats? stats,
    bool? isLoading,
  }) {
    return SessionState(
      sessions: sessions ?? this.sessions,
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  final SessionRepository _repository;
  final ProgressService _progressService;

  SessionNotifier(this._repository)
      : _progressService = ProgressService(),
        super(const SessionState(isLoading: true)) {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final sessions = await _repository.getAllSessions();
    final settings = await _repository.getSettings();
    final stats = _progressService.calculateStats(sessions, dailyGoal: settings.dailyGoal);

    state = SessionState(
      sessions: sessions,
      stats: stats,
      isLoading: false,
    );
  }

  Future<void> rateSession(String sessionId, bool wasFocused) async {
    final sessions = [...state.sessions];
    final index = sessions.indexWhere((s) => s.id == sessionId);

    if (index != -1) {
      sessions[index] = sessions[index].copyWith(wasFocused: wasFocused);
      await _repository.updateSession(sessions[index]);

      final settings = await _repository.getSettings();
      final stats = _progressService.calculateStats(sessions, dailyGoal: settings.dailyGoal);

      state = state.copyWith(sessions: sessions, stats: stats);
    }
  }

  Future<void> refresh() async {
    await _loadSessions();
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier(ref.watch(sessionRepositoryProvider));
});
