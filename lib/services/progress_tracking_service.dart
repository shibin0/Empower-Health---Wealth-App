import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/enhanced_storage_service.dart';
import '../core/models/achievement.dart';
import '../services/auth_service.dart';

// Simple progress tracking models without freezed
class LessonProgress {
  final String id;
  final String userId;
  final String moduleId;
  final String category;
  final bool completed;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int totalLessons;
  final int completedLessons;
  final double progressPercentage;

  LessonProgress({
    required this.id,
    required this.userId,
    required this.moduleId,
    required this.category,
    required this.completed,
    required this.startedAt,
    this.completedAt,
    required this.totalLessons,
    required this.completedLessons,
    required this.progressPercentage,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'moduleId': moduleId,
    'category': category,
    'completed': completed,
    'startedAt': startedAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'totalLessons': totalLessons,
    'completedLessons': completedLessons,
    'progressPercentage': progressPercentage,
  };

  factory LessonProgress.fromJson(Map<String, dynamic> json) => LessonProgress(
    id: json['id'],
    userId: json['userId'],
    moduleId: json['moduleId'],
    category: json['category'],
    completed: json['completed'],
    startedAt: DateTime.parse(json['startedAt']),
    completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    totalLessons: json['totalLessons'],
    completedLessons: json['completedLessons'],
    progressPercentage: json['progressPercentage'].toDouble(),
  );
}

class QuizResult {
  final String id;
  final String userId;
  final String moduleId;
  final String category;
  final int score;
  final int totalQuestions;
  final double percentage;
  final DateTime completedAt;
  final bool passed;

  QuizResult({
    required this.id,
    required this.userId,
    required this.moduleId,
    required this.category,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.completedAt,
    required this.passed,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'moduleId': moduleId,
    'category': category,
    'score': score,
    'totalQuestions': totalQuestions,
    'percentage': percentage,
    'completedAt': completedAt.toIso8601String(),
    'passed': passed,
  };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
    id: json['id'],
    userId: json['userId'],
    moduleId: json['moduleId'],
    category: json['category'],
    score: json['score'],
    totalQuestions: json['totalQuestions'],
    percentage: json['percentage'].toDouble(),
    completedAt: DateTime.parse(json['completedAt']),
    passed: json['passed'],
  );
}

class ModuleProgress {
  final String moduleId;
  final String category;
  final String title;
  final bool lessonCompleted;
  final bool quizCompleted;
  final bool quizPassed;
  final double overallProgress;
  final DateTime? lessonCompletedAt;
  final DateTime? quizCompletedAt;
  final QuizResult? bestQuizResult;

  ModuleProgress({
    required this.moduleId,
    required this.category,
    required this.title,
    required this.lessonCompleted,
    required this.quizCompleted,
    required this.quizPassed,
    required this.overallProgress,
    this.lessonCompletedAt,
    this.quizCompletedAt,
    this.bestQuizResult,
  });

  Map<String, dynamic> toJson() => {
    'moduleId': moduleId,
    'category': category,
    'title': title,
    'lessonCompleted': lessonCompleted,
    'quizCompleted': quizCompleted,
    'quizPassed': quizPassed,
    'overallProgress': overallProgress,
    'lessonCompletedAt': lessonCompletedAt?.toIso8601String(),
    'quizCompletedAt': quizCompletedAt?.toIso8601String(),
    'bestQuizResult': bestQuizResult?.toJson(),
  };

  factory ModuleProgress.fromJson(Map<String, dynamic> json) => ModuleProgress(
    moduleId: json['moduleId'],
    category: json['category'],
    title: json['title'],
    lessonCompleted: json['lessonCompleted'],
    quizCompleted: json['quizCompleted'],
    quizPassed: json['quizPassed'],
    overallProgress: json['overallProgress'].toDouble(),
    lessonCompletedAt: json['lessonCompletedAt'] != null ? DateTime.parse(json['lessonCompletedAt']) : null,
    quizCompletedAt: json['quizCompletedAt'] != null ? DateTime.parse(json['quizCompletedAt']) : null,
    bestQuizResult: json['bestQuizResult'] != null ? QuizResult.fromJson(json['bestQuizResult']) : null,
  );
}

class ProgressTrackingService {
  static final ProgressTrackingService _instance = ProgressTrackingService._internal();
  factory ProgressTrackingService() => _instance;
  ProgressTrackingService._internal();

