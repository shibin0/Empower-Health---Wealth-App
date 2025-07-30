import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

// Data models for adaptive learning
class LearningPath {
  final String id;
  final String title;
  final String description;
  final String category; // 'health' or 'wealth'
  final List<String> moduleIds;
  final int estimatedDuration; // in minutes
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final List<String> prerequisites;
  final Map<String, dynamic> adaptationRules;

  const LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.moduleIds,
    required this.estimatedDuration,
    required this.difficulty,
    required this.prerequisites,
    required this.adaptationRules,
  });
}

class LearningRecommendation {
  final String pathId;
  final String title;
  final String description;
  final String category;
  final double relevanceScore;
  final String reasoning;
  final int estimatedDuration;
  final String difficulty;
  final List<String> nextModules;
  final bool isPersonalized;

  const LearningRecommendation({
    required this.pathId,
    required this.title,
    required this.description,
    required this.category,
    required this.relevanceScore,
    required this.reasoning,
    required this.estimatedDuration,
    required this.difficulty,
    required this.nextModules,
    required this.isPersonalized,
  });
}

class UserLearningProgress {
  final String userId;
  final Map<String, double> moduleProgress; // moduleId -> progress (0.0 to 1.0)
  final Map<String, DateTime> completionDates;
  final Map<String, int> timeSpent; // moduleId -> minutes
  final Map<String, double> quizScores; // moduleId -> score (0.0 to 1.0)
  final List<String> preferredTopics;
  final String learningStyle; // 'visual', 'auditory', 'kinesthetic', 'reading'
  final int averageSessionDuration; // in minutes
  final List<String> strugglingAreas;
  final List<String> strongAreas;

  const UserLearningProgress({
    required this.userId,
    required this.moduleProgress,
    required this.completionDates,
    required this.timeSpent,
    required this.quizScores,
    required this.preferredTopics,
    required this.learningStyle,
    required this.averageSessionDuration,
    required this.strugglingAreas,
    required this.strongAreas,
  });
}

