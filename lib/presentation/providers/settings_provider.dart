import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/session.dart';
import '../../data/models/user_settings.dart';
import '../../data/repositories/session_repository.dart';

class SettingsNotifier extends StateNotifier<UserSettings> {
  final SessionRepository _repository;

  SettingsNotifier(this._repository) : super(const UserSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _repository.getSettings();
    state = settings;
  }

  Future<void> setEnergy(EnergyLevel energy) async {
    state = state.copyWith(energyLevel: energy);
    await _repository.saveSettings(state);
  }

  Future<void> setGoal(FocusGoal goal) async {
    state = state.copyWith(defaultGoal: goal);
    await _repository.saveSettings(state);
  }

  Future<void> setDailyGoal(int goal) async {
    state = state.copyWith(dailyGoal: goal);
    await _repository.saveSettings(state);
  }

  Future<void> setInsight(String insight) async {
    state = state.copyWith(lastInsight: insight);
    await _repository.saveSettings(state);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, UserSettings>((ref) {
  return SettingsNotifier(ref.watch(sessionRepositoryProvider));
});