  // Module mapping
  static const Map<String, String> moduleMapping = {
    'nutrition': 'Nutrition Basics',
    'fitness': 'Home Workouts',
    'sleep': 'Sleep & Recovery',
    'mental': 'Mental Wellness',
    'budgeting': 'Smart Budgeting',
    'investing': 'Investment Basics',
    'credit': 'Credit & Loans',
    'insurance': 'Insurance Planning',
  };

  // Get lesson count for each module
  static const Map<String, int> moduleLessonCounts = {
    'nutrition': 3,
    'fitness': 2,
    'sleep': 4,
    'mental': 4,
    'budgeting': 2,
    'investing': 2,
    'credit': 4,
    'insurance': 4,
  };

  // Start lesson tracking
  Future<void> startLesson(String userId, String moduleId, String category) async {
    final storage = EnhancedStorageService();
    final progressList = await _loadLessonProgress(storage);
    
    // Check if already exists
    final existingIndex = progressList.indexWhere((p) => p.moduleId == moduleId && p.userId == userId);
    
    if (existingIndex == -1) {
      // Create new progress entry
      final progress = LessonProgress(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        moduleId: moduleId,
        category: category,
        completed: false,
        startedAt: DateTime.now(),
        totalLessons: moduleLessonCounts[moduleId] ?? 1,
        completedLessons: 0,
        progressPercentage: 0.0,
      );
      
      progressList.add(progress);
      await _saveLessonProgress(storage, progressList);
    }
  }

  // Complete lesson
  Future<void> completeLesson(String userId, String moduleId, String category) async {
    final storage = EnhancedStorageService();
    final progressList = await _loadLessonProgress(storage);
    
    final existingIndex = progressList.indexWhere((p) => p.moduleId == moduleId && p.userId == userId);
    
    if (existingIndex != -1) {
      final existing = progressList[existingIndex];
      final totalLessons = moduleLessonCounts[moduleId] ?? 1;
      
      final updatedProgress = LessonProgress(
        id: existing.id,
        userId: existing.userId,
        moduleId: existing.moduleId,
        category: existing.category,
        completed: true,
        startedAt: existing.startedAt,
        completedAt: DateTime.now(),
        totalLessons: totalLessons,
        completedLessons: totalLessons,
        progressPercentage: 100.0,
      );
      
      progressList[existingIndex] = updatedProgress;
      await _saveLessonProgress(storage, progressList);
    }
  }

  // Save quiz result
  Future<void> saveQuizResult(String userId, String moduleId, String category, int score, int totalQuestions) async {
    final storage = EnhancedStorageService();
    final percentage = (score / totalQuestions) * 100;
    final passed = percentage >= 60;
    
    final quizResult = QuizResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      moduleId: moduleId,
      category: category,
      score: score,
      totalQuestions: totalQuestions,
      percentage: percentage,
      completedAt: DateTime.now(),
      passed: passed,
    );
    
    final quizResults = await _loadQuizResults(storage);
    quizResults.add(quizResult);
    await _saveQuizResults(storage, quizResults);
    
    // Check for achievements
    await _checkAndAwardAchievements(userId, moduleId, category, percentage, storage);
  }

