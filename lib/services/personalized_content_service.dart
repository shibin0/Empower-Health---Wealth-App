import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import 'behavior_tracking_service.dart';
import 'ai_service.dart';

// Content Models
class PersonalizedContent {
  final String id;
  final String type;
  final String title;
  final String description;
  final String category;
  final Map<String, dynamic> metadata;
  final double relevanceScore;
  final List<String> tags;
  final DateTime createdAt;
  final String? imageUrl;
  final String? actionUrl;

  const PersonalizedContent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
    required this.metadata,
    required this.relevanceScore,
    required this.tags,
    required this.createdAt,
    this.imageUrl,
    this.actionUrl,
  });

  factory PersonalizedContent.lesson({
    required String id,
    required String title,
    required String description,
    required String category,
    required double relevanceScore,
    required List<String> tags,
    String? imageUrl,
  }) {
    return PersonalizedContent(
      id: id,
      type: 'lesson',
      title: title,
      description: description,
      category: category,
      metadata: {'difficulty': 'beginner', 'duration': '5-10 min'},
      relevanceScore: relevanceScore,
      tags: tags,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      actionUrl: '/lesson/$id',
    );
  }

  factory PersonalizedContent.article({
    required String id,
    required String title,
    required String description,
    required String category,
    required double relevanceScore,
    required List<String> tags,
    String? imageUrl,
  }) {
    return PersonalizedContent(
      id: id,
      type: 'article',
      title: title,
      description: description,
      category: category,
      metadata: {'readTime': '3-5 min', 'source': 'expert'},
      relevanceScore: relevanceScore,
      tags: tags,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      actionUrl: '/article/$id',
    );
  }

  factory PersonalizedContent.tool({
    required String id,
    required String title,
    required String description,
    required String category,
    required double relevanceScore,
    required List<String> tags,
    String? imageUrl,
  }) {
    return PersonalizedContent(
      id: id,
      type: 'tool',
      title: title,
      description: description,
      category: category,
      metadata: {'interactive': true, 'complexity': 'simple'},
      relevanceScore: relevanceScore,
      tags: tags,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      actionUrl: '/calculator/$id',
    );
  }

  factory PersonalizedContent.challenge({
    required String id,
    required String title,
    required String description,
    required String category,
    required double relevanceScore,
    required List<String> tags,
    String? imageUrl,
  }) {
    return PersonalizedContent(
      id: id,
      type: 'challenge',
      title: title,
      description: description,
      category: category,
      metadata: {'duration': '7 days', 'difficulty': 'medium'},
      relevanceScore: relevanceScore,
      tags: tags,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      actionUrl: '/challenge/$id',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'category': category,
      'metadata': metadata,
      'relevanceScore': relevanceScore,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
      'actionUrl': actionUrl,
    };
  }

  factory PersonalizedContent.fromJson(Map<String, dynamic> json) {
    return PersonalizedContent(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      metadata: Map<String, dynamic>.from(json['metadata']),
      relevanceScore: (json['relevanceScore'] ?? 0.0).toDouble(),
      tags: List<String>.from(json['tags']),
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'],
      actionUrl: json['actionUrl'],
    );
  }
}

// Content Feed
class ContentFeed {
  final String userId;
  final List<PersonalizedContent> items;
  final DateTime lastUpdated;
  final Map<String, dynamic> feedMetadata;

  const ContentFeed({
    required this.userId,
    required this.items,
    required this.lastUpdated,
    required this.feedMetadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'feedMetadata': feedMetadata,
    };
  }

  factory ContentFeed.fromJson(Map<String, dynamic> json) {
    return ContentFeed(
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => PersonalizedContent.fromJson(item))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
      feedMetadata: Map<String, dynamic>.from(json['feedMetadata']),
    );
  }
}

// Learning Path
class LearningPath {
  final String id;
  final String title;
  final String description;
  final List<PersonalizedContent> content;
  final double completionPercentage;
  final int estimatedDuration;
  final String difficulty;
  final List<String> prerequisites;