class AdaptiveLearningService {
  // Predefined learning paths
  static const List<LearningPath> _learningPaths = [
    // Health Learning Paths
    LearningPath(
      id: 'health_beginner',
      title: 'Health Fundamentals',
      description: 'Start your health journey with basic nutrition and fitness concepts',
      category: 'health',
      moduleIds: ['nutrition_basics', 'fitness_intro', 'sleep_hygiene'],
      estimatedDuration: 45,
      difficulty: 'beginner',
      prerequisites: [],
      adaptationRules: {
        'focus_areas': ['nutrition', 'fitness'],
        'learning_style_preference': 'visual',
        'session_length': 'short',
      },
    ),
    LearningPath(
      id: 'health_intermediate',
      title: 'Advanced Health Optimization',
      description: 'Dive deeper into advanced health strategies and mental wellness',
      category: 'health',
      moduleIds: ['advanced_nutrition', 'mental_health', 'fitness_advanced'],
      estimatedDuration: 60,
      difficulty: 'intermediate',
      prerequisites: ['nutrition_basics', 'fitness_intro'],
      adaptationRules: {
        'focus_areas': ['mental_health', 'advanced_fitness'],
        'learning_style_preference': 'reading',
        'session_length': 'medium',
      },
    ),
    LearningPath(
      id: 'health_holistic',
      title: 'Holistic Wellness Journey',
      description: 'Comprehensive approach to physical and mental well-being',
      category: 'health',
      moduleIds: ['nutrition_basics', 'fitness_intro', 'mental_health', 'sleep_hygiene'],
      estimatedDuration: 90,
      difficulty: 'intermediate',
      prerequisites: [],
      adaptationRules: {
        'focus_areas': ['holistic_health'],
        'learning_style_preference': 'mixed',
        'session_length': 'long',
      },
    ),

    // Wealth Learning Paths
    LearningPath(
      id: 'wealth_beginner',
      title: 'Financial Literacy Basics',
      description: 'Essential financial concepts for building wealth',
      category: 'wealth',
      moduleIds: ['budgeting_basics', 'saving_strategies', 'debt_management'],
      estimatedDuration: 50,
      difficulty: 'beginner',
      prerequisites: [],
      adaptationRules: {
        'focus_areas': ['budgeting', 'saving'],
        'learning_style_preference': 'visual',
        'session_length': 'short',
      },
    ),
    LearningPath(
      id: 'wealth_investment',
      title: 'Investment Mastery',
      description: 'Advanced investment strategies and portfolio management',
      category: 'wealth',
      moduleIds: ['investment_basics', 'portfolio_management', 'risk_assessment'],
      estimatedDuration: 75,
      difficulty: 'intermediate',
      prerequisites: ['budgeting_basics', 'saving_strategies'],
      adaptationRules: {
        'focus_areas': ['investing', 'portfolio'],
        'learning_style_preference': 'reading',
        'session_length': 'medium',
      },
    ),
    LearningPath(
      id: 'wealth_comprehensive',
      title: 'Complete Financial Freedom',
      description: 'End-to-end financial planning and wealth building',
      category: 'wealth',
      moduleIds: ['budgeting_basics', 'investment_basics', 'insurance_planning', 'credit_management'],
      estimatedDuration: 120,
      difficulty: 'advanced',
      prerequisites: [],
      adaptationRules: {
        'focus_areas': ['comprehensive_planning'],
        'learning_style_preference': 'mixed',
        'session_length': 'long',
      },
    ),

    // Specialized Paths
    LearningPath(
      id: 'quick_wins',
      title: 'Quick Health & Wealth Wins',
      description: 'Fast-track improvements you can implement today',
      category: 'mixed',
      moduleIds: ['nutrition_basics', 'budgeting_basics'],
      estimatedDuration: 30,
      difficulty: 'beginner',
      prerequisites: [],
      adaptationRules: {
        'focus_areas': ['quick_results'],
        'learning_style_preference': 'visual',
        'session_length': 'short',
      },
    ),
    LearningPath(
      id: 'stress_management',
      title: 'Stress & Financial Anxiety Relief',
      description: 'Manage stress while building financial confidence',
      category: 'mixed',
      moduleIds: ['mental_health', 'debt_management', 'sleep_hygiene'],
      estimatedDuration: 55,
      difficulty: 'intermediate',
      prerequisites: [],
      adaptationRules: {
        'focus_areas': ['stress_relief', 'anxiety_management'],
        'learning_style_preference': 'auditory',
        'session_length': 'medium',
      },
    ),
  ];

  // Mock user learning progress data
  static const Map<String, UserLearningProgress> _mockUserProgress = {
    'user1': UserLearningProgress(
      userId: 'user1',
      moduleProgress: {
        'nutrition_basics': 1.0,
        'fitness_intro': 0.8,
        'budgeting_basics': 0.6,
        'mental_health': 0.3,
      },
      completionDates: {},
      timeSpent: {
        'nutrition_basics': 25,
        'fitness_intro': 20,
        'budgeting_basics': 15,
        'mental_health': 10,
      },
      quizScores: {
        'nutrition_basics': 0.9,
        'fitness_intro': 0.75,
        'budgeting_basics': 0.8,
      },
      preferredTopics: ['nutrition', 'fitness', 'budgeting'],
      learningStyle: 'visual',
      averageSessionDuration: 20,
      strugglingAreas: ['mental_health'],
      strongAreas: ['nutrition', 'budgeting'],
    ),
  };

