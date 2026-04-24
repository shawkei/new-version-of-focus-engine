import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/session.dart';
import '../models/user_settings.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveSessions(List<Session> sessions) async {
    await init();
    final jsonList = sessions.map((s) => jsonEncode(s.toJson())).toList();
    await _prefs!.setStringList('focus_sessions', jsonList);
  }

  Future<List<Session>> getSessions() async {
    await init();
    final jsonList = _prefs!.getStringList('focus_sessions') ?? [];
    return jsonList
        .map((json) => Session.fromJson(jsonDecode(json) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveSettings(UserSettings settings) async {
    await init();
    await _prefs!.setString('user_settings', jsonEncode(settings.toJson()));
  }

  Future<UserSettings> getSettings() async {
    await init();
    final json = _prefs!.getString('user_settings');
    if (json == null) return const UserSettings();
    return UserSettings.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> clearAll() async {
    await init();
    await _prefs!.clear();
  }
}