  const LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.completionPercentage,
    required this.estimatedDuration,
    required this.difficulty,
    required this.prerequisites,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content.map((item) => item.toJson()).toList(),
      'completionPercentage': completionPercentage,
      'estimatedDuration': estimatedDuration,
      'difficulty': difficulty,
      'prerequisites': prerequisites,
    };
  }

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: (json['content'] as List)
          .map((item) => PersonalizedContent.fromJson(item))
          .toList(),
      completionPercentage: (json['completionPercentage'] ?? 0.0).toDouble(),
      estimatedDuration: json['estimatedDuration'] ?? 0,
      difficulty: json['difficulty'] ?? 'beginner',
      prerequisites: List<String>.from(json['prerequisites'] ?? []),
    );
  }
}

// Personalized Content Service
class PersonalizedContentService extends ChangeNotifier {
  static final PersonalizedContentService _instance = PersonalizedContentService._internal();
  factory PersonalizedContentService() => _instance;
  PersonalizedContentService._internal();

  final BehaviorTrackingService _behaviorService = BehaviorTrackingService();
  final AIService _aiService = AIService();

  ContentFeed? _currentFeed;
  List<LearningPath> _learningPaths = [];
  Map<String, List<PersonalizedContent>> _categoryContent = {};
  bool _isLoading = false;

  ContentFeed? get currentFeed => _currentFeed;
  List<LearningPath> get learningPaths => _learningPaths;
  Map<String, List<PersonalizedContent>> get categoryContent => _categoryContent;
  bool get isLoading => _isLoading;

  // Initialize personalized content for user
  Future<void> initializeContent(UserProfile userProfile) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Generate personalized feed
      await _generatePersonalizedFeed(userProfile);
      
      // Create learning paths
      await _generateLearningPaths(userProfile);
      
