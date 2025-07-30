import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/simple_auth_wrapper.dart';
import '../utils/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/progress_card.dart';
import '../widgets/daily_tasks_card.dart';
import '../widgets/personalized_quick_actions_card.dart';
import '../widgets/achievements_card.dart';
import '../widgets/goal_progress_widgets.dart';
import '../services/goal_tracking_service.dart';
import '../services/adaptive_learning_service.dart';
import '../screens/goals_screen.dart';
import '../screens/adaptive_learning_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileSimpleProvider);

    if (userProfile == null) {
      return const Scaffold(
        body: Center(child: Text('No profile data available')),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacing4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                      Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                ),
                child: Column(
                  children: [
                    Text(
                      'Hey ${userProfile.name}! 👋',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacing1),
                    Text(
                      'Ready to level up today?',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing6),
              
              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.local_fire_department,
                      iconColor: AppTheme.warningColor,
                      label: 'Streak',
                      value: '${userProfile.streak}',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing3),
                  Expanded(
                    child: StatCard(
                      icon: Icons.star,
                      iconColor: AppTheme.warningColor,
                      label: 'Level',
                      value: '${userProfile.level}',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing3),
                  Expanded(
                    child: StatCard(
                      icon: Icons.emoji_events,
                      iconColor: AppTheme.purpleColor,
                      label: 'XP',
                      value: '${userProfile.xp}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing6),
              
              // Weekly Progress
              const ProgressCard(),
              const SizedBox(height: AppTheme.spacing6),
              
              // Today's Tasks
              const DailyTasksCard(),
              const SizedBox(height: AppTheme.spacing6),
              
              // Personalized Quick Actions
              const PersonalizedQuickActionsCard(),
              const SizedBox(height: AppTheme.spacing6),
              
              // Achievements
              const AchievementsCard(),
              const SizedBox(height: AppTheme.spacing6),
              
              // Goals Progress Section
              Consumer(
                builder: (context, ref, child) {
                  final goalsAsync = ref.watch(activeGoalsProvider(userProfile.id ?? 'default_user'));
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Goals',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GoalsScreen(),
                                ),
                              );
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing3),
                      goalsAsync.when(
                        data: (goals) {
                          final activeGoals = goals.take(3).toList();
                          
                          if (activeGoals.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppTheme.spacing4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.flag_outlined,
                                    size: 48,
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  const SizedBox(height: AppTheme.spacing2),
                                  Text(
                                    'No active goals yet',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: AppTheme.spacing1),
                                  Text(
                                    'Set your first goal to start tracking progress',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: AppTheme.spacing3),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const GoalsScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('Set Goals'),
                                  ),
                                ],
                              ),
                            );
                          }
                          
                          return GoalProgressGrid(goals: activeGoals);
                        },
                        loading: () => Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (error, stack) => Container(
                          padding: const EdgeInsets.all(AppTheme.spacing4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                          ),
                          child: Text(
                            'Error loading goals: $error',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacing6),
              
              // Adaptive Learning Recommendations
              Consumer(
                builder: (context, ref, child) {
                  final recommendationsAsync = ref.watch(personalizedRecommendationsProvider(userProfile.id ?? 'default_user'));
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: AppTheme.spacing2),
                              Text(
                                'AI Learning Recommendations',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdaptiveLearningScreen(),
                                ),
                              );
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing3),
                      recommendationsAsync.when(
                        data: (recommendations) {
                          if (recommendations.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppTheme.spacing4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    size: 48,
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  const SizedBox(height: AppTheme.spacing2),
                                  Text(
                                    'No recommendations yet',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: AppTheme.spacing1),
                                  Text(
                                    'Complete some lessons to get AI-powered recommendations',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          
                          final topRecommendations = recommendations.take(2).toList();
                          return Column(
                            children: topRecommendations.map((recommendation) =>
                              Container(
                                margin: const EdgeInsets.only(bottom: AppTheme.spacing3),
                                child: _buildRecommendationCard(context, recommendation),
                              ),
                            ).toList(),
                          );
                        },
                        loading: () => Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        error: (error, stack) => Container(
                          padding: const EdgeInsets.all(AppTheme.spacing4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                          ),
                          child: Text(
                            'Error loading recommendations: $error',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacing6),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildRecommendationCard(BuildContext context, LearningRecommendation recommendation) {
    Color getCategoryColor(String category) {
      switch (category.toLowerCase()) {
        case 'health':
          return AppTheme.healthColor;
        case 'wealth':
          return AppTheme.wealthColor;
        case 'mixed':
          return AppTheme.primaryColor;
        default:
          return AppTheme.primaryColor;
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getCategoryColor(recommendation.category).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    recommendation.category.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: getCategoryColor(recommendation.category),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Spacer(),
                if (recommendation.isPersonalized)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 14,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'AI',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing3),
            Text(
              recommendation.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing2),
            Text(
              recommendation.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppTheme.spacing3),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  '${recommendation.estimatedDuration} min',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(recommendation.relevanceScore * 100).toInt()}% match',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdaptiveLearningScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getCategoryColor(recommendation.category),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Start'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}