import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../models/user_profile.dart';

// Simple theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// Simple user profile provider - using the original UserProfile model
final userProfileSimpleProvider = StateProvider<UserProfile?>((ref) => null);

// Simple achievements provider - using the original Achievement model
final achievementsSimpleProvider = StateProvider<List<Achievement>>((ref) => []);

// Helper function to create default user profile
UserProfile createDefaultUserProfile(String name) {
  return UserProfile(
    name: name,
    age: '25',
    city: 'Unknown',
    primaryGoals: ['Health', 'Wealth'],
    healthGoal: 'Stay Fit',
    wealthGoal: 'Save Money',
    currentLevel: 'Beginner',
    streak: 0,
    level: 1,
    xp: 0,
  );
}

// Helper function to create default achievements
List<Achievement> createDefaultAchievements() {
  return [
    Achievement(
      id: 'first_login',
      title: 'Welcome Aboard!',
      description: 'Complete your first login',
      icon: '🎉',
      earned: false,
    ),
    Achievement(
      id: 'health_tracker',
      title: 'Health Tracker',
      description: 'Log your first health data',
      icon: '💪',
      earned: false,
    ),
    Achievement(
      id: 'wealth_builder',
      title: 'Wealth Builder',
      description: 'Set your first financial goal',
      icon: '💰',
      earned: false,
    ),
  ];
}
