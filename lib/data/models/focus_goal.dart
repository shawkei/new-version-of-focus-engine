enum FocusGoal { 
  focus,
  study,
  work,
  skill
}

extension FocusGoalExtension on FocusGoal {
  String get displayName {
    switch (this) {
      case FocusGoal.focus:
        return 'Focus';
      case FocusGoal.study:
        return 'Study';
      case FocusGoal.work:
        return 'Work';
      case FocusGoal.skill:
        return 'Skill';
    }
  }
}
