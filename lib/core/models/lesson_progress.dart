import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_progress.freezed.dart';
part 'lesson_progress.g.dart';

@freezed
class LessonProgress with _$LessonProgress {
  const factory LessonProgress({
    required String id,
    required String userId,
    required String moduleId,
    required String category, // 'health' or 'wealth'
    required bool completed,
    required DateTime startedAt,
    DateTime? completedAt,
    required int totalLessons,
    required int completedLessons,
    required double progressPercentage,
  }) = _LessonProgress;

  factory LessonProgress.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressFromJson(json);
}

@freezed
class QuizResult with _$QuizResult {
  const factory QuizResult({
    required String id,
    required String userId,
    required String moduleId,
    required String category, // 'health' or 'wealth'
    required int score,
    required int totalQuestions,
    required double percentage,
    required DateTime completedAt,
    required List<QuizAnswer> answers,
    required bool passed, // true if percentage >= 60%
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}

@freezed
class QuizAnswer with _$QuizAnswer {
  const factory QuizAnswer({
    required int questionIndex,
    required int selectedAnswer,
    required int correctAnswer,
    required bool isCorrect,
    required String question,
    required List<String> options,
    required String explanation,
  }) = _QuizAnswer;

  factory QuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFromJson(json);
}

@freezed
class ModuleProgress with _$ModuleProgress {
  const factory ModuleProgress({
    required String moduleId,
    required String category,
    required String title,
    required bool lessonCompleted,
    required bool quizCompleted,
    required bool quizPassed,
    required double overallProgress, // 0.0 to 1.0
    DateTime? lessonCompletedAt,
    DateTime? quizCompletedAt,
    QuizResult? bestQuizResult,
  }) = _ModuleProgress;

  factory ModuleProgress.fromJson(Map<String, dynamic> json) =>
      _$ModuleProgressFromJson(json);
}