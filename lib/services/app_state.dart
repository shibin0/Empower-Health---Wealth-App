import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class AppState extends ChangeNotifier {
  UserProfile? _userProfile;
  int _currentTabIndex = 0;
  List<DailyTask> _dailyTasks = [];
  final Map<String, dynamic> _trackerData = {
    'water': 6,
    'steps': 8500,
    'sleep': 7.5,
    'mood': 4,
  };
  List<Map<String, dynamic>> _expenses = [];
  List<Achievement> _achievements = [];

  UserProfile? get userProfile => _userProfile;
  int get currentTabIndex => _currentTabIndex;
  List<DailyTask> get dailyTasks => _dailyTasks;
  Map<String, dynamic> get trackerData => _trackerData;
  List<Map<String, dynamic>> get expenses => _expenses;
  List<Achievement> get achievements => _achievements;

  void completeOnboarding(UserProfile profile) {
    _userProfile = profile;
    _initializeUserData();
    notifyListeners();
  }

  void setCurrentTab(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  void _initializeUserData() {
    // Initialize daily tasks
    _dailyTasks = [
      DailyTask(
        id: '1',
        title: 'Track your breakfast',
        type: 'health',
        completed: true,
        xpReward: 15,
      ),
      DailyTask(
        id: '2',
        title: 'Log daily expenses',
        type: 'wealth',
        completed: false,
        xpReward: 20,
      ),
      DailyTask(
        id: '3',
        title: 'Complete sleep quiz',
        type: 'health',
        completed: false,
        xpReward: 25,
      ),
    ];

    // Initialize sample expenses
    _expenses = [
      {'id': 1, 'category': 'Food', 'amount': 150, 'date': 'Today'},
      {'id': 2, 'category': 'Transport', 'amount': 80, 'date': 'Today'},
      {'id': 3, 'category': 'Entertainment', 'amount': 200, 'date': 'Yesterday'},
    ];

    // Initialize achievements
    _achievements = [
      Achievement(
        id: '1',
        title: 'First Steps',
        description: 'Complete your first lesson',
        icon: '👶',
        earned: true,
        earnedDate: DateTime(2024, 3, 15),
      ),
      Achievement(
        id: '2',
        title: 'Week Warrior',
        description: 'Maintain a 7-day streak',
        icon: '🔥',
        earned: true,
        earnedDate: DateTime(2024, 4, 2),
      ),
      Achievement(
        id: '3',
        title: 'Knowledge Seeker',
        description: 'Complete 25 lessons',
        icon: '📚',
        earned: true,
        earnedDate: DateTime(2024, 5, 10),
      ),
      Achievement(
        id: '4',
        title: 'Quiz Master',
        description: 'Score 100% on 10 quizzes',
        icon: '🧠',
        earned: true,
        earnedDate: DateTime(2024, 6, 15),
      ),
      Achievement(
        id: '5',
        title: 'Goal Getter',
        description: 'Complete your first monthly goal',
        icon: '🎯',
        earned: false,
      ),
      Achievement(
        id: '6',
        title: 'Consistency King',
        description: 'Maintain a 30-day streak',
        icon: '👑',
        earned: false,
      ),
    ];

    notifyListeners();
  }

  void completeTask(String taskId) {
    final taskIndex = _dailyTasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1 && !_dailyTasks[taskIndex].completed) {
      _dailyTasks[taskIndex] = _dailyTasks[taskIndex].copyWith(completed: true);
      
      // Add XP to user profile
      if (_userProfile != null) {
        _userProfile = _userProfile!.copyWith(
          xp: _userProfile!.xp + _dailyTasks[taskIndex].xpReward,
        );
      }
      
      notifyListeners();
    }
  }

  void updateTrackerData(String type, dynamic value) {
    _trackerData[type] = value;
    notifyListeners();
  }

  void addExpense(String category, double amount) {
    final newExpense = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'category': category,
      'amount': amount,
      'date': 'Today',
    };
    _expenses.insert(0, newExpense);
    notifyListeners();
  }

  void addXP(int points) {
    if (_userProfile != null) {
      final newXP = _userProfile!.xp + points;
      final newLevel = (newXP / 500).floor() + 1;
      
      _userProfile = _userProfile!.copyWith(
        xp: newXP,
        level: newLevel,
      );
      
      notifyListeners();
    }
  }

  void incrementStreak() {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(
        streak: _userProfile!.streak + 1,
      );
      notifyListeners();
    }
  }
}