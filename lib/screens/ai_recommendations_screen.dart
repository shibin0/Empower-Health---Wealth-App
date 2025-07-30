import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../utils/app_theme.dart';
import '../models/user_profile.dart';

class AIRecommendationsScreen extends StatefulWidget {
  const AIRecommendationsScreen({super.key});

  @override
  State<AIRecommendationsScreen> createState() => _AIRecommendationsScreenState();
}

class _AIRecommendationsScreenState extends State<AIRecommendationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _generateRecommendations() async {
    setState(() {
      _isGenerating = true;
    });

    try {
      // For demo purposes, create a sample user profile
      final userProfile = _getSampleUserProfile();
      if (userProfile != null) {
        // Generate sample data for demonstration
        final healthData = _generateSampleHealthData();
        final financialData = _generateSampleFinancialData();
        final behaviorData = _generateSampleBehaviorData();
        final progressData = _generateSampleProgressData();

        // For demo purposes, just simulate loading
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating recommendations: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  Map<String, dynamic> _generateSampleHealthData() {
    return {
      'steps': 8500,
      'sleep_hours': 7.2,
      'water_intake': 2.1,
      'exercise_minutes': 45,
      'stress_level': 3,
      'energy_level': 7,
      'mood_score': 8,
      'weight': 70.5,
      'heart_rate': 72,
      'recent_activities': ['walking', 'yoga', 'meditation'],
      'health_metrics': {
        'bmi': 22.5,
        'body_fat': 15.2,
        'muscle_mass': 45.8,
      }
    };
  }

  Map<String, dynamic> _generateSampleFinancialData() {
    return {
      'monthly_income': 75000,
      'monthly_expenses': 55000,
      'savings_rate': 26.7,
      'investments': {
        'mutual_funds': 150000,
        'stocks': 75000,
        'fixed_deposits': 100000,
        'emergency_fund': 200000,
      },
      'debt': {
        'home_loan': 1500000,
        'credit_card': 25000,
      },
      'insurance': {
        'life_insurance': 1000000,
        'health_insurance': 500000,
      },
      'financial_goals': [
        'retirement_planning',
        'child_education',
        'home_purchase',
      ]
    };
  }

  Map<String, dynamic> _generateSampleBehaviorData() {
    return {
      'app_usage_minutes': 25,
      'lessons_completed': 12,
      'quizzes_taken': 8,
      'streak_days': 15,
      'preferred_time': 'evening',
      'engagement_score': 85,
      'learning_pace': 'moderate',
      'interaction_patterns': {
        'health_focus': 60,
        'wealth_focus': 40,
      }
    };
  }

  Map<String, dynamic> _generateSampleProgressData() {
    return {
      'goals_achieved': 3,
      'total_goals': 8,
      'weekly_progress': 78,
      'monthly_progress': 65,
      'improvement_areas': ['sleep', 'investment_diversification'],
      'strengths': ['consistency', 'learning_engagement'],
      'recent_achievements': ['7_day_streak', 'first_investment'],
    };
  }

  UserProfile _getSampleUserProfile() {
    return UserProfile(
      id: 'demo_user',
      name: 'Demo User',
      age: '28',
      city: 'Mumbai',
      primaryGoals: ['improve_health', 'build_wealth', 'learn_investing'],
      healthGoal: 'Improve overall fitness and mental well-being',
      wealthGoal: 'Build a diversified investment portfolio',
      currentLevel: 'Intermediate',
      xp: 1250,
      level: 3,
      streak: 15,
      badges: ['early_bird', 'consistent_learner', 'quiz_master'],
      joinedDate: DateTime.now().subtract(const Duration(days: 45)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = _getSampleUserProfile();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'AI Recommendations',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: _isGenerating ? null : _generateRecommendations,
            icon: _isGenerating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            tooltip: 'Generate New Recommendations',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.lightMutedForeground,
          indicatorColor: AppTheme.primaryColor,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Health'),
            Tab(text: 'Wealth'),
            Tab(text: 'Personal'),
          ],
        ),
      ),
      body: userProfile == null
          ? const Center(
              child: Text(
                  'Please complete your profile to get AI recommendations'),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildHealthRecommendationsTab(userProfile),
                _buildWealthRecommendationsTab(userProfile),
                _buildPersonalInsightsTab(userProfile),
              ],
            ),
    );
  }

  Widget _buildHealthRecommendationsTab(UserProfile userProfile) {
    return FutureBuilder<HealthRecommendations>(
      future: _generateHealthRecommendations(userProfile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorWidget('Health recommendations', snapshot.error!);
        } else if (snapshot.hasData) {
          return _buildHealthRecommendationsContent(snapshot.data!);
        } else {
          return const Center(child: Text('No recommendations available'));
        }
      },
    );
  }

  Widget _buildWealthRecommendationsTab(UserProfile userProfile) {
    return FutureBuilder<WealthRecommendations>(
      future: _generateWealthRecommendations(userProfile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorWidget('Wealth recommendations', snapshot.error!);
        } else if (snapshot.hasData) {
          return _buildWealthRecommendationsContent(snapshot.data!);
        } else {
          return const Center(child: Text('No recommendations available'));
        }
      },
    );
  }

  Widget _buildPersonalInsightsTab(UserProfile userProfile) {
    return FutureBuilder<PersonalizedInsights>(
      future: _generatePersonalizedInsights(userProfile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorWidget('Personal insights', snapshot.error!);
        } else if (snapshot.hasData) {
          return _buildPersonalInsightsContent(snapshot.data!);
        } else {
          return const Center(child: Text('No insights available'));
        }
      },
    );
  }

  Future<HealthRecommendations> _generateHealthRecommendations(UserProfile userProfile) async {
    final aiService = AIService();
    final healthData = _generateSampleHealthData();
    return await aiService.generateHealthRecommendations(
      userProfile: userProfile,
      healthData: healthData,
    );
  }

  Future<WealthRecommendations> _generateWealthRecommendations(UserProfile userProfile) async {
    final aiService = AIService();
    final financialData = _generateSampleFinancialData();
    return await aiService.generateWealthRecommendations(
      userProfile: userProfile,
      financialData: financialData,
    );
  }

  Future<PersonalizedInsights> _generatePersonalizedInsights(UserProfile userProfile) async {
    final aiService = AIService();
    final behaviorData = _generateSampleBehaviorData();
    final progressData = _generateSampleProgressData();
    return await aiService.generatePersonalizedInsights(
      userProfile: userProfile,
      behaviorData: behaviorData,
      progressData: progressData,
    );
  }

  Widget _buildHealthRecommendationsContent(
      HealthRecommendations recommendations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Health Score Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Health Score',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getScoreColor(recommendations.healthScore)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${recommendations.healthScore.toInt()}/100',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color:
                                    _getScoreColor(recommendations.healthScore),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: recommendations.healthScore / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(
                        _getScoreColor(recommendations.healthScore)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recommendations.summary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Key Insights
          if (recommendations.keyInsights.isNotEmpty) ...[
            Text(
              'Key Insights',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...recommendations.keyInsights.map((insight) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.lightbulb,
                        color: AppTheme.warningColor),
                    title: Text(insight),
                  ),
                )),
            const SizedBox(height: 16),
          ],

          // Recommendations
          Text(
            'Personalized Recommendations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...recommendations.recommendations
              .map((rec) => _buildRecommendationCard(rec)),
        ],
      ),
    );
  }

  Widget _buildWealthRecommendationsContent(
      WealthRecommendations recommendations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wealth Score Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wealth Score',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getScoreColor(recommendations.wealthScore)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${recommendations.wealthScore.toInt()}/100',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color:
                                    _getScoreColor(recommendations.wealthScore),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: recommendations.wealthScore / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(
                        _getScoreColor(recommendations.wealthScore)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recommendations.summary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Portfolio Analysis
          if (recommendations.portfolioAnalysis.isNotEmpty) ...[
            Text(
              'Portfolio Analysis',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children:
                      recommendations.portfolioAnalysis.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatAnalysisKey(entry.key),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '${entry.value.toStringAsFixed(1)}${entry.key.contains('score') ? '/100' : '%'}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Key Insights
          if (recommendations.keyInsights.isNotEmpty) ...[
            Text(
              'Key Insights',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...recommendations.keyInsights.map((insight) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.trending_up,
                        color: AppTheme.successColor),
                    title: Text(insight),
                  ),
                )),
            const SizedBox(height: 16),
          ],
// Recommendations
          Text(
            'Personalized Recommendations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...recommendations.recommendations
              .map((rec) => _buildRecommendationCard(rec)),
        ],
      ),
    );
  }

  Widget _buildPersonalInsightsContent(PersonalizedInsights insights) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// Progress Score Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress Score',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getScoreColor(insights.progressScore)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${insights.progressScore.toInt()}/100',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: _getScoreColor(insights.progressScore),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: insights.progressScore / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(
                        _getScoreColor(insights.progressScore)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    insights.motivationalMessage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

