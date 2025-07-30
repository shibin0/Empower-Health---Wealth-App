import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/user_profile.dart';

// AI Data Models
class AIRecommendation {
  final String id;
  final String title;
  final String description;
  final String category;
  final int priority;
  final List<String> actionItems;
  final DateTime createdAt;

  const AIRecommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.actionItems,
    required this.createdAt,
  });

  factory AIRecommendation.fromJson(Map<String, dynamic> json) {
    return AIRecommendation(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      priority: json['priority'] ?? 1,
      actionItems: List<String>.from(json['actionItems'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'actionItems': actionItems,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class HealthRecommendations {
  final List<AIRecommendation> recommendations;
  final String summary;
  final double healthScore;
  final List<String> keyInsights;
  final DateTime generatedAt;

  const HealthRecommendations({
    required this.recommendations,
    required this.summary,
    required this.healthScore,
    required this.keyInsights,
    required this.generatedAt,
  });

  factory HealthRecommendations.fromJson(Map<String, dynamic> json) {
    return HealthRecommendations(
      recommendations: (json['recommendations'] as List?)
          ?.map((e) => AIRecommendation.fromJson(e))
          .toList() ?? [],
      summary: json['summary'] ?? '',
      healthScore: (json['healthScore'] ?? 0.0).toDouble(),
      keyInsights: List<String>.from(json['keyInsights'] ?? []),
      generatedAt: DateTime.parse(json['generatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class WealthRecommendations {
  final List<AIRecommendation> recommendations;
  final String summary;
  final double wealthScore;
  final List<String> keyInsights;
  final Map<String, double> portfolioAnalysis;
  final DateTime generatedAt;

  const WealthRecommendations({
    required this.recommendations,
    required this.summary,
    required this.wealthScore,
    required this.keyInsights,
    required this.portfolioAnalysis,
    required this.generatedAt,
  });

  factory WealthRecommendations.fromJson(Map<String, dynamic> json) {
    return WealthRecommendations(
      recommendations: (json['recommendations'] as List?)
          ?.map((e) => AIRecommendation.fromJson(e))
          .toList() ?? [],
      summary: json['summary'] ?? '',
      wealthScore: (json['wealthScore'] ?? 0.0).toDouble(),
      keyInsights: List<String>.from(json['keyInsights'] ?? []),
      portfolioAnalysis: Map<String, double>.from(json['portfolioAnalysis'] ?? {}),
      generatedAt: DateTime.parse(json['generatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class PersonalizedInsights {
  final List<AIRecommendation> dailyTasks;
  final List<AIRecommendation> weeklyGoals;
  final List<AIRecommendation> learningModules;
  final String motivationalMessage;
  final double progressScore;
  final DateTime generatedAt;

  const PersonalizedInsights({
    required this.dailyTasks,
    required this.weeklyGoals,
    required this.learningModules,
    required this.motivationalMessage,
    required this.progressScore,
    required this.generatedAt,
  });

  factory PersonalizedInsights.fromJson(Map<String, dynamic> json) {
    return PersonalizedInsights(
      dailyTasks: (json['dailyTasks'] as List?)
          ?.map((e) => AIRecommendation.fromJson(e))
          .toList() ?? [],
      weeklyGoals: (json['weeklyGoals'] as List?)
          ?.map((e) => AIRecommendation.fromJson(e))
          .toList() ?? [],
      learningModules: (json['learningModules'] as List?)
          ?.map((e) => AIRecommendation.fromJson(e))
          .toList() ?? [],
      motivationalMessage: json['motivationalMessage'] ?? '',
      progressScore: (json['progressScore'] ?? 0.0).toDouble(),
      generatedAt: DateTime.parse(json['generatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

// AI Service Implementation
class AIService {
  static const String _baseUrl = 'https://api.openai.com/v1'; // Replace with your org's endpoint
  static const String _apiKey = 'YOUR_API_KEY_HERE'; // Replace with your org's API key
  
  final http.Client _client = http.Client();

  // System prompts for different AI functions
  static const String _healthSystemPrompt = '''
You are an expert health and wellness coach with deep knowledge in nutrition, fitness, mental health, and preventive medicine. 
Your role is to analyze user health data and provide personalized, actionable recommendations that are:
1. Evidence-based and scientifically sound
2. Tailored to the user's specific goals, preferences, and current health status
3. Practical and achievable for busy lifestyles
4. Focused on sustainable long-term health improvements
5. Culturally sensitive and inclusive

Always provide specific, measurable action items and explain the reasoning behind your recommendations.
Format your response as JSON with the following structure:
{
  "recommendations": [
    {
      "id": "unique_id",
      "title": "Recommendation Title",
      "description": "Detailed description",
      "category": "nutrition|fitness|mental_health|sleep|preventive_care",
      "priority": 1-5,
      "actionItems": ["specific action 1", "specific action 2"],
      "createdAt": "ISO_DATE"
    }
  ],
  "summary": "Overall health assessment summary",
  "healthScore": 0-100,
  "keyInsights": ["insight 1", "insight 2", "insight 3"],
  "generatedAt": "ISO_DATE"
}
''';

  static const String _wealthSystemPrompt = '''
You are a certified financial advisor and wealth management expert with expertise in:
1. Personal finance planning and budgeting
2. Investment strategies and portfolio management
3. Risk assessment and insurance planning
4. Tax optimization and retirement planning
5. Behavioral finance and financial psychology

Your role is to analyze user financial data and provide personalized recommendations that are:
1. Aligned with their financial goals and risk tolerance
2. Appropriate for their age, income, and life stage
3. Diversified and evidence-based
4. Tax-efficient and cost-conscious
5. Focused on long-term wealth building

Always consider the Indian financial market context and regulations.
Format your response as JSON with the following structure:
{
  "recommendations": [
    {
      "id": "unique_id",
      "title": "Recommendation Title",
      "description": "Detailed description",
      "category": "investment|budgeting|insurance|tax_planning|retirement",
      "priority": 1-5,
      "actionItems": ["specific action 1", "specific action 2"],
      "createdAt": "ISO_DATE"
    }
  ],
  "summary": "Overall financial health assessment",
  "wealthScore": 0-100,
  "keyInsights": ["insight 1", "insight 2", "insight 3"],
  "portfolioAnalysis": {
    "diversification_score": 0-100,
    "risk_level": 0-100,
    "expected_returns": 0-30
  },
  "generatedAt": "ISO_DATE"
}
''';

  static const String _personalizationSystemPrompt = '''
You are a personalization expert specializing in behavioral psychology and habit formation.
Your role is to create personalized daily tasks, weekly goals, and learning recommendations based on:
1. User behavior patterns and preferences
2. Current progress and achievement history
3. Motivational psychology principles
4. Cognitive load and time management
5. Sustainable habit formation strategies

Focus on creating achievable, progressive tasks that build momentum and maintain engagement.
Format your response as JSON with the following structure:
{
  "dailyTasks": [
    {
      "id": "unique_id",
      "title": "Task Title",
      "description": "Detailed description",
      "category": "health|wealth|learning|mindfulness",
      "priority": 1-5,
      "actionItems": ["specific action 1", "specific action 2"],
      "createdAt": "ISO_DATE"
    }
  ],
  "weeklyGoals": [...],
  "learningModules": [...],
  "motivationalMessage": "Personalized motivational message",
  "progressScore": 0-100,
  "generatedAt": "ISO_DATE"
}
''';

  Future<Map<String, dynamic>> _makeAIRequest({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2000,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4', // or your org's preferred model
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': userPrompt},
          ],
          'temperature': temperature,
          'max_tokens': maxTokens,
          'response_format': {'type': 'json_object'},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        return jsonDecode(content);
      } else {
        throw Exception('AI API request failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('AI service error: $e');
    }
  }

  Future<HealthRecommendations> generateHealthRecommendations({
    required UserProfile userProfile,
    required Map<String, dynamic> healthData,
  }) async {
    final userPrompt = '''
User Profile:
- Age: ${userProfile.age}
- Primary Goals: ${userProfile.primaryGoals.join(', ')}
- Health Goal: ${userProfile.healthGoal}
- Current Level: ${userProfile.currentLevel}
- XP: ${userProfile.xp}
- Level: ${userProfile.level}
- Streak: ${userProfile.streak}

Current Health Data:
${jsonEncode(healthData)}

Please analyze this user's health profile and current data to provide personalized health recommendations.
Focus on actionable steps they can take to improve their health and achieve their goals.
''';

    final response = await _makeAIRequest(
      systemPrompt: _healthSystemPrompt,
      userPrompt: userPrompt,
    );

    return HealthRecommendations.fromJson(response);
  }

  Future<WealthRecommendations> generateWealthRecommendations({
    required UserProfile userProfile,
    required Map<String, dynamic> financialData,
  }) async {
    final userPrompt = '''
User Profile:
- Age: ${userProfile.age}
- Primary Goals: ${userProfile.primaryGoals.join(', ')}
- Wealth Goal: ${userProfile.wealthGoal}
- Current Level: ${userProfile.currentLevel}
- XP: ${userProfile.xp}
- Level: ${userProfile.level}

Current Financial Data:
${jsonEncode(financialData)}

Please analyze this user's financial profile and current data to provide personalized wealth management recommendations.
Focus on actionable steps they can take to improve their financial health and achieve their goals.
Consider the Indian financial market context.
''';

    final response = await _makeAIRequest(
      systemPrompt: _wealthSystemPrompt,
      userPrompt: userPrompt,
    );

    return WealthRecommendations.fromJson(response);
  }

  Future<PersonalizedInsights> generatePersonalizedInsights({
    required UserProfile userProfile,
    required Map<String, dynamic> behaviorData,
    required Map<String, dynamic> progressData,
  }) async {
    final userPrompt = '''
User Profile:
- Age: ${userProfile.age}
- Primary Goals: ${userProfile.primaryGoals.join(', ')}
- Health Goal: ${userProfile.healthGoal}
- Wealth Goal: ${userProfile.wealthGoal}
- Current Level: ${userProfile.currentLevel}
- XP: ${userProfile.xp}
- Level: ${userProfile.level}

Behavior Data:
${jsonEncode(behaviorData)}

Progress Data:
${jsonEncode(progressData)}

Please analyze this user's profile, behavior patterns, and progress to create personalized daily tasks, 
weekly goals, and learning recommendations. Focus on maintaining engagement and building sustainable habits.
''';

    final response = await _makeAIRequest(
      systemPrompt: _personalizationSystemPrompt,
      userPrompt: userPrompt,
    );

    return PersonalizedInsights.fromJson(response);
  }

  Future<String> generateMotivationalMessage({
    required UserProfile userProfile,
    required Map<String, dynamic> recentProgress,
  }) async {
    final userPrompt = '''
User Profile:
- Name: ${userProfile.name}
- Primary Goals: ${userProfile.primaryGoals.join(', ')}
- Health Goal: ${userProfile.healthGoal}
- Wealth Goal: ${userProfile.wealthGoal}
- Recent Progress: ${jsonEncode(recentProgress)}

Generate a personalized, encouraging motivational message (2-3 sentences) that:
1. Acknowledges their recent progress
2. Encourages them to continue their journey
3. Is specific to their goals and achievements
4. Maintains a positive, supportive tone
''';

    final response = await _makeAIRequest(
      systemPrompt: 'You are a supportive life coach who creates personalized motivational messages.',
      userPrompt: userPrompt,
      maxTokens: 200,
    );

    return response['message'] ?? 'Keep up the great work! Every step forward is progress toward your goals.';
  }

  void dispose() {
    _client.close();
  }
}

// Riverpod Providers
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService();
});

final healthRecommendationsProvider = FutureProvider.family<HealthRecommendations, Map<String, dynamic>>((ref, params) async {
  final aiService = ref.read(aiServiceProvider);
  final userProfile = params['userProfile'] as UserProfile;
  final healthData = params['healthData'] as Map<String, dynamic>;
  
  return await aiService.generateHealthRecommendations(
    userProfile: userProfile,
    healthData: healthData,
  );
});

final wealthRecommendationsProvider = FutureProvider.family<WealthRecommendations, Map<String, dynamic>>((ref, params) async {
  final aiService = ref.read(aiServiceProvider);
  final userProfile = params['userProfile'] as UserProfile;
  final financialData = params['financialData'] as Map<String, dynamic>;
  
  return await aiService.generateWealthRecommendations(
    userProfile: userProfile,
    financialData: financialData,
  );
});

final personalizedInsightsProvider = FutureProvider.family<PersonalizedInsights, Map<String, dynamic>>((ref, params) async {
  final aiService = ref.read(aiServiceProvider);
  final userProfile = params['userProfile'] as UserProfile;
  final behaviorData = params['behaviorData'] as Map<String, dynamic>;
  final progressData = params['progressData'] as Map<String, dynamic>;
  
  return await aiService.generatePersonalizedInsights(
    userProfile: userProfile,
    behaviorData: behaviorData,
    progressData: progressData,
  );
});

final motivationalMessageProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final aiService = ref.read(aiServiceProvider);
  final userProfile = params['userProfile'] as UserProfile;
  final recentProgress = params['recentProgress'] as Map<String, dynamic>;
  
  return await aiService.generateMotivationalMessage(
    userProfile: userProfile,
    recentProgress: recentProgress,
  );
});