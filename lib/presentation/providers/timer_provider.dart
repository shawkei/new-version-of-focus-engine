
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/session.dart';
import '../../data/repositories/session_repository.dart';
import '../../domain/services/adaptive_timer_service.dart';
import '../../data/repositories/session_repository.dart';
import 'settings_provider.dart';

@immutable
class TimerState {
  final bool isRunning;
  final int durationMinutes;
  final double progress;
  final DateTime? startTime;
  final FocusGoal currentGoal;
  final bool isBreak;

  const TimerState({
    this.isRunning = false,
    this.durationMinutes = 25,
    this.progress = 0.0,
    this.startTime,
    this.currentGoal = FocusGoal.work,
    this.isBreak = false,
  });

  TimerState copyWith({
    bool? isRunning,
    int? durationMinutes,
    double? progress,
    DateTime? startTime,
    FocusGoal? currentGoal,
    bool? isBreak,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      progress: progress ?? this.progress,
      startTime: startTime ?? this.startTime,
      currentGoal: currentGoal ?? this.currentGoal,
      isBreak: isBreak ?? this.isBreak,
    );
  }

  String get formattedTime {
    if (startTime == null) {
      final mins = durationMinutes;
      final secs = 0;
      return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    final elapsed = DateTime.now().difference(startTime!).inSeconds;
    final totalSeconds = durationMinutes * 60;
    final remaining = (totalSeconds - elapsed).clamp(0, totalSeconds);
    final mins = remaining ~/ 60;
    final secs = remaining % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

class TimerNotifier extends StateNotifier<TimerState> {
  final SessionRepository _repository;
  Timer? _timer;

  TimerNotifier(this._repository) : super(const TimerState());

  Future<void> start({FocusGoal? goal}) async {
    if (state.isRunning) return;

    final settings = await _repository.getSettings();
    final recentSessions = await _repository.getRecentSessions();

    final adaptiveService = AdaptiveTimerService();
    final adaptiveDuration = adaptiveService.calculateAdaptiveDuration(recentSessions);
    final finalDuration = adaptiveService.applyEnergyModifier(
      adaptiveDuration,
      settings.energyLevel,
    );

    state = TimerState(
      isRunning: true,
      durationMinutes: finalDuration,
      progress: 0.0,
      startTime: DateTime.now(),
      currentGoal: goal ?? settings.defaultGoal,
      isBreak: false,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (state.startTime == null) return;

    final elapsed = DateTime.now().difference(state.startTime!).inSeconds;
    final totalSeconds = state.durationMinutes * 60;
    final progress = elapsed / totalSeconds;

    if (progress >= 1.0) {
      _complete();
    } else {
      state = state.copyWith(progress: progress);
    }
  }

  void _complete() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false, progress: 1.0);
  }

  Future<void> cancel() async {
    _timer?.cancel();
    await _repository.saveInterruptedSession(state.durationMinutes);
    state = const TimerState();
  }

  Future<Session> completeSession() async {
    _timer?.cancel();

    final session = Session(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startedAt: state.startTime ?? DateTime.now(),
      endedAt: DateTime.now(),
      durationMinutes: state.durationMinutes,
      goal: state.currentGoal,
      energyLevel: null,
    );

    await _repository.saveSession(session);
    state = const TimerState();
    return session;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier(ref.watch(sessionRepositoryProvider));
});