// Daily Tasks
          if (insights.dailyTasks.isNotEmpty) ...[
            Text(
              'Today\'s Tasks',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...insights.dailyTasks
                .map((task) => _buildRecommendationCard(task)),
            const SizedBox(height: 16),
          ],

// Weekly Goals
          if (insights.weeklyGoals.isNotEmpty) ...[
            Text(
              'This Week\'s Goals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...insights.weeklyGoals
                .map((goal) => _buildRecommendationCard(goal)),
            const SizedBox(height: 16),
          ],

// Learning Modules
          if (insights.learningModules.isNotEmpty) ...[
            Text(
              'Recommended Learning',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...insights.learningModules
                .map((module) => _buildRecommendationCard(module)),
          ],
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(AIRecommendation recommendation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(recommendation.category)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatCategory(recommendation.category),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getCategoryColor(recommendation.category),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Spacer(),
                ...List.generate(
                  recommendation.priority,
                  (index) => Icon(
                    Icons.star,
                    size: 16,
                    color: AppTheme.warningColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              recommendation.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              recommendation.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (recommendation.actionItems.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Action Items:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              ...recommendation.actionItems.map((action) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(
                          child: Text(
                            action,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String type, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load $type',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your internet connection and try again.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightMutedForeground,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateRecommendations,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return AppTheme.successColor;
    if (score >= 60) return AppTheme.primaryColor;
    if (score >= 40) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'nutrition':
      case 'health':
        return AppTheme.successColor;
      case 'fitness':
      case 'exercise':
        return AppTheme.primaryColor;
      case 'mental_health':
      case 'mindfulness':
        return Colors.purple;
      case 'sleep':
        return Colors.indigo;
      case 'investment':
      case 'wealth':
        return AppTheme.primaryColor;
      case 'budgeting':
        return AppTheme.warningColor;
      case 'insurance':
        return Colors.orange;
      case 'tax_planning':
        return Colors.teal;
      case 'learning':
        return Colors.blue;
      default:
        return AppTheme.lightMutedForeground;
    }
  }

  String _formatCategory(String category) {
    return category
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatAnalysisKey(String key) {
    return key
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