  // Get personalized learning recommendations
  static Future<List<LearningRecommendation>> getPersonalizedRecommendations(
    String userId,
    UserProfile? userProfile,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call

    final userProgress = _mockUserProgress[userId];
    final recommendations = <LearningRecommendation>[];

    for (final path in _learningPaths) {
      final relevanceScore = _calculateRelevanceScore(path, userProfile, userProgress);
      
      if (relevanceScore > 0.3) { // Only include relevant recommendations
        final reasoning = _generateReasoning(path, userProfile, userProgress);
        final nextModules = _getNextModules(path, userProgress);
        
        recommendations.add(LearningRecommendation(
          pathId: path.id,
          title: path.title,
          description: path.description,
          category: path.category,
          relevanceScore: relevanceScore,
          reasoning: reasoning,
          estimatedDuration: path.estimatedDuration,
          difficulty: path.difficulty,
          nextModules: nextModules,
          isPersonalized: relevanceScore > 0.7,
        ));
      }
    }

    // Sort by relevance score
    recommendations.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));
    
    return recommendations.take(6).toList(); // Return top 6 recommendations
  }

  // Get adaptive learning path for user
  static Future<LearningPath?> getAdaptivePath(
    String userId,
    String category,
    UserProfile? userProfile,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final userProgress = _mockUserProgress[userId];
    final categoryPaths = _learningPaths.where((p) => 
      p.category == category || p.category == 'mixed').toList();

    if (categoryPaths.isEmpty) return null;

    // Find the most suitable path based on user progress and preferences
    LearningPath? bestPath;
    double bestScore = 0.0;

    for (final path in categoryPaths) {
      final score = _calculateRelevanceScore(path, userProfile, userProgress);
      if (score > bestScore) {
        bestScore = score;
        bestPath = path;
      }
    }

    return bestPath;
  }

  // Get next recommended module for user
  static Future<String?> getNextRecommendedModule(
    String userId,
    String category,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final userProgress = _mockUserProgress[userId];
    if (userProgress == null) return null;

    // Find incomplete modules in the category
    final incompleteModules = <String>[];
    
    for (final path in _learningPaths) {
      if (path.category == category || path.category == 'mixed') {
        for (final moduleId in path.moduleIds) {
          final progress = userProgress.moduleProgress[moduleId] ?? 0.0;
          if (progress < 1.0 && !incompleteModules.contains(moduleId)) {
            incompleteModules.add(moduleId);
          }
        }
      }
    }

    if (incompleteModules.isEmpty) return null;

    // Prioritize based on prerequisites and user strengths
    for (final moduleId in incompleteModules) {
      if (_hasPrerequisites(moduleId, userProgress)) {
        return moduleId;
      }
    }

    return incompleteModules.first;
  }

  // Get learning analytics for user
  static Future<Map<String, dynamic>> getLearningAnalytics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final userProgress = _mockUserProgress[userId];
    if (userProgress == null) {
      return {
        'totalModulesStarted': 0,
        'totalModulesCompleted': 0,
        'averageQuizScore': 0.0,
        'totalTimeSpent': 0,
        'learningStreak': 0,
        'strongestCategory': 'none',
        'recommendedFocus': 'Start with basics',
        'completionRate': 0.0,
        'learningVelocity': 0.0,
      };
    }

    final totalStarted = userProgress.moduleProgress.length;
    final totalCompleted = userProgress.moduleProgress.values.where((p) => p >= 1.0).length;
    final averageScore = userProgress.quizScores.values.isNotEmpty
        ? userProgress.quizScores.values.reduce((a, b) => a + b) / userProgress.quizScores.length
        : 0.0;
    final totalTime = userProgress.timeSpent.values.reduce((a, b) => a + b);

    return {
      'totalModulesStarted': totalStarted,
      'totalModulesCompleted': totalCompleted,
      'averageQuizScore': averageScore,
      'totalTimeSpent': totalTime,
      'learningStreak': 7, // Mock streak
      'strongestCategory': userProgress.strongAreas.isNotEmpty ? userProgress.strongAreas.first : 'none',
      'recommendedFocus': _getRecommendedFocus(userProgress),
      'completionRate': totalStarted > 0 ? totalCompleted / totalStarted : 0.0,
      'learningVelocity': totalTime > 0 ? totalCompleted / (totalTime / 60) : 0.0, // modules per hour
    };
  }

  // Private helper methods
  static double _calculateRelevanceScore(
    LearningPath path,
    UserProfile? userProfile,
    UserLearningProgress? userProgress,
  ) {
    double score = 0.5; // Base score

    // Factor in user profile preferences
    if (userProfile != null) {
      // Check if user has preferences that match this path
      if (path.category == 'health') {
        score += 0.2; // Boost health paths
      } else if (path.category == 'wealth') {
        score += 0.2; // Boost wealth paths
      }
    }

    // Factor in user progress
    if (userProgress != null) {
      // Check if user has started modules in this path
      int startedModules = 0;
      int completedModules = 0;
      
      for (final moduleId in path.moduleIds) {
        final progress = userProgress.moduleProgress[moduleId] ?? 0.0;
        if (progress > 0.0) {
          startedModules++;
          if (progress >= 1.0) {
            completedModules++;
          }
        }
      }
// Boost paths with some progress but not completed
if (startedModules > 0 && completedModules < path.moduleIds.length) {
  score += 0.3;
}

// Penalize paths with no progress if user has been active elsewhere
if (startedModules == 0 && userProgress.moduleProgress.isNotEmpty) {
  score -= 0.1;
}
}

return score.clamp(0.0, 1.0);
}

