import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../services/progress_tracking_service.dart';
import '../services/auth_service.dart';
import '../services/simple_onboarding_service.dart';
import '../models/onboarding_data.dart';

class AnalyticsDashboardScreen extends ConsumerStatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  ConsumerState<AnalyticsDashboardScreen> createState() => _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends ConsumerState<AnalyticsDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeRange = '7d';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        body: Center(child: Text('Please log in to view analytics')),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Analytics & Insights'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedTimeRange,
            onSelected: (value) {
              setState(() {
                _selectedTimeRange = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: '7d', child: Text('Last 7 days')),
              const PopupMenuItem(value: '30d', child: Text('Last 30 days')),
              const PopupMenuItem(value: '90d', child: Text('Last 3 months')),
              const PopupMenuItem(value: '1y', child: Text('Last year')),
            ],
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getTimeRangeLabel(_selectedTimeRange),
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppTheme.primaryColor,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Progress'),
            Tab(text: 'Goals'),
            Tab(text: 'Insights'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(user.id),
          _buildProgressTab(user.id),
          _buildGoalsTab(user.id),
          _buildInsightsTab(user.id),
        ],
      ),
    );
  }

  String _getTimeRangeLabel(String timeRange) {
    switch (timeRange) {
      case '7d':
        return '7 days';
      case '30d':
        return '30 days';
      case '90d':
        return '3 months';
      case '1y':
        return '1 year';
      default:
        return '7 days';
    }
  }

  Widget _buildOverviewTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final overallStatsAsync = ref.watch(overallStatsProvider(userId));
        final moduleProgressAsync = ref.watch(moduleProgressProvider(userId));

        return overallStatsAsync.when(
          data: (stats) {
            return moduleProgressAsync.when(
              data: (moduleProgress) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Key Metrics Cards
                      _buildKeyMetricsSection(stats),
                      const SizedBox(height: 24),

                      // Activity Chart
                      _buildActivityChartSection(userId),
                      const SizedBox(height: 24),

                      // Category Breakdown
                      _buildCategoryBreakdownSection(moduleProgress),
                      const SizedBox(height: 24),

                      // Recent Achievements
                      _buildRecentAchievementsSection(stats),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildProgressTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final moduleProgressAsync = ref.watch(moduleProgressProvider(userId));

        return moduleProgressAsync.when(
          data: (moduleProgress) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Trends Chart
                  _buildProgressTrendsSection(userId),
                  const SizedBox(height: 24),

                  // Module Progress Details
                  _buildModuleProgressSection(moduleProgress),
                  const SizedBox(height: 24),

                  // Learning Velocity
                  _buildLearningVelocitySection(userId),
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

  Widget _buildGoalsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final onboardingData = ref.watch(onboardingDataProvider);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Goal Progress Overview
              _buildGoalProgressOverview(userId, onboardingData),
              const SizedBox(height: 24),

              // Individual Goal Tracking
              _buildIndividualGoalsSection(userId, onboardingData),
              const SizedBox(height: 24),

              // Goal Recommendations
              _buildGoalRecommendationsSection(onboardingData),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInsightsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final overallStatsAsync = ref.watch(overallStatsProvider(userId));
        final onboardingData = ref.watch(onboardingDataProvider);

        return overallStatsAsync.when(
          data: (stats) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personalized Insights
                  _buildPersonalizedInsightsSection(stats, onboardingData),
                  const SizedBox(height: 24),

                  // Learning Patterns
                  _buildLearningPatternsSection(userId),
                  const SizedBox(height: 24),

                  // Recommendations
                  _buildRecommendationsSection(stats, onboardingData),
                  const SizedBox(height: 24),

                  // Comparative Analysis
                  _buildComparativeAnalysisSection(stats),
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

  Widget _buildKeyMetricsSection(Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildMetricCard(
              'Total XP',
              '${(stats['completedLessons'] ?? 0) * 100}',
              Icons.star,
              AppTheme.warningColor,
              '+${(stats['completedQuizzes'] ?? 0) * 50} this week',
            ),
            _buildMetricCard(
              'Lessons Completed',
              '${stats['completedLessons'] ?? 0}',
              Icons.book,
              AppTheme.successColor,
              '${((stats['lessonCompletionRate'] ?? 0.0) * 100).toInt()}% completion rate',
            ),
            _buildMetricCard(
              'Current Streak',
              '${(stats['completedLessons'] ?? 0) > 0 ? 3 : 0} days',
              Icons.local_fire_department,
              AppTheme.errorColor,
              'Best: ${(stats['completedLessons'] ?? 0) > 0 ? 7 : 0} days',
            ),
            _buildMetricCard(
              'Quiz Accuracy',
              '${((stats['quizPassRate'] ?? 0.0) * 100).toInt()}%',
              Icons.quiz,
              AppTheme.infoColor,
              '${stats['completedQuizzes'] ?? 0} quizzes taken',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChartSection(String userId) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Activity Overview',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  _getTimeRangeLabel(_selectedTimeRange),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: _buildSimpleActivityChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleActivityChart() {
    // Simple placeholder chart - in a real app, you'd use a charting library
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 48, color: AppTheme.primaryColor),
            SizedBox(height: 8),
            Text('Activity Chart'),
            Text('Chart visualization would go here', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdownSection(List<ModuleProgress> moduleProgress) {
    final healthModules = moduleProgress.where((m) => m.category == 'health').toList();
    final wealthModules = moduleProgress.where((m) => m.category == 'wealth').toList();

    final healthProgress = healthModules.isEmpty
        ? 0.0
        : healthModules.map((m) => m.overallProgress).reduce((a, b) => a + b) / healthModules.length;
    final wealthProgress = wealthModules.isEmpty
        ? 0.0
        : wealthModules.map((m) => m.overallProgress).reduce((a, b) => a + b) / wealthModules.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Progress',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCategoryProgressItem(
              'Health & Wellness',
              healthProgress,
              AppTheme.healthColor,
              Icons.favorite,
              '${healthModules.length} modules',
            ),
            const SizedBox(width: 12),
            _buildCategoryProgressItem(
              'Wealth & Finance',
              wealthProgress,
              AppTheme.wealthColor,
              Icons.attach_money,
              '${wealthModules.length} modules',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProgressItem(
    String title,
    double progress,
    Color color,
    IconData icon,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentAchievementsSection(Map<String, dynamic> stats) {
    final achievements = [
      {
        'title': 'First Lesson Completed',
        'description': 'Completed your first lesson',
        'icon': Icons.school,
        'color': AppTheme.successColor,
        'date': 'Today',
      },
      {
        'title': '7-Day Streak',
        'description': 'Maintained a 7-day learning streak',
        'icon': Icons.local_fire_department,
        'color': AppTheme.errorColor,
        'date': 'Yesterday',
      },
      {
        'title': 'Quiz Master',
        'description': 'Scored 100% on a quiz',
        'icon': Icons.quiz,
        'color': AppTheme.infoColor,
        'date': '2 days ago',
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Achievements',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...achievements.map((achievement) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (achievement['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      achievement['icon'] as IconData,
                      color: achievement['color'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement['title'] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          achievement['description'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    achievement['date'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTrendsSection(String userId) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress Trends',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up, size: 48, color: AppTheme.primaryColor),
                      SizedBox(height: 8),
                      Text('Progress Trends Chart'),
                      Text('Trend visualization would go here', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleProgressSection(List<ModuleProgress> moduleProgress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Module Progress Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...moduleProgress.map((module) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        module.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(module.overallProgress * 100).toInt()}%',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: module.overallProgress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lesson: ${module.lessonCompleted ? 'Completed' : 'In Progress'} | Quiz: ${module.quizCompleted ? (module.quizPassed ? 'Passed' : 'Failed') : 'Not Started'}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningVelocitySection(String userId) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Velocity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildVelocityMetric(
                    'Lessons/Week',
                    '3.2',
                    Icons.speed,
                    AppTheme.successColor,
                    '+0.5 from last week',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVelocityMetric(
                    'Avg. Session',
                    '12 min',
                    Icons.timer,
                    AppTheme.infoColor,
                    'Optimal range',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVelocityMetric(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalProgressOverview(String userId, OnboardingData? onboardingData) {
    final goals = onboardingData?.primaryGoals ?? [];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Goal Progress Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (goals.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('No goals set yet. Set your goals to track progress!'),
                ),
              )
            else
              Column(
                children: goals.map((goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildGoalProgressItem(goal),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalProgressItem(String goal) {
    // Mock progress data - in real app, this would come from actual progress tracking
    final progress = 0.6 + (goal.hashCode % 40) / 100; // Mock progress between 60-100%
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                goal,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
        ),
      ],
    );
  }

  Widget _buildIndividualGoalsSection(String userId, OnboardingData? onboardingData) {
    final goals = onboardingData?.primaryGoals ?? [];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Individual Goal Tracking',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to goal setting screen
                  },
                  child: const Text('Edit Goals'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (goals.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    children: [
                      Icon(Icons.flag, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('No individual goals set'),
                      Text('Set specific goals to track detailed progress'),
                    ],
                  ),
                ),
              )
            else
              ...goals.map((goal) => _buildDetailedGoalCard(goal)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedGoalCard(String goal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goal,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                'Target: End of month',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalRecommendationsSection(dynamic onboardingData) {
    final interests = onboardingData?.interests ?? [];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Goal Recommendations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...interests.take(3).map((interest) => _buildRecommendationItem(
              'Improve $interest knowledge',
              'Based on your interests, consider setting a goal to complete all $interest modules',
              Icons.lightbulb,
              AppTheme.warningColor,
            )),
            if (interests.isEmpty)
              _buildRecommendationItem(
                'Set your first goal',
                'Start with a simple goal like completing one lesson per week',
                Icons.flag,
                AppTheme.primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalizedInsightsSection(Map<String, dynamic> stats, dynamic onboardingData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personalized Insights',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
              'Learning Progress',
              'You\'re making great progress! You\'ve completed ${stats['completedLessons'] ?? 0} lessons.',
              Icons.trending_up,
              AppTheme.successColor,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              'Quiz Performance',
              'Your quiz accuracy is ${((stats['quizPassRate'] ?? 0.0) * 100).toInt()}%. Keep up the good work!',
              Icons.quiz,
              AppTheme.infoColor,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              'Recommendation',
              'Based on your progress, try focusing on ${_getRecommendedCategory(stats)} modules next.',
              Icons.lightbulb,
              AppTheme.warningColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getRecommendedCategory(Map<String, dynamic> stats) {
    final healthProgress = stats['healthProgress'] ?? 0.0;
    final wealthProgress = stats['wealthProgress'] ?? 0.0;
    
    if (healthProgress < wealthProgress) {
      return 'health';
    } else if (wealthProgress < healthProgress) {
      return 'wealth';
    } else {
      return 'health'; // Default recommendation
    }
  }

  Widget _buildLearningPatternsSection(String userId) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Patterns',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPatternItem(
              'Best Learning Time',
              'You tend to learn best in the evening',
              Icons.schedule,
              AppTheme.infoColor,
            ),
            const SizedBox(height: 12),
            _buildPatternItem(
              'Preferred Content',
              'You engage more with health-related content',
              Icons.favorite,
              AppTheme.healthColor,
            ),
            const SizedBox(height: 12),
            _buildPatternItem(
              'Learning Style',
              'You prefer shorter, focused sessions',
              Icons.psychology,
              AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternItem(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection(Map<String, dynamic> stats, dynamic onboardingData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecommendationItem(
              'Complete Daily Goals',
              'Try to complete at least one lesson per day to maintain momentum',
              Icons.today,
              AppTheme.successColor,
            ),
            const SizedBox(height: 8),
            _buildRecommendationItem(
              'Review Previous Content',
              'Revisit completed lessons to reinforce your learning',
              Icons.refresh,
              AppTheme.infoColor,
            ),
            const SizedBox(height: 8),
            _buildRecommendationItem(
              'Take Practice Quizzes',
              'Test your knowledge with additional practice questions',
              Icons.quiz,
              AppTheme.warningColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparativeAnalysisSection(Map<String, dynamic> stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comparative Analysis',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildComparisonItem(
              'Your Progress vs Average',
              'You\'re performing 15% above average',
              Icons.trending_up,
              AppTheme.successColor,
              0.75,
            ),
            const SizedBox(height: 12),
            _buildComparisonItem(
              'Quiz Performance vs Peers',
              'Your quiz scores are in the top 25%',
              Icons.star,
              AppTheme.warningColor,
              0.85,
            ),
            const SizedBox(height: 12),
            _buildComparisonItem(
              'Learning Consistency',
              'You\'re more consistent than 60% of users',
              Icons.schedule,
              AppTheme.infoColor,
              0.60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonItem(String title, String description, IconData icon, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}