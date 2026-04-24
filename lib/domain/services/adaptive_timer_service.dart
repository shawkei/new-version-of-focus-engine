import '../../data/models/session.dart';
import '../../data/models/energy_level.dart';

class AdaptiveTimerService {
  static const int minDuration = 15;
  static const int maxDuration = 45;
  static const int defaultDuration = 25;
  static const int lookbackWindow = 5;
  static const int adjustmentStep = 2;

  int calculateAdaptiveDuration(List<Session> recentSessions) {
    if (recentSessions.length < 3) return defaultDuration;
    
    final relevant = recentSessions.take(lookbackWindow).toList();
    final completedCount = relevant.where((s) => s.wasFocused == true).length;
    final failedCount = relevant.where((s) => s.wasFocused == false).length;
    final total = relevant.where((s) => s.wasFocused != null).length;
    
    if (total == 0) return defaultDuration;
    
    final successRate = completedCount / total;
    int currentDuration = defaultDuration;
    
    if (successRate >= 0.8 && completedCount >= 3) {
      currentDuration = defaultDuration + adjustmentStep;
    } else if (successRate <= 0.4 && failedCount >= 2) {
      currentDuration = defaultDuration - adjustmentStep;
    }
    
    return currentDuration.clamp(minDuration, maxDuration);
  }
  
  int applyEnergyModifier(int baseDuration, EnergyLevel energy) {
    switch (energy) {
      case EnergyLevel.low:
        return (baseDuration * 0.85).round().clamp(minDuration, maxDuration);
      case EnergyLevel.normal:
        return baseDuration.clamp(minDuration, maxDuration);
      case EnergyLevel.high:
        return (baseDuration * 1.1).round().clamp(minDuration, maxDuration);
    }
  }
}
