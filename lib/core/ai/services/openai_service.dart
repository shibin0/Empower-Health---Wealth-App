import 'dart:async';
import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ai_models.dart';
import '../../storage/enhanced_storage_service.dart';

part 'openai_service.g.dart';

@riverpod
OpenAIService openAIService(OpenAIServiceRef ref) {
  return OpenAIService(ref);
}

/// OpenAI Integration Service for AI-powered features
class OpenAIService {
  final Ref _ref;
  static const String _apiKeyStorageKey = 'openai_api_key';
  static const String _conversationHistoryKey = 'ai_conversation_history';
  
  OpenAIService(this._ref) {
    _initializeOpenAI();
  }

  /// Initialize OpenAI with API key
  Future<void> _initializeOpenAI() async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      final apiKey = await storage.getString(_apiKeyStorageKey);
      
      if (apiKey != null && apiKey.isNotEmpty) {
        OpenAI.apiKey = apiKey;
        OpenAI.organization = "your-organization-id"; // Optional
      } else {
        // Use environment variable or default key for development
        OpenAI.apiKey = const String.fromEnvironment(
          'OPENAI_API_KEY',
          defaultValue: 'your-openai-api-key-here',
        );
      }
    } catch (e) {
      print('Error initializing OpenAI: $e');
    }
  }

  /// Set OpenAI API Key
  Future<void> setApiKey(String apiKey) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      await storage.setString(_apiKeyStorageKey, apiKey);
      OpenAI.apiKey = apiKey;
    } catch (e) {
      throw Exception('Failed to set API key: $e');
    }
  }

  /// Generate personalized health recommendations
  Future<List<AIRecommendation>> generateHealthRecommendations({
    required Map<String, dynamic> healthData,
    required Map<String, dynamic> userProfile,
    int maxRecommendations = 5,
  }) async {
    try {
      final prompt = _buildHealthRecommendationPrompt(healthData, userProfile);
      
      final completion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 1500,
        temperature: 0.7,
      );

      final response = completion.choices.first.message.content?.first.text ?? '';
      return _parseHealthRecommendations(response, maxRecommendations);
    } catch (e) {
      throw Exception('Failed to generate health recommendations: $e');
    }
  }

  /// Generate wealth management recommendations
  Future<List<AIRecommendation>> generateWealthRecommendations({
    required Map<String, dynamic> financialData,
    required Map<String, dynamic> userProfile,
    int maxRecommendations = 5,
  }) async {
    try {
      final prompt = _buildWealthRecommendationPrompt(financialData, userProfile);
      
      final completion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 1500,
        temperature: 0.7,
      );

      final response = completion.choices.first.message.content?.first.text ?? '';
      return _parseWealthRecommendations(response, maxRecommendations);
    } catch (e) {
      throw Exception('Failed to generate wealth recommendations: $e');
    }
  }

  /// Generate AI insights from user data
  Future<List<AIInsight>> generateInsights({
    required Map<String, dynamic> userData,
    required List<String> categories,
  }) async {
    try {
      final prompt = _buildInsightPrompt(userData, categories);
      
      final completion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 2000,
        temperature: 0.6,
      );

      final response = completion.choices.first.message.content?.first.text ?? '';
      return _parseInsights(response);
    } catch (e) {
      throw Exception('Failed to generate insights: $e');
    }
  }

  /// Chat with AI assistant
  Future<AIChatMessage> chatWithAssistant({
    required String userMessage,
    required String userId,
    List<AIChatMessage>? conversationHistory,
  }) async {
    try {
      // Load conversation history if not provided
      conversationHistory ??= await _loadConversationHistory(userId);
      
      // Build conversation context
      final messages = <OpenAIChatCompletionChoiceMessageModel>[];
      
      // Add system message
      messages.add(OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            _getSystemPrompt(),
          ),
        ],
        role: OpenAIChatMessageRole.system,
      ));

      // Add conversation history
      for (final message in conversationHistory.take(10)) { // Limit history
        messages.add(OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(message.content),
          ],
          role: message.isUser 
              ? OpenAIChatMessageRole.user 
              : OpenAIChatMessageRole.assistant,
        ));
      }

      // Add current user message
      messages.add(OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(userMessage),
        ],
        role: OpenAIChatMessageRole.user,
      ));

      final completion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: messages,
        maxTokens: 1000,
        temperature: 0.8,
      );

      final response = completion.choices.first.message.content?.first.text ?? '';
      
      // Create AI response message
      final aiMessage = AIChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      // Save conversation
      await _saveConversationMessage(userId, aiMessage);
      
      return aiMessage;
    } catch (e) {
      throw Exception('Failed to chat with assistant: $e');
    }
  }

  /// Generate predictions based on user data
  Future<List<AIPrediction>> generatePredictions({
    required Map<String, dynamic> userData,
    required List<String> predictionTypes,
  }) async {
    try {
      final prompt = _buildPredictionPrompt(userData, predictionTypes);
      
      final completion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 1500,
        temperature: 0.5,
      );

      final response = completion.choices.first.message.content?.first.text ?? '';
      return _parsePredictions(response);
    } catch (e) {
      throw Exception('Failed to generate predictions: $e');
    }
  }

  /// Analyze user behavior patterns
  Future<UserBehaviorAnalytics> analyzeUserBehavior({
    required String userId,
    required Map<String, dynamic> activityData,
  }) async {
    try {
      final prompt = _buildBehaviorAnalysisPrompt(activityData);
      
      final completion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 1000,
        temperature: 0.3,
      );

      final response = completion.choices.first.message.content?.first.text ?? '';
      return _parseBehaviorAnalytics(userId, response);
    } catch (e) {
      throw Exception('Failed to analyze user behavior: $e');
    }
  }

  // Private helper methods

  String _buildHealthRecommendationPrompt(
    Map<String, dynamic> healthData,
    Map<String, dynamic> userProfile,
  ) {
    return '''
    As a health AI assistant, analyze the following user data and provide personalized health recommendations:

    User Profile:
    - Age: ${userProfile['age'] ?? 'Unknown'}
    - Gender: ${userProfile['gender'] ?? 'Unknown'}
    - Activity Level: ${userProfile['activityLevel'] ?? 'Unknown'}
    - Health Goals: ${userProfile['healthGoals'] ?? 'General wellness'}

    Health Data:
    - Steps: ${healthData['steps'] ?? 'No data'}
    - Heart Rate: ${healthData['heartRate'] ?? 'No data'}
    - Sleep: ${healthData['sleep'] ?? 'No data'}
    - Weight: ${healthData['weight'] ?? 'No data'}
    - Exercise: ${healthData['exercise'] ?? 'No data'}

    Please provide 3-5 specific, actionable health recommendations in JSON format:
    {
      "recommendations": [
        {
          "title": "Recommendation title",
          "description": "Detailed description",
          "type": "health",
          "confidence": "high|medium|low",
          "score": 0.0-1.0,
          "tags": ["tag1", "tag2"],
          "reasons": ["reason1", "reason2"]
        }
      ]
    }
    ''';
  }

  String _buildWealthRecommendationPrompt(
    Map<String, dynamic> financialData,
    Map<String, dynamic> userProfile,
  ) {
    return '''
    As a financial AI advisor, analyze the following user data and provide personalized wealth management recommendations:

    User Profile:
    - Age: ${userProfile['age'] ?? 'Unknown'}
    - Income: ${userProfile['income'] ?? 'Unknown'}
    - Risk Tolerance: ${userProfile['riskTolerance'] ?? 'Unknown'}
    - Financial Goals: ${userProfile['financialGoals'] ?? 'General wealth building'}

    Financial Data:
    - Savings: ${financialData['savings'] ?? 'No data'}
    - Investments: ${financialData['investments'] ?? 'No data'}
    - Expenses: ${financialData['expenses'] ?? 'No data'}
    - Debt: ${financialData['debt'] ?? 'No data'}

    Please provide 3-5 specific, actionable wealth management recommendations in JSON format:
    {
      "recommendations": [
        {
          "title": "Recommendation title",
          "description": "Detailed description",
          "type": "wealth",
          "confidence": "high|medium|low",
          "score": 0.0-1.0,
          "tags": ["tag1", "tag2"],
          "reasons": ["reason1", "reason2"]
        }
      ]
    }
    ''';
  }

  String _buildInsightPrompt(
    Map<String, dynamic> userData,
    List<String> categories,
  ) {
    return '''
    Analyze the following user data and generate insights for categories: ${categories.join(', ')}

    User Data: ${jsonEncode(userData)}

    Provide insights in JSON format:
    {
      "insights": [
        {
          "title": "Insight title",
          "content": "Detailed insight content",
          "category": "trend|prediction|recommendation|alert",
          "confidence": "high|medium|low",
          "relevanceScore": 0.0-1.0
        }
      ]
    }
    ''';
  }

  String _buildPredictionPrompt(
    Map<String, dynamic> userData,
    List<String> predictionTypes,
  ) {
    return '''
    Based on the user data, generate predictions for: ${predictionTypes.join(', ')}

    User Data: ${jsonEncode(userData)}

    Provide predictions in JSON format:
    {
      "predictions": [
        {
          "type": "prediction type",
          "description": "What is predicted",
          "probability": 0.0-1.0,
          "predictedDate": "ISO date string",
          "confidence": "high|medium|low",
          "factors": {"factor1": "value1"}
        }
      ]
    }
    ''';
  }

  String _buildBehaviorAnalysisPrompt(Map<String, dynamic> activityData) {
    return '''
    Analyze user behavior patterns from the following activity data:

    Activity Data: ${jsonEncode(activityData)}

    Provide behavior analysis in JSON format:
    {
      "actionCounts": {"action1": count1},
      "engagementScores": {"category1": score1},
      "preferredCategories": ["category1", "category2"],
      "overallEngagementScore": 0.0-1.0,
      "patterns": {"pattern1": "description1"},
      "interests": ["interest1", "interest2"]
    }
    ''';
  }

  String _getSystemPrompt() {
    return '''
    You are an AI assistant for the Empower Health & Wealth app, designed to help Indian youth with health and financial literacy. 
    You provide personalized, actionable advice while being culturally sensitive and age-appropriate. 
    Keep responses concise, encouraging, and practical.
    ''';
  }

  // Parsing methods
  List<AIRecommendation> _parseHealthRecommendations(String response, int maxRecommendations) {
    // Implementation for parsing health recommendations from AI response
    // This would parse the JSON response and create AIRecommendation objects
    return [];
  }

  List<AIRecommendation> _parseWealthRecommendations(String response, int maxRecommendations) {
    // Implementation for parsing wealth recommendations from AI response
    return [];
  }

  List<AIInsight> _parseInsights(String response) {
    // Implementation for parsing insights from AI response
    return [];
  }

  List<AIPrediction> _parsePredictions(String response) {
    // Implementation for parsing predictions from AI response
    return [];
  }

  UserBehaviorAnalytics _parseBehaviorAnalytics(String userId, String response) {
    // Implementation for parsing behavior analytics from AI response
    return UserBehaviorAnalytics(
      userId: userId,
      actionCounts: {},
      engagementScores: {},
      preferredCategories: [],
      lastActivityTimes: {},
      overallEngagementScore: 0.0,
      lastUpdated: DateTime.now(),
    );
  }

  // Conversation management methods
  Future<List<AIChatMessage>> _loadConversationHistory(String userId) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      final historyJson = await storage.getString('${_conversationHistoryKey}_$userId');
      
      if (historyJson != null) {
        final List<dynamic> historyList = jsonDecode(historyJson);
        return historyList
            .map((json) => AIChatMessage.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error loading conversation history: $e');
      return [];
    }
  }

  Future<void> _saveConversationMessage(String userId, AIChatMessage message) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      final historyKey = '${_conversationHistoryKey}_$userId';
      
      // Load existing history
      final existingHistory = await _loadConversationHistory(userId);
      
      // Add new message
      existingHistory.add(message);
      
      // Keep only last 50 messages
      final limitedHistory = existingHistory.length > 50
          ? existingHistory.sublist(existingHistory.length - 50)
          : existingHistory;
      
      // Save updated history
      final historyJson = jsonEncode(
        limitedHistory.map((msg) => msg.toJson()).toList(),
      );
      await storage.setString(historyKey, historyJson);
    } catch (e) {
      print('Error saving conversation message: $e');
    }
  }

  Future<void> clearConversationHistory(String userId) async {
    try {
      final storage = _ref.read(enhancedStorageServiceProvider);
      await storage.remove('${_conversationHistoryKey}_$userId');
    } catch (e) {
      print('Error clearing conversation history: $e');
    }
  }
}