  // Get module progress
  Future<List<ModuleProgress>> getModuleProgress(String userId) async {
    final storage = EnhancedStorageService();
    final lessonProgress = await _loadLessonProgress(storage);
    final quizResults = await _loadQuizResults(storage);
    
    final List<ModuleProgress> moduleProgressList = [];
    
    for (final moduleId in moduleMapping.keys) {
      final category = _getCategoryForModule(moduleId);
      final title = moduleMapping[moduleId]!;
      
      final lessonProg = lessonProgress.where((p) => p.moduleId == moduleId && p.userId == userId).firstOrNull;
      final moduleQuizResults = quizResults.where((q) => q.moduleId == moduleId && q.userId == userId).toList();
      
      final lessonCompleted = lessonProg?.completed ?? false;
      final quizCompleted = moduleQuizResults.isNotEmpty;
      final bestQuiz = moduleQuizResults.isNotEmpty 
          ? moduleQuizResults.reduce((a, b) => a.percentage > b.percentage ? a : b)
          : null;
      final quizPassed = bestQuiz?.passed ?? false;
      
      double overallProgress = 0.0;
      if (lessonCompleted) overallProgress += 0.5;
      if (quizCompleted) overallProgress += 0.5;
      
      moduleProgressList.add(ModuleProgress(
        moduleId: moduleId,
        category: category,
        title: title,
        lessonCompleted: lessonCompleted,
        quizCompleted: quizCompleted,
        quizPassed: quizPassed,
        overallProgress: overallProgress,
        lessonCompletedAt: lessonProg?.completedAt,
        quizCompletedAt: bestQuiz?.completedAt,
        bestQuizResult: bestQuiz,
      ));
    }
    
    return moduleProgressList;
  }

  // Get overall progress stats
  Future<Map<String, dynamic>> getOverallStats(String userId) async {
    final moduleProgress = await getModuleProgress(userId);
    
    final healthModules = moduleProgress.where((m) => m.category == 'health').toList();
    final wealthModules = moduleProgress.where((m) => m.category == 'wealth').toList();
    
    final totalModules = moduleProgress.length;
    final completedLessons = moduleProgress.where((m) => m.lessonCompleted).length;
    final completedQuizzes = moduleProgress.where((m) => m.quizCompleted).length;
    final passedQuizzes = moduleProgress.where((m) => m.quizPassed).length;
    
    final healthProgress = healthModules.isEmpty ? 0.0 : 
        healthModules.map((m) => m.overallProgress).reduce((a, b) => a + b) / healthModules.length;
    final wealthProgress = wealthModules.isEmpty ? 0.0 : 
        wealthModules.map((m) => m.overallProgress).reduce((a, b) => a + b) / wealthModules.length;
    
    return {
      'totalModules': totalModules,
      'completedLessons': completedLessons,
      'completedQuizzes': completedQuizzes,
      'passedQuizzes': passedQuizzes,
      'healthProgress': healthProgress,
      'wealthProgress': wealthProgress,
      'overallProgress': (healthProgress + wealthProgress) / 2,
      'lessonCompletionRate': completedLessons / totalModules,
      'quizCompletionRate': completedQuizzes / totalModules,
      'quizPassRate': completedQuizzes > 0 ? passedQuizzes / completedQuizzes : 0.0,
    };
  }

  // Private helper methods
  Future<List<LessonProgress>> _loadLessonProgress(EnhancedStorageService storage) async {
    try {
      final data = storage.getCachedData('lesson_progress');
      if (data != null && data['progress'] != null) {
        final List<dynamic> progressJson = data['progress'];
        return progressJson.map((json) => LessonProgress.fromJson(Map<String, dynamic>.from(json))).toList();
      }
    } catch (e) {
      print('Error loading lesson progress: $e');
    }
    return [];
  }

  Future<void> _saveLessonProgress(EnhancedStorageService storage, List<LessonProgress> progressList) async {
    try {
      final progressJson = progressList.map((p) => p.toJson()).toList();
      await storage.cacheData('lesson_progress', {'progress': progressJson});
    } catch (e) {
      print('Error saving lesson progress: $e');
    }
  }

  Future<List<QuizResult>> _loadQuizResults(EnhancedStorageService storage) async {
    try {
      final data = storage.getCachedData('quiz_results');
      if (data != null && data['results'] != null) {
        final List<dynamic> resultsJson = data['results'];
        return resultsJson.map((json) => QuizResult.fromJson(Map<String, dynamic>.from(json))).toList();
      }
    } catch (e) {
      print('Error loading quiz results: $e');
    }
    return [];
  }