      // Organize content by categories
      _organizeContentByCategory();
      
    } catch (e) {
      debugPrint('Error initializing personalized content: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Generate personalized content feed
  Future<void> _generatePersonalizedFeed(UserProfile userProfile) async {
    final behaviorData = _behaviorService.exportBehaviorData();
    final userInsights = _behaviorService.getUserInsights();
    
    // Get AI-powered content recommendations
    final aiRecommendations = await _getAIContentRecommendations(
      userProfile, 
      behaviorData, 
      userInsights
    );
    
    // Combine with rule-based recommendations
    final ruleBasedContent = _getRuleBasedContent(userProfile, userInsights);
    
    // Merge and score content
    final allContent = [...aiRecommendations, ...ruleBasedContent];
    allContent.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));
    
    _currentFeed = ContentFeed(
      userId: userProfile.id ?? '',
      items: allContent.take(20).toList(),
      lastUpdated: DateTime.now(),
      feedMetadata: {
        'totalItems': allContent.length,
        'aiGenerated': aiRecommendations.length,
        'ruleBasedGenerated': ruleBasedContent.length,
        'userEngagementScore': userInsights['engagement_score'] ?? 0.0,
      },
    );
  }

  // Get AI-powered content recommendations
  Future<List<PersonalizedContent>> _getAIContentRecommendations(
    UserProfile userProfile,
    Map<String, dynamic> behaviorData,
    Map<String, dynamic> userInsights,
  ) async {
    try {
      // This would typically call the AI service for content recommendations
      // For now, return sample AI-generated content based on user data
      return _generateSampleAIContent(userProfile, userInsights);
    } catch (e) {
      debugPrint('Error getting AI content recommendations: $e');
      return [];
    }
  }

  // Generate sample AI content based on user profile
  List<PersonalizedContent> _generateSampleAIContent(
    UserProfile userProfile,
    Map<String, dynamic> userInsights,
  ) {
    final content = <PersonalizedContent>[];
    final engagementScore = userInsights['engagement_score'] ?? 0.0;
    
    // Health-focused content based on user goals
    if (userProfile.healthGoal.isNotEmpty) {
      content.addAll([
        PersonalizedContent.lesson(
          id: 'ai_health_1',
          title: 'Personalized ${userProfile.healthGoal} Plan',
          description: 'AI-generated plan tailored to your specific health goals and current progress.',
          category: 'health',
          relevanceScore: 0.95,
          tags: ['personalized', 'health', userProfile.healthGoal.toLowerCase()],
        ),
        PersonalizedContent.article(
          id: 'ai_health_2',
          title: 'Advanced Tips for ${userProfile.healthGoal}',
          description: 'Expert insights and advanced strategies based on your learning patterns.',
          category: 'health',
          relevanceScore: 0.88,
          tags: ['advanced', 'health', userProfile.healthGoal.toLowerCase()],
        ),
      ]);
    }

    // Wealth-focused content based on user goals
    if (userProfile.wealthGoal.isNotEmpty) {
      content.addAll([
        PersonalizedContent.lesson(
          id: 'ai_wealth_1',
          title: 'Smart ${userProfile.wealthGoal} Strategy',
          description: 'AI-optimized financial strategy based on your risk profile and goals.',
          category: 'wealth',
          relevanceScore: 0.92,
          tags: ['personalized', 'wealth', userProfile.wealthGoal.toLowerCase()],
        ),
        PersonalizedContent.tool(
          id: 'ai_wealth_2',
          title: 'Personalized Investment Calculator',
          description: 'Custom calculator tuned to your financial situation and goals.',
          category: 'wealth',
          relevanceScore: 0.85,
          tags: ['calculator', 'investment', 'personalized'],
        ),
      ]);
    }

    // Engagement-based content
    if (engagementScore < 50) {
      content.add(
        PersonalizedContent.challenge(
          id: 'ai_engagement_1',
          title: '7-Day Learning Boost Challenge',
          description: 'Specially designed to increase your engagement and learning momentum.',
          category: 'motivation',
          relevanceScore: 0.90,
          tags: ['challenge', 'engagement', 'motivation'],
        ),
      );
    }

    return content;
  }

  // Get rule-based content recommendations
  List<PersonalizedContent> _getRuleBasedContent(
    UserProfile userProfile,
    Map<String, dynamic> userInsights,
  ) {
    final content = <PersonalizedContent>[];
    final preferredCategories = userInsights['preferred_categories'] as List? ?? [];
    final mostUsedFeatures = userInsights['most_used_features'] as List? ?? [];

    // Content based on preferred categories
    for (final categoryData in preferredCategories) {
      final category = categoryData['category'] as String;
      content.addAll(_getContentForCategory(category));
    }

    // Content based on most used features
    for (final featureData in mostUsedFeatures) {
      final feature = featureData['feature'] as String;
      content.addAll(_getContentForFeature(feature));
    }

    // Content based on user experience level
    final experienceLevel = _calculateUserExperienceLevel(userProfile, userInsights);
    content.addAll(_getContentForExperienceLevel(experienceLevel));

    // Content based on time preferences
    final behaviorProfile = _behaviorService.behaviorProfile;
    if (behaviorProfile != null && behaviorProfile.preferredLearningTimes.isNotEmpty) {
      final preferredTime = behaviorProfile.preferredLearningTimes.first;
      content.addAll(_getContentForTimePreference(preferredTime));
    }

    return content;
  }

  // Get content for specific category
  List<PersonalizedContent> _getContentForCategory(String category) {
    switch (category) {
      case 'learning':
        return [
          PersonalizedContent.lesson(
            id: 'rule_learning_1',
            title: 'Advanced Learning Techniques',
            description: 'Master effective learning strategies for better retention.',
            category: 'education',
            relevanceScore: 0.80,
            tags: ['learning', 'techniques', 'advanced'],
          ),
        ];
      case 'tools':
        return [
          PersonalizedContent.tool(
            id: 'rule_tools_1',
            title: 'Financial Planning Toolkit',
            description: 'Comprehensive set of calculators for financial planning.',
            category: 'wealth',
            relevanceScore: 0.75,
            tags: ['tools', 'financial', 'planning'],
          ),
        ];
      default:
        return [];
    }
  }

  // Get content for specific feature
  List<PersonalizedContent> _getContentForFeature(String feature) {
    switch (feature) {
      case 'calculator':
        return [
          PersonalizedContent.tool(
            id: 'feature_calc_1',
            title: 'Advanced Calculator Suite',
            description: 'Enhanced calculators based on your usage patterns.',
            category: 'tools',
            relevanceScore: 0.82,
            tags: ['calculator', 'advanced', 'tools'],
          ),
        ];
      case 'lesson':
        return [
          PersonalizedContent.lesson(
            id: 'feature_lesson_1',
            title: 'Interactive Learning Module',
            description: 'Enhanced lessons with interactive elements.',
            category: 'education',
            relevanceScore: 0.78,
            tags: ['lesson', 'interactive', 'education'],
          ),
        ];
      default:
        return [];
    }
  }

  // Calculate user experience level
  String _calculateUserExperienceLevel(UserProfile userProfile, Map<String, dynamic> userInsights) {
    final engagementScore = userInsights['engagement_score'] ?? 0.0;
    final learningStreak = userInsights['learning_streak'] ?? 0;
    
    if (engagementScore > 70 && learningStreak > 5) {
      return 'advanced';
    } else if (engagementScore > 40 && learningStreak > 2) {
      return 'intermediate';
    } else {
      return 'beginner';
    }
  }

  // Get content for experience level
  List<PersonalizedContent> _getContentForExperienceLevel(String experienceLevel) {
    switch (experienceLevel) {
      case 'advanced':
        return [
          PersonalizedContent.lesson(
            id: 'exp_advanced_1',
            title: 'Master Class: Advanced Strategies',
            description: 'Expert-level content for experienced learners.',
            category: 'education',
            relevanceScore: 0.85,
            tags: ['advanced', 'expert', 'masterclass'],
          ),
        ];
      case 'intermediate':
        return [
          PersonalizedContent.lesson(
            id: 'exp_intermediate_1',
            title: 'Intermediate Skills Development',
            description: 'Build on your foundation with intermediate concepts.',
            category: 'education',
            relevanceScore: 0.80,
            tags: ['intermediate', 'skills', 'development'],
          ),
        ];
      case 'beginner':
        return [
          PersonalizedContent.lesson(
            id: 'exp_beginner_1',
            title: 'Foundation Building Basics',
            description: 'Essential concepts for new learners.',
            category: 'education',
            relevanceScore: 0.75,
            tags: ['beginner', 'foundation', 'basics'],
          ),
        ];
      default:
        return [];
    }
  }

  // Get content for time preference
  List<PersonalizedContent> _getContentForTimePreference(String timePreference) {
    switch (timePreference) {
      case 'morning':
        return [
          PersonalizedContent.article(
            id: 'time_morning_1',
            title: 'Morning Productivity Boost',
            description: 'Start your day with energizing content.',
            category: 'productivity',
            relevanceScore: 0.70,
            tags: ['morning', 'productivity', 'energy'],
          ),
        ];
      case 'evening':
        return [
          PersonalizedContent.article(
            id: 'time_evening_1',
            title: 'Evening Reflection & Planning',
            description: 'Wind down with thoughtful content.',
            category: 'wellness',
            relevanceScore: 0.70,
            tags: ['evening', 'reflection', 'planning'],
          ),
        ];
      default:
        return [];
    }
  }

  // Generate learning paths
  Future<void> _generateLearningPaths(UserProfile userProfile) async {
    _learningPaths = [
      // Health learning path
      LearningPath(
        id: 'health_path_1',
        title: 'Complete Health Journey',
        description: 'Comprehensive path covering all aspects of health and wellness.',
        content: [
          PersonalizedContent.lesson(
            id: 'health_lesson_1',
            title: 'Nutrition Fundamentals',
            description: 'Learn the basics of healthy eating.',
            category: 'health',
            relevanceScore: 0.90,
            tags: ['nutrition', 'health', 'fundamentals'],
          ),
          PersonalizedContent.lesson(
            id: 'health_lesson_2',
            title: 'Exercise Planning',
            description: 'Create an effective workout routine.',
            category: 'health',
            relevanceScore: 0.88,
            tags: ['exercise', 'fitness', 'planning'],
          ),
        ],
        completionPercentage: 0.0,
        estimatedDuration: 120, // minutes
        difficulty: 'beginner',
        prerequisites: [],
      ),
      
      // Wealth learning path
      LearningPath(
        id: 'wealth_path_1',
        title: 'Financial Mastery Path',
        description: 'Complete journey to financial independence.',
        content: [
          PersonalizedContent.lesson(
            id: 'wealth_lesson_1',
            title: 'Budgeting Basics',
            description: 'Master the art of budgeting.',
            category: 'wealth',
            relevanceScore: 0.92,
            tags: ['budgeting', 'finance', 'basics'],
          ),
          PersonalizedContent.lesson(
            id: 'wealth_lesson_2',
            title: 'Investment Strategies',
            description: 'Learn smart investment approaches.',
            category: 'wealth',
            relevanceScore: 0.90,
            tags: ['investment', 'strategy', 'finance'],
          ),
        ],
        completionPercentage: 0.0,
        estimatedDuration: 180, // minutes
        difficulty: 'intermediate',
        prerequisites: ['basic_finance'],
      ),
    ];
  }

  // Organize content by category
  void _organizeContentByCategory() {
    _categoryContent.clear();
    
    if (_currentFeed != null) {
      for (final content in _currentFeed!.items) {
        if (!_categoryContent.containsKey(content.category)) {
          _categoryContent[content.category] = [];
        }
        _categoryContent[content.category]!.add(content);
      }
    }
  }

  // Get content by category
  List<PersonalizedContent> getContentByCategory(String category) {
    return _categoryContent[category] ?? [];
  }

  // Get trending content
  List<PersonalizedContent> getTrendingContent() {
    if (_currentFeed == null) return [];
    
    return _currentFeed!.items
        .where((content) => content.relevanceScore > 0.8)
        .take(5)
        .toList();
  }

  // Get recommended learning path
  LearningPath? getRecommendedLearningPath(UserProfile userProfile) {
    if (_learningPaths.isEmpty) return null;
    
    // Simple recommendation based on user goals
    if (userProfile.healthGoal.isNotEmpty) {
      return _learningPaths.firstWhere(
        (path) => path.id.contains('health'),
        orElse: () => _learningPaths.first,
      );
    } else if (userProfile.wealthGoal.isNotEmpty) {
      return _learningPaths.firstWhere(
        (path) => path.id.contains('wealth'),
        orElse: () => _learningPaths.first,
      );
    }
    
    return _learningPaths.first;
  }

  // Update content engagement
  void updateContentEngagement(String contentId, String engagementType) {
    _behaviorService.trackEvent(
      AnalyticsEvent.featureUsed('content_engagement', {
        'content_id': contentId,
        'engagement_type': engagementType,
      }),
    );
  }

  // Refresh content feed
  Future<void> refreshContent(UserProfile userProfile) async {
    await _generatePersonalizedFeed(userProfile);
    await _generateLearningPaths(userProfile);
    _organizeContentByCategory();
    notifyListeners();
  }

  // Get content recommendations for specific context
  List<PersonalizedContent> getContextualRecommendations(String context) {
    if (_currentFeed == null) return [];
    
    switch (context) {
      case 'dashboard':
        return _currentFeed!.items.take(3).toList();
      case 'health_screen':
        return getContentByCategory('health').take(2).toList();
      case 'wealth_screen':
        return getContentByCategory('wealth').take(2).toList();
      default:
        return _currentFeed!.items.take(5).toList();
    }
  }

  // Export content data
  Map<String, dynamic> exportContentData() {
    return {
      'current_feed': _currentFeed?.toJson(),
      'learning_paths': _learningPaths.map((path) => path.toJson()).toList(),
      'category_content': _categoryContent.map(
        (key, value) => MapEntry(key, value.map((content) => content.toJson()).toList()),
      ),
    };
  }

  // Import content data
  void importContentData(Map<String, dynamic> data) {
    if (data['current_feed'] != null) {
      _currentFeed = ContentFeed.fromJson(data['current_feed']);
    }
    
    if (data['learning_paths'] != null) {
      _learningPaths = (data['learning_paths'] as List)
          .map((pathData) => LearningPath.fromJson(pathData))
          .toList();
    }
    
    if (data['category_content'] != null) {
      _categoryContent.clear();
      final categoryData = data['category_content'] as Map<String, dynamic>;
      for (final entry in categoryData.entries) {
        _categoryContent[entry.key] = (entry.value as List)
            .map((contentData) => PersonalizedContent.fromJson(contentData))
            .toList();
      }
    }
    
    notifyListeners();
  }
}