import 'package:flutter/material.dart';

enum FocusGoal { study, work, skill, custom }

class Session {
  final String id;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationMinutes;
  final FocusGoal goal;
  final bool? wasFocused;
  final EnergyLevel? energyLevel;
  
  Session({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.durationMinutes,
    required this.goal,
    this.wasFocused,
    this.energyLevel,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt.toIso8601String(),
      'durationMinutes': durationMinutes,
      'goal': goal.toString(),
      'wasFocused': wasFocused,
      'energyLevel': energyLevel.toString(),
    };
  }
  
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      startedAt: DateTime.parse(json['startedAt']),
      endedAt: DateTime.parse(json['endedAt']),
      durationMinutes: json['durationMinutes'],
      goal: _parseGoal(json['goal']),
      wasFocused: json['wasFocused'],
      energyLevel: _parseEnergyLevel(json['energyLevel']),
    );
  }
  
  static FocusGoal _parseGoal(String goal) {
    switch (goal) {
      case 'FocusGoal.study': return FocusGoal.study;
      case 'FocusGoal.work': return FocusGoal.work;
      case 'FocusGoal.skill': return FocusGoal.skill;
      default: return FocusGoal.custom;
    }
  }
  
  static EnergyLevel? _parseEnergyLevel(String? level) {
    if (level == null) return null;
    switch (level) {
      case 'EnergyLevel.low': return EnergyLevel.low;
      case 'EnergyLevel.high': return EnergyLevel.high;
      default: return EnergyLevel.normal;
    }
  }
}