static String _generateReasoning(
LearningPath path,
UserProfile? userProfile,
UserLearningProgress? userProgress,
) {
final reasons = <String>[];

if (userProgress != null) {
// Check for started modules in this path
final startedModules = path.moduleIds.where((id) =>
  (userProgress.moduleProgress[id] ?? 0.0) > 0.0).length;

if (startedModules > 0) {
  reasons.add('You\'ve already started $startedModules modules in this path');
}

// Check for strong areas
for (final strongArea in userProgress.strongAreas) {
  if (path.adaptationRules['focus_areas']?.contains(strongArea) == true) {
    reasons.add('Matches your strength in $strongArea');
  }
}

// Check for struggling areas
for (final strugglingArea in userProgress.strugglingAreas) {
  if (path.moduleIds.contains(strugglingArea)) {
    reasons.add('Helps improve your $strugglingArea skills');
  }
}
}

if (reasons.isEmpty) {
reasons.add('Recommended based on your learning profile');
}

return reasons.join(', ');
}

static List<String> _getNextModules(
LearningPath path,
UserLearningProgress? userProgress,
) {
if (userProgress == null) return path.moduleIds.take(3).toList();

final nextModules = <String>[];

for (final moduleId in path.moduleIds) {
final progress = userProgress.moduleProgress[moduleId] ?? 0.0;
if (progress < 1.0) {
  nextModules.add(moduleId);
  if (nextModules.length >= 3) break;
}
}

return nextModules;
}

static bool _hasPrerequisites(
String moduleId,
UserLearningProgress userProgress,
) {
// Find the path containing this module
for (final path in _learningPaths) {
if (path.moduleIds.contains(moduleId)) {
  // Check if prerequisites are met
  for (final prerequisite in path.prerequisites) {
    final progress = userProgress.moduleProgress[prerequisite] ?? 0.0;
    if (progress < 1.0) {
      return false;
    }
  }
  return true;
}
}
return true; // No prerequisites found
}

static String _getRecommendedFocus(UserLearningProgress userProgress) {
if (userProgress.strugglingAreas.isNotEmpty) {
return 'Focus on improving ${userProgress.strugglingAreas.first}';
}

if (userProgress.strongAreas.isNotEmpty) {
return 'Build on your ${userProgress.strongAreas.first} expertise';
}

return 'Continue with balanced learning approach';
}
}

// Riverpod providers for adaptive learning
final personalizedRecommendationsProvider = FutureProvider.family<List<LearningRecommendation>, String>((ref, userId) async {
  // For now, pass null for userProfile - can be enhanced later when userProfileProvider is available
  return AdaptiveLearningService.getPersonalizedRecommendations(userId, null);
});

final adaptiveLearningPathProvider = FutureProvider.family<LearningPath?, ({String userId, String category})>((ref, params) async {
  // For now, pass null for userProfile - can be enhanced later when userProfileProvider is available
  return AdaptiveLearningService.getAdaptivePath(params.userId, params.category, null);
});

final nextRecommendedModuleProvider = FutureProvider.family<String?, ({String userId, String category})>((ref, params) async {
  return AdaptiveLearningService.getNextRecommendedModule(params.userId, params.category);
});

final learningAnalyticsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  return AdaptiveLearningService.getLearningAnalytics(userId);
});
        