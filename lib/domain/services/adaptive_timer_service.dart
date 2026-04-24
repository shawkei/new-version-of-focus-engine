import '../../core/constants.dart';
import '../../data/models/session.dart';

class AdaptiveTimerService {
  int calculateAdaptiveDuration(List<Session> recentSessions) {
    if (recentSessions.length < 3) return AppConstants.defaultFocusDuration;

    final relevant = recentSessions.take(AppConstants.lookbackWindow).toList();

    final completedCount = relevant.where((s) => s.wasFocused == true).length;
    final failedCount = relevant.where((s) => s.wasFocused == false).length;
    final total = relevant.where((s) => s.wasFocused != null).length;

    if (total == 0) return AppConstants.defaultFocusDuration;

    final successRate = completedCount / total;

    int currentDuration = recentSessions.first.durationMinutes;

    if (successRate >= AppConstants.successThreshold && completedCount >= 3) {
      currentDuration += AppConstants.adjustmentStep;
    } else if (successRate <= AppConstants.failureThreshold && failedCount >= 2) {
      currentDuration -= AppConstants.adjustmentStep;
    }

    return currentDuration.clamp(
      AppConstants.minFocusDuration,
      AppConstants.maxFocusDuration,
    );
  }

  int applyEnergyModifier(int baseDuration, EnergyLevel energy) {
    final modified = switch (energy) {
      EnergyLevel.low => (baseDuration * 0.85).round(),
      EnergyLevel.normal => baseDuration,
      EnergyLevel.high => (baseDuration * 1.1).round(),
    };
    return modified.clamp(
      AppConstants.minFocusDuration,
      AppConstants.maxFocusDuration,
    );
  }
}
