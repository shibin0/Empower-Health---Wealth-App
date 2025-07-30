import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/goal_progress_widgets.dart';
import '../utils/app_theme.dart';

class GoalTrackingService {
  static final GoalTrackingService _instance = GoalTrackingService._internal();
  factory GoalTrackingService() => _instance;
  GoalTrackingService._internal();

  // Mock goal data for demonstration
  List<GoalProgress> _mockGoals = [];

  Future<void> initializeMockData() async {
    _mockGoals = [
      // Health Goals
      GoalProgress(
        id: 'health_1',
        title: 'Complete Nutrition Course',
        description: 'Learn about healthy eating habits and meal planning',
        category: 'health',
        currentProgress: 0.75,
        targetValue: 10,
        currentValue: 7.5,
        unit: 'lessons',
        targetDate: DateTime.now().add(const Duration(days: 14)),
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        isCompleted: false,
        color: AppTheme.healthColor,
        icon: Icons.restaurant,
        milestones: [
          GoalMilestone(
            id: 'milestone_1',
            title: 'Complete First 3 Lessons',
            progressThreshold: 0.3,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 5)),
            reward: '+50 XP',
          ),
          GoalMilestone(
            id: 'milestone_2',
            title: 'Pass Nutrition Quiz',
            progressThreshold: 0.6,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 2)),
            reward: '+100 XP',
          ),
          GoalMilestone(
            id: 'milestone_3',
            title: 'Complete All Lessons',
            progressThreshold: 1.0,
            isCompleted: false,
            reward: 'Nutrition Expert Badge',
          ),
        ],
      ),
      GoalProgress(
        id: 'health_2',
        title: 'Daily Exercise Streak',
        description: 'Maintain a 30-day exercise routine',
        category: 'health',
        currentProgress: 0.6,
        targetValue: 30,
        currentValue: 18,
        unit: 'days',
        targetDate: DateTime.now().add(const Duration(days: 12)),
        createdAt: DateTime.now().subtract(const Duration(days: 18)),
        isCompleted: false,
        color: AppTheme.healthColor,
        icon: Icons.fitness_center,
        milestones: [
          GoalMilestone(
            id: 'milestone_4',
            title: '7-Day Streak',
            progressThreshold: 0.23,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 11)),
            reward: 'Consistency Badge',
          ),
          GoalMilestone(
            id: 'milestone_5',
            title: '14-Day Streak',
            progressThreshold: 0.47,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 4)),
            reward: '+150 XP',
          ),
          GoalMilestone(
            id: 'milestone_6',
            title: '30-Day Streak',
            progressThreshold: 1.0,
            isCompleted: false,
            reward: 'Fitness Master Badge',
          ),
        ],
      ),

      // Wealth Goals
      GoalProgress(
        id: 'wealth_1',
        title: 'Emergency Fund Goal',
        description: 'Build an emergency fund covering 6 months of expenses',
        category: 'wealth',
        currentProgress: 0.4,
        targetValue: 50000,
        currentValue: 20000,
        unit: '₹',
        targetDate: DateTime.now().add(const Duration(days: 180)),
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        isCompleted: false,
        color: AppTheme.wealthColor,
        icon: Icons.savings,
        milestones: [
          GoalMilestone(
            id: 'milestone_7',
            title: 'First ₹10,000',
            progressThreshold: 0.2,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 20)),
            reward: 'Saver Badge',
          ),
          GoalMilestone(
            id: 'milestone_8',
            title: 'Halfway Point',
            progressThreshold: 0.5,
            isCompleted: false,
            reward: '+200 XP',
          ),
          GoalMilestone(
            id: 'milestone_9',
            title: 'Emergency Fund Complete',
            progressThreshold: 1.0,
            isCompleted: false,
            reward: 'Financial Security Badge',
          ),
        ],
      ),
      GoalProgress(
        id: 'wealth_2',
        title: 'Investment Learning',
        description: 'Complete all investment courses and start investing',
        category: 'wealth',
        currentProgress: 0.85,
        targetValue: 8,
        currentValue: 6.8,
        unit: 'modules',
        targetDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now().subtract(const Duration(days: 21)),
        isCompleted: false,
        color: AppTheme.wealthColor,
        icon: Icons.trending_up,
        milestones: [
          GoalMilestone(
            id: 'milestone_10',
            title: 'Basic Investment Knowledge',
            progressThreshold: 0.5,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 10)),
            reward: 'Investor Badge',
          ),
          GoalMilestone(
            id: 'milestone_11',
            title: 'Advanced Strategies',
            progressThreshold: 0.8,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 3)),
            reward: '+250 XP',
          ),
          GoalMilestone(
            id: 'milestone_12',
            title: 'Investment Expert',
            progressThreshold: 1.0,
            isCompleted: false,
            reward: 'Investment Master Badge',
          ),
        ],
      ),

      // Completed Goal Example
      GoalProgress(
        id: 'health_3',
        title: 'Sleep Optimization',
        description: 'Improve sleep quality and maintain 8-hour sleep schedule',
        category: 'health',
        currentProgress: 1.0,
        targetValue: 21,
        currentValue: 21,
        unit: 'days',
        targetDate: DateTime.now().subtract(const Duration(days: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 23)),
        isCompleted: true,
        color: AppTheme.healthColor,
        icon: Icons.bedtime,
        milestones: [
          GoalMilestone(
            id: 'milestone_13',
            title: 'First Week',
            progressThreshold: 0.33,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 16)),
            reward: 'Sleep Tracker Badge',
          ),
          GoalMilestone(
            id: 'milestone_14',
            title: 'Two Weeks',
            progressThreshold: 0.67,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 9)),
            reward: '+150 XP',
          ),
          GoalMilestone(
            id: 'milestone_15',
            title: 'Sleep Master',
            progressThreshold: 1.0,
            isCompleted: true,
            completedAt: DateTime.now().subtract(const Duration(days: 2)),
            reward: 'Sleep Master Badge',
          ),
        ],
      ),
    ];
  }

  // Get all goals for a user
  Future<List<GoalProgress>> getUserGoals(String userId) async {
    if (_mockGoals.isEmpty) {
      await initializeMockData();
    }
    return List.from(_mockGoals);
  }

  // Get goals by category
  Future<List<GoalProgress>> getGoalsByCategory(
      String userId, String category) async {
    final allGoals = await getUserGoals(userId);
    return allGoals.where((goal) => goal.category == category).toList();
  }

  // Get active goals (not completed)
  Future<List<GoalProgress>> getActiveGoals(String userId) async {
    final allGoals = await getUserGoals(userId);
    return allGoals.where((goal) => !goal.isCompleted).toList();
  }

  // Get completed goals
  Future<List<GoalProgress>> getCompletedGoals(String userId) async {
    final allGoals = await getUserGoals(userId);
    return allGoals.where((goal) => goal.isCompleted).toList();
  }

  // Get goals due soon (within 7 days)
  Future<List<GoalProgress>> getGoalsDueSoon(String userId) async {
    final allGoals = await getUserGoals(userId);
    final now = DateTime.now();
    return allGoals
        .where((goal) =>
            !goal.isCompleted &&
            goal.targetDate.difference(now).inDays <= 7 &&
            goal.targetDate.isAfter(now))
        .toList();
  }

  // Get overdue goals
  Future<List<GoalProgress>> getOverdueGoals(String userId) async {
    final allGoals = await getUserGoals(userId);
    final now = DateTime.now();
    return allGoals
        .where((goal) => !goal.isCompleted && goal.targetDate.isBefore(now))
        .toList();
  }

  // Update goal progress
  Future<void> updateGoalProgress(String goalId, double newProgress) async {
    final goalIndex = _mockGoals.indexWhere((goal) => goal.id == goalId);
    if (goalIndex != -1) {
      final goal = _mockGoals[goalIndex];
      final newCurrentValue = goal.targetValue * newProgress;

      // Update milestones
      final updatedMilestones = goal.milestones.map((milestone) {
        if (!milestone.isCompleted &&
            newProgress >= milestone.progressThreshold) {
          return GoalMilestone(
            id: milestone.id,
            title: milestone.title,
            progressThreshold: milestone.progressThreshold,
            isCompleted: true,
            completedAt: DateTime.now(),
            reward: milestone.reward,
          );
        }
        return milestone;
      }).toList();

      _mockGoals[goalIndex] = GoalProgress(
        id: goal.id,
        title: goal.title,
        description: goal.description,
        category: goal.category,
        currentProgress: newProgress,
        targetValue: goal.targetValue,
        currentValue: newCurrentValue,
        unit: goal.unit,
        targetDate: goal.targetDate,
        createdAt: goal.createdAt,
        milestones: updatedMilestones,
        isCompleted: newProgress >= 1.0,
        color: goal.color,
        icon: goal.icon,
      );
    }
  }

  // Create new goal
  Future<void> createGoal(GoalProgress goal) async {
    _mockGoals.add(goal);
  }

  // Delete goal
  Future<void> deleteGoal(String goalId) async {
    _mockGoals.removeWhere((goal) => goal.id == goalId);
  }

  // Get goal statistics
  Future<Map<String, dynamic>> getGoalStatistics(String userId) async {
    final allGoals = await getUserGoals(userId);
    final healthGoals = allGoals.where((g) => g.category == 'health').toList();
    final wealthGoals = allGoals.where((g) => g.category == 'wealth').toList();
    final completedGoals = allGoals.where((g) => g.isCompleted).toList();
    final activeGoals = allGoals.where((g) => !g.isCompleted).toList();

    final totalProgress = allGoals.isEmpty
        ? 0.0
        : allGoals.map((g) => g.currentProgress).reduce((a, b) => a + b) /
            allGoals.length;

    final healthProgress = healthGoals.isEmpty
        ? 0.0
        : healthGoals.map((g) => g.currentProgress).reduce((a, b) => a + b) /
            healthGoals.length;

    final wealthProgress = wealthGoals.isEmpty
        ? 0.0
        : wealthGoals.map((g) => g.currentProgress).reduce((a, b) => a + b) /
            wealthGoals.length;

    return {
      'totalGoals': allGoals.length,
      'completedGoals': completedGoals.length,
      'activeGoals': activeGoals.length,
      'healthGoals': healthGoals.length,
      'wealthGoals': wealthGoals.length,
      'totalProgress': totalProgress,
      'healthProgress': healthProgress,
      'wealthProgress': wealthProgress,
      'completionRate':
          allGoals.isEmpty ? 0.0 : completedGoals.length / allGoals.length,
    };
  }

  // Get achievements based on goal completion
  List<GoalAchievementBadge> getGoalAchievements(List<GoalProgress> goals) {
    final achievements = <GoalAchievementBadge>[];
    final completedGoals = goals.where((g) => g.isCompleted).toList();
    final healthGoals = goals.where((g) => g.category == 'health').toList();
    final wealthGoals = goals.where((g) => g.category == 'wealth').toList();

    // First Goal Achievement
    if (completedGoals.isNotEmpty) {
      achievements.add(GoalAchievementBadge(
        title: 'Goal Achiever',
        description: 'Completed your first goal',
        icon: Icons.flag,
        color: AppTheme.successColor,
        isEarned: true,
        earnedDate: completedGoals.first.targetDate,
      ));
    }

    // Health Master
    final completedHealthGoals = healthGoals.where((g) => g.isCompleted).length;
    if (completedHealthGoals >= 3) {
      achievements.add(GoalAchievementBadge(
        title: 'Health Master',
        description: 'Completed 3 health goals',
        icon: Icons.favorite,
        color: AppTheme.healthColor,
        isEarned: true,
        earnedDate: DateTime.now().subtract(const Duration(days: 5)),
      ));
    }

    // Wealth Builder
    final completedWealthGoals = wealthGoals.where((g) => g.isCompleted).length;
    if (completedWealthGoals >= 2) {
      achievements.add(GoalAchievementBadge(
        title: 'Wealth Builder',
        description: 'Completed 2 wealth goals',
        icon: Icons.attach_money,
        color: AppTheme.wealthColor,
        isEarned: true,
        earnedDate: DateTime.now().subtract(const Duration(days: 10)),
      ));
    }

    // Consistency Champion
    final goalsWithMilestones =
        goals.where((g) => g.milestones.any((m) => m.isCompleted)).length;
    if (goalsWithMilestones >= 5) {
      achievements.add(GoalAchievementBadge(
        title: 'Consistency Champion',
        description: 'Reached milestones in 5 goals',
        icon: Icons.emoji_events,
        color: AppTheme.warningColor,
        isEarned: true,
        earnedDate: DateTime.now().subtract(const Duration(days: 3)),
      ));
    }

    // Overachiever
    if (completedGoals.length >= 5) {
      achievements.add(GoalAchievementBadge(
        title: 'Overachiever',
        description: 'Completed 5 goals',
        icon: Icons.star,
        color: AppTheme.primaryColor,
        isEarned: true,
        earnedDate: DateTime.now().subtract(const Duration(days: 1)),
      ));
    }

    // Add some unearned achievements for motivation
    if (completedGoals.length < 10) {
      achievements.add(const GoalAchievementBadge(
        title: 'Goal Master',
        description: 'Complete 10 goals',
        icon: Icons.workspace_premium,
        color: AppTheme.primaryColor,
        isEarned: false,
      ));
    }

    if (healthGoals.where((g) => g.isCompleted).length < 5) {
      achievements.add(const GoalAchievementBadge(
        title: 'Health Guru',
        description: 'Complete 5 health goals',
        icon: Icons.health_and_safety,
        color: AppTheme.healthColor,
        isEarned: false,
      ));
    }

    if (wealthGoals.where((g) => g.isCompleted).length < 5) {
      achievements.add(const GoalAchievementBadge(
        title: 'Financial Expert',
        description: 'Complete 5 wealth goals',
        icon: Icons.account_balance,
        color: AppTheme.wealthColor,
        isEarned: false,
      ));
    }

    return achievements;
  }
}

// Riverpod Providers
final goalTrackingServiceProvider = Provider<GoalTrackingService>((ref) {
  return GoalTrackingService();
});

final userGoalsProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getUserGoals(userId);
});

final activeGoalsProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getActiveGoals(userId);
});

final completedGoalsProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getCompletedGoals(userId);
});

final healthGoalsProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getGoalsByCategory(userId, 'health');
});

final wealthGoalsProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getGoalsByCategory(userId, 'wealth');
});

final goalsDueSoonProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getGoalsDueSoon(userId);
});

final overdueGoalsProvider =
    FutureProvider.family<List<GoalProgress>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getOverdueGoals(userId);
});

final goalStatisticsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  return await service.getGoalStatistics(userId);
});

final goalAchievementsProvider =
    FutureProvider.family<List<GoalAchievementBadge>, String>(
        (ref, userId) async {
  final service = ref.read(goalTrackingServiceProvider);
  final goals = await service.getUserGoals(userId);
  return service.getGoalAchievements(goals);
});
