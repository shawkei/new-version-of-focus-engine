import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_settings.dart';
import '../../data/models/energy_level.dart';
import '../../data/repositories/session_repository.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, UserSettings>((ref) {
  return SettingsNotifier(ref.read(sessionRepositoryProvider));
});

class SettingsNotifier extends StateNotifier<UserSettings> {
  final SessionRepository _repository;
  
  SettingsNotifier(this._repository) : super(const UserSettings());
  
  void setEnergy(EnergyLevel energy) {
    state = state.copyWith(energyLevel: energy);
    _repository.saveSettings(state);
  }
  
  void setGoal(FocusGoalType goal) {
    state = state.copyWith(defaultGoal: goal);
    _repository.saveSettings(state);
  }
  
  void updateStreak(int streak) {
    state = state.copyWith(weeklyStreak: streak);
    _repository.saveSettings(state);
  }
  
  void setInsight(String insight) {
    state = state.copyWith(lastInsight: insight);
    _repository.saveSettings(state);
  }
}
