// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonProgressImpl _$$LessonProgressImplFromJson(Map<String, dynamic> json) =>
    _$LessonProgressImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      moduleId: json['moduleId'] as String,
      category: json['category'] as String,
      completed: json['completed'] as bool,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      totalLessons: (json['totalLessons'] as num).toInt(),
      completedLessons: (json['completedLessons'] as num).toInt(),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$LessonProgressImplToJson(
        _$LessonProgressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'moduleId': instance.moduleId,
      'category': instance.category,
      'completed': instance.completed,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'totalLessons': instance.totalLessons,
      'completedLessons': instance.completedLessons,
      'progressPercentage': instance.progressPercentage,
    };

_$QuizResultImpl _$$QuizResultImplFromJson(Map<String, dynamic> json) =>
    _$QuizResultImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      moduleId: json['moduleId'] as String,
      category: json['category'] as String,
      score: (json['score'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => QuizAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      passed: json['passed'] as bool,
    );

Map<String, dynamic> _$$QuizResultImplToJson(_$QuizResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'moduleId': instance.moduleId,
      'category': instance.category,
      'score': instance.score,
      'totalQuestions': instance.totalQuestions,
      'percentage': instance.percentage,
      'completedAt': instance.completedAt.toIso8601String(),
      'answers': instance.answers,
      'passed': instance.passed,
    };

_$QuizAnswerImpl _$$QuizAnswerImplFromJson(Map<String, dynamic> json) =>
    _$QuizAnswerImpl(
      questionIndex: (json['questionIndex'] as num).toInt(),
      selectedAnswer: (json['selectedAnswer'] as num).toInt(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$QuizAnswerImplToJson(_$QuizAnswerImpl instance) =>
    <String, dynamic>{
      'questionIndex': instance.questionIndex,
      'selectedAnswer': instance.selectedAnswer,
      'correctAnswer': instance.correctAnswer,
      'isCorrect': instance.isCorrect,
      'question': instance.question,
      'options': instance.options,
      'explanation': instance.explanation,
    };

_$ModuleProgressImpl _$$ModuleProgressImplFromJson(Map<String, dynamic> json) =>
    _$ModuleProgressImpl(
      moduleId: json['moduleId'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      lessonCompleted: json['lessonCompleted'] as bool,
      quizCompleted: json['quizCompleted'] as bool,
      quizPassed: json['quizPassed'] as bool,
      overallProgress: (json['overallProgress'] as num).toDouble(),
      lessonCompletedAt: json['lessonCompletedAt'] == null
          ? null
          : DateTime.parse(json['lessonCompletedAt'] as String),
      quizCompletedAt: json['quizCompletedAt'] == null
          ? null
          : DateTime.parse(json['quizCompletedAt'] as String),
      bestQuizResult: json['bestQuizResult'] == null
          ? null
          : QuizResult.fromJson(json['bestQuizResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ModuleProgressImplToJson(
        _$ModuleProgressImpl instance) =>
    <String, dynamic>{
      'moduleId': instance.moduleId,
      'category': instance.category,
      'title': instance.title,
      'lessonCompleted': instance.lessonCompleted,
      'quizCompleted': instance.quizCompleted,
      'quizPassed': instance.quizPassed,
      'overallProgress': instance.overallProgress,
      'lessonCompletedAt': instance.lessonCompletedAt?.toIso8601String(),
      'quizCompletedAt': instance.quizCompletedAt?.toIso8601String(),
      'bestQuizResult': instance.bestQuizResult,
    };
