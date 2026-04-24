import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/session_repository.dart';
import '../../data/models/session.dart';
import '../../data/models/focus_goal.dart';
import '../../data/models/user_settings.dart';
import '../../domain/services/adaptive_timer_service.dart';

class TimerState {
  final bool isRunning;
  final int durationMinutes;
  final double progress;
  final DateTime? startTime;
  final FocusGoal currentGoal;
  
  const TimerState({
    this.isRunning = false,
    this.durationMinutes = 25,
    this.progress = 0.0,
    this.startTime,
    this.currentGoal = FocusGoal.focus,
  });
  
  TimerState copyWith({
    bool? isRunning,
    int? durationMinutes,
    double? progress,
    DateTime? startTime,
    FocusGoal? currentGoal,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      progress: progress ?? this.progress,
      startTime: startTime ?? this.startTime,
      currentGoal: currentGoal ?? this.currentGoal,
    );
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(ref.read(sessionRepositoryProvider));
});

class TimerNotifier extends StateNotifier<TimerState> {
  final SessionRepository _repository;
  Timer? _timer;
  
  TimerNotifier(this._repository) : super(const TimerState());
  
  Future<void> start({FocusGoal? goal}) async {
    final settings = await _repository.getSettings();
    final adaptiveService = AdaptiveTimerService();
    final recentSessions = await _repository.getRecentSessions();
    
    int adaptiveDuration = adaptiveService.calculateAdaptiveDuration(recentSessions);
    adaptiveDuration = adaptiveService.applyEnergyModifier(adaptiveDuration, settings.energyLevel);
    
    final finalGoal = goal ?? FocusGoal.focus;
    
    state = TimerState(
      isRunning: true,
      durationMinutes: adaptiveDuration,
      progress: 0.0,
      startTime: DateTime.now(),
      currentGoal: finalGoal,
    );
    
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }
  
  void _tick() {
    if (state.startTime == null) return;
    
    final elapsed = DateTime.now().difference(state.startTime!).inSeconds;
    final totalSeconds = state.durationMinutes * 60;
    final newProgress = elapsed / totalSeconds;
    
    if (newProgress >= 1.0) {
      _complete();
    } else {
      state = state.copyWith(progress: newProgress);
    }
  }
  
  Future<void> _complete() async {
    _timer?.cancel();
    
    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startedAt: state.startTime!,
      endedAt: DateTime.now(),
      durationMinutes: state.durationMinutes,
      goal: state.currentGoal,
      wasFocused: null,
    );
    
    await _repository.saveSession(session);
    state = state.copyWith(isRunning: false, progress: 1.0);
  }
  
  void cancel() {
    _timer?.cancel();
    state = const TimerState();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
