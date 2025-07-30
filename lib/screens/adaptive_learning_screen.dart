import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../services/adaptive_learning_service.dart';
import '../services/auth_service.dart';

class AdaptiveLearningScreen extends ConsumerStatefulWidget {
  const AdaptiveLearningScreen({super.key});

  @override
  ConsumerState<AdaptiveLearningScreen> createState() => _AdaptiveLearningScreenState();
}

class _AdaptiveLearningScreenState extends ConsumerState<AdaptiveLearningScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to view adaptive learning')),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Adaptive Learning'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Recommendations'),
            Tab(text: 'Learning Paths'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecommendationsTab(user.id),
          _buildLearningPathsTab(user.id),
          _buildAnalyticsTab(user.id),
        ],
      ),
    );
  }

  Widget _buildRecommendationsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final recommendationsAsync = ref.watch(personalizedRecommendationsProvider(userId));

        return recommendationsAsync.when(
          data: (recommendations) {
            if (recommendations.isEmpty) {
              return _buildEmptyRecommendations();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personalized for You',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Based on your progress and preferences',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 24),
                  ...recommendations.map((recommendation) => 
                    _buildRecommendationCard(recommendation)),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildLearningPathsTab(String userId) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Learning Journey',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Structured paths to achieve your goals',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),
          _buildCategorySection('Health', 'health', userId),
          const SizedBox(height: 32),
          _buildCategorySection('Wealth', 'wealth', userId),
          const SizedBox(height: 32),
          _buildCategorySection('Mixed', 'mixed', userId),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final analyticsAsync = ref.watch(learningAnalyticsProvider(userId));

        return analyticsAsync.when(
          data: (analytics) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learning Analytics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track your learning progress and insights',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildAnalyticsGrid(analytics),
                  const SizedBox(height: 32),
                  _buildLearningInsights(analytics),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildRecommendationCard(LearningRecommendation recommendation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(recommendation.category).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    recommendation.category.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getCategoryColor(recommendation.category),
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
                          'AI Recommended',
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
            const SizedBox(height: 16),
            Text(
              recommendation.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              recommendation.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why this is recommended:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recommendation.reasoning,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
                const SizedBox(width: 16),
                Icon(
                  Icons.trending_up,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  recommendation.difficulty,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
                const Spacer(),
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
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _startLearningPath(recommendation);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getCategoryColor(recommendation.category),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Start Learning Path'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, String category, String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final pathAsync = ref.watch(adaptiveLearningPathProvider((userId: userId, category: category)));

        return pathAsync.when(
          data: (path) {
            if (path == null) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                _buildLearningPathCard(path),
              ],
            );
          },
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildLearningPathCard(LearningPath path) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(path.category).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(path.category),
                    color: _getCategoryColor(path.category),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        path.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        path.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildPathInfo(Icons.schedule, '${path.estimatedDuration} min'),
                const SizedBox(width: 16),
                _buildPathInfo(Icons.trending_up, path.difficulty),
                const SizedBox(width: 16),
                _buildPathInfo(Icons.book, '${path.moduleIds.length} modules'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _startLearningPath(LearningRecommendation(
                    pathId: path.id,
                    title: path.title,
                    description: path.description,
                    category: path.category,
                    relevanceScore: 1.0,
                    reasoning: 'Selected learning path',
                    estimatedDuration: path.estimatedDuration,
                    difficulty: path.difficulty,
                    nextModules: path.moduleIds.take(3).toList(),
                    isPersonalized: false,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getCategoryColor(path.category),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start This Path'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPathInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsGrid(Map<String, dynamic> analytics) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildAnalyticsCard(
          'Modules Started',
          '${analytics['totalModulesStarted']}',
          Icons.play_circle_outline,
          AppTheme.primaryColor,
        ),
        _buildAnalyticsCard(
          'Completed',
          '${analytics['totalModulesCompleted']}',
          Icons.check_circle,
          AppTheme.successColor,
        ),
        _buildAnalyticsCard(
          'Quiz Average',
          '${(analytics['averageQuizScore'] * 100).toInt()}%',
          Icons.quiz,
          AppTheme.warningColor,
        ),
        _buildAnalyticsCard(
          'Learning Streak',
          '${analytics['learningStreak']} days',
          Icons.local_fire_department,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningInsights(Map<String, dynamic> analytics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learning Insights',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInsightRow(
                  'Strongest Category',
                  analytics['strongestCategory'],
                  Icons.star,
                  AppTheme.successColor,
                ),
                const SizedBox(height: 12),
                _buildInsightRow(
                  'Completion Rate',
                  '${(analytics['completionRate'] * 100).toInt()}%',
                  Icons.trending_up,
                  AppTheme.primaryColor,
                ),
                const SizedBox(height: 12),
                _buildInsightRow(
                  'Learning Velocity',
                  '${analytics['learningVelocity'].toStringAsFixed(1)} modules/hour',
                  Icons.speed,
                  AppTheme.warningColor,
                ),
                const SizedBox(height: 12),
                _buildInsightRow(
                  'Recommended Focus',
                  analytics['recommendedFocus'],
                  Icons.lightbulb,
                  Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsightRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyRecommendations() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'No Recommendations Yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Complete some lessons to get personalized recommendations',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
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

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'health':
        return Icons.favorite;
      case 'wealth':
        return Icons.attach_money;
      case 'mixed':
        return Icons.auto_awesome;
      default:
        return Icons.book;
    }
  }

  void _startLearningPath(LearningRecommendation recommendation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start ${recommendation.title}'),
        content: Text(
          'This will begin your personalized learning journey. '
          'You\'ll start with: ${recommendation.nextModules.join(', ')}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to first module in the path
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Starting ${recommendation.title}...'),
                  backgroundColor: _getCategoryColor(recommendation.category),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _getCategoryColor(recommendation.category),
              foregroundColor: Colors.white,
            ),
            child: const Text('Start Learning'),
          ),
        ],
      ),
    );
  }
}