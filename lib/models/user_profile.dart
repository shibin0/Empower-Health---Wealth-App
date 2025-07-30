import 'package:flutter/material.dart';

class UserProfile {
  final String? id;
  final String name;
  final String age;
  final String city;
  final List<String> primaryGoals;
  final String healthGoal;
  final String wealthGoal;
  final String currentLevel;
  final int xp;
  final int level;
  final int streak;
  final List<String> badges;
  final DateTime joinedDate;
  final DateTime? updatedAt;

  UserProfile({
    this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.primaryGoals,
    required this.healthGoal,
    required this.wealthGoal,
    required this.currentLevel,
    this.xp = 0,
    this.level = 1,
    this.streak = 0,
    this.badges = const [],
    DateTime? joinedDate,
    this.updatedAt,
  }) : joinedDate = joinedDate ?? DateTime.now();

  UserProfile copyWith({
    String? id,
    String? name,
    String? age,
    String? city,
    List<String>? primaryGoals,
    String? healthGoal,
    String? wealthGoal,
    String? currentLevel,
    int? xp,
    int? level,
    int? streak,
    List<String>? badges,
    DateTime? joinedDate,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      primaryGoals: primaryGoals ?? this.primaryGoals,
      healthGoal: healthGoal ?? this.healthGoal,
      wealthGoal: wealthGoal ?? this.wealthGoal,
      currentLevel: currentLevel ?? this.currentLevel,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      badges: badges ?? this.badges,
      joinedDate: joinedDate ?? this.joinedDate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'age': age,
      'city': city,
      'primary_goals': primaryGoals,
      'health_goal': healthGoal,
      'wealth_goal': wealthGoal,
      'current_level': currentLevel,
      'xp': xp,
      'level': level,
      'streak': streak,
      'badges': badges,
      'joined_date': joinedDate.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'] ?? 'User',
      age: json['age'] ?? '',
      city: json['city'] ?? '',
      primaryGoals: json['primary_goals'] != null
          ? List<String>.from(json['primary_goals'])
          : <String>[],
      healthGoal: json['health_goal'] ?? '',
      wealthGoal: json['wealth_goal'] ?? '',
      currentLevel: json['current_level'] ?? 'Beginner',
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      badges: json['badges'] != null
          ? List<String>.from(json['badges'])
          : <String>[],
      joinedDate: json['joined_date'] != null
          ? DateTime.parse(json['joined_date'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool earned;
  final DateTime? earnedDate;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.earned = false,
    this.earnedDate,
  });
}

class LearningModule {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int progress;
  final int totalLessons;
  final List<String> topics;
  final String category; // 'health' or 'wealth'

  LearningModule({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    required this.totalLessons,
    required this.topics,
    required this.category,
  });
}

class DailyTask {
  final String id;
  final String title;
  final String type; // 'health' or 'wealth'
  final bool completed;
  final int xpReward;

  DailyTask({
    required this.id,
    required this.title,
    required this.type,
    this.completed = false,
    this.xpReward = 10,
  });

  DailyTask copyWith({
    String? id,
    String? title,
    String? type,
    bool? completed,
    int? xpReward,
  }) {
    return DailyTask(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      completed: completed ?? this.completed,
      xpReward: xpReward ?? this.xpReward,
    );
  }
}