  Future<void> _saveQuizResults(EnhancedStorageService storage, List<QuizResult> results) async {
    try {
      final resultsJson = results.map((r) => r.toJson()).toList();
      await storage.cacheData('quiz_results', {'results': resultsJson});
    } catch (e) {
      print('Error saving quiz results: $e');
    }
  }

  String _getCategoryForModule(String moduleId) {
    const healthModules = ['nutrition', 'fitness', 'sleep', 'mental'];
    const wealthModules = ['budgeting', 'investing', 'credit', 'insurance'];
    
    if (healthModules.contains(moduleId)) return 'health';
    if (wealthModules.contains(moduleId)) return 'wealth';
    return 'unknown';
  }

  Future<void> _checkAndAwardAchievements(String userId, String moduleId, String category, double percentage, EnhancedStorageService storage) async {
    try {
      final achievements = storage.loadAchievements();
      final newAchievements = <Achievement>[];
      
      // First quiz completion achievement
      if (!achievements.any((a) => a.id == 'first_quiz_$category' && a.earned)) {
        newAchievements.add(Achievement(
          id: 'first_quiz_$category',
          title: 'First ${category.toUpperCase()} Quiz',
          description: 'Completed your first $category quiz',
          icon: category == 'health' ? '🏥' : '💰',
          earned: true,
          earnedDate: DateTime.now(),
          xpReward: 50,
        ));
      }
      
      // Perfect score achievement
      if (percentage == 100 && !achievements.any((a) => a.id == 'perfect_score_$moduleId' && a.earned)) {
        newAchievements.add(Achievement(
          id: 'perfect_score_$moduleId',
          title: 'Perfect Score',
          description: 'Got 100% on ${moduleMapping[moduleId]} quiz',
          icon: '🎯',
          earned: true,
          earnedDate: DateTime.now(),
          xpReward: 100,
        ));
      }
      
      // High achiever (80%+)
      if (percentage >= 80 && !achievements.any((a) => a.id == 'high_achiever_$moduleId' && a.earned)) {
        newAchievements.add(Achievement(
          id: 'high_achiever_$moduleId',
          title: 'High Achiever',
          description: 'Scored 80% or higher on ${moduleMapping[moduleId]} quiz',
          icon: '⭐',
          earned: true,
          earnedDate: DateTime.now(),
          xpReward: 75,
        ));
      }
      
      // Check for category completion
      final moduleProgress = await getModuleProgress(userId);
      final categoryModules = moduleProgress.where((m) => m.category == category).toList();
      final completedModules = categoryModules.where((m) => m.quizPassed).length;
      
      if (completedModules >= categoryModules.length && !achievements.any((a) => a.id == 'category_master_$category' && a.earned)) {
        newAchievements.add(Achievement(
          id: 'category_master_$category',
          title: '${category.toUpperCase()} Master',
          description: 'Completed all $category modules with passing grades',
          icon: category == 'health' ? '🏆' : '💎',
          earned: true,
          earnedDate: DateTime.now(),
          xpReward: 200,
        ));
      }
      
      // Save new achievements
      if (newAchievements.isNotEmpty) {
        final allAchievements = [...achievements, ...newAchievements];
        await storage.saveAchievements(allAchievements);
      }
    } catch (e) {
      print('Error checking achievements: $e');
    }
  }
}

// Provider for progress tracking service
final progressTrackingServiceProvider = Provider<ProgressTrackingService>((ref) {
  return ProgressTrackingService();
});

// Provider for module progress
final moduleProgressProvider = FutureProvider.family<List<ModuleProgress>, String>((ref, userId) async {
  final service = ref.read(progressTrackingServiceProvider);
  return await service.getModuleProgress(userId);
});

// Provider for overall stats
final overallStatsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  final service = ref.read(progressTrackingServiceProvider);
  return await service.getOverallStats(userId);
});