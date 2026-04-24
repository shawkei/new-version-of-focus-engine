class AppConstants {
  // Timer boundaries (minutes)
  static const int minFocusDuration = 15;
  static const int maxFocusDuration = 45;
  static const int defaultFocusDuration = 25;
  static const int defaultBreakDuration = 5;

  // Adaptive logic
  static const int lookbackWindow = 5;
  static const int adjustmentStep = 2;
  static const double successThreshold = 0.8;
  static const double failureThreshold = 0.4;

  // Storage keys
  static const String sessionsKey = 'focus_sessions';
  static const String settingsKey = 'user_settings';
  static const String statsKey = 'daily_stats';

  // Daily goal default
  static const int defaultDailyGoal = 4;
}
