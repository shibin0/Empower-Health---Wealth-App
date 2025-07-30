import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../widgets/goal_progress_widgets.dart';
import '../services/goal_tracking_service.dart';
import '../services/auth_service.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
        body: Center(child: Text('Please log in to view goals')),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('My Goals'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showCreateGoalDialog(context);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Create New Goal',
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
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Achievements'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(user.id),
          _buildActiveGoalsTab(user.id),
          _buildCompletedGoalsTab(user.id),
          _buildAchievementsTab(user.id),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final goalsAsync = ref.watch(userGoalsProvider(userId));
        final statsAsync = ref.watch(goalStatisticsProvider(userId));

        return goalsAsync.when(
          data: (goals) {
            return statsAsync.when(
              data: (stats) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Goal Statistics Cards
                      _buildGoalStatistics(stats),
                      const SizedBox(height: 24),

                      // Category Summary
                      _buildCategorySummary(goals),
                      const SizedBox(height: 24),

                      // Goals Due Soon
                      _buildGoalsDueSoon(userId),
                      const SizedBox(height: 24),

                      // Goal Timeline
                      GoalProgressTimeline(goals: goals.take(5).toList()),
                      const SizedBox(height: 24),

                      // Quick Actions
                      GoalQuickActions(
                        onCreateGoal: () => _showCreateGoalDialog(context),
                        onViewAllGoals: () => _tabController.animateTo(1),
                        onViewAchievements: () => _tabController.animateTo(3),
                      ),
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

  Widget _buildActiveGoalsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final activeGoalsAsync = ref.watch(activeGoalsProvider(userId));

        return activeGoalsAsync.when(
          data: (goals) {
            if (goals.isEmpty) {
              return _buildEmptyActiveGoals();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Goals (${goals.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...goals.map((goal) => GoalProgressCard(
                        goal: goal,
                        onTap: () => _showGoalDetails(context, goal),
                      )),
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

  Widget _buildCompletedGoalsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final completedGoalsAsync = ref.watch(completedGoalsProvider(userId));

        return completedGoalsAsync.when(
          data: (goals) {
            if (goals.isEmpty) {
              return _buildEmptyCompletedGoals();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Completed Goals (${goals.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...goals.map((goal) => GoalProgressCard(
                        goal: goal,
                        onTap: () => _showGoalDetails(context, goal),
                      )),
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

  Widget _buildAchievementsTab(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final achievementsAsync = ref.watch(goalAchievementsProvider(userId));

        return achievementsAsync.when(
          data: (achievements) {
            final earnedAchievements =
                achievements.where((a) => a.isEarned).toList();
            final unearnedAchievements =
                achievements.where((a) => !a.isEarned).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (earnedAchievements.isNotEmpty) ...[
                    Text(
                      'Earned Achievements (${earnedAchievements.length})',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: earnedAchievements.length,
                      itemBuilder: (context, index) =>
                          earnedAchievements[index],
                    ),
                    const SizedBox(height: 32),
                  ],
                  if (unearnedAchievements.isNotEmpty) ...[
                    Text(
                      'Available Achievements',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: unearnedAchievements.length,
                      itemBuilder: (context, index) =>
                          unearnedAchievements[index],
                    ),
                  ],
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

  Widget _buildGoalStatistics(Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal Statistics',
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
            _buildStatCard(
              'Total Goals',
              '${stats['totalGoals']}',
              Icons.flag,
              AppTheme.primaryColor,
              '${stats['activeGoals']} active',
            ),
            _buildStatCard(
              'Completed',
              '${stats['completedGoals']}',
              Icons.check_circle,
              AppTheme.successColor,
              '${((stats['completionRate'] ?? 0.0) * 100).toInt()}% completion rate',
            ),
            _buildStatCard(
              'Health Goals',
              '${stats['healthGoals']}',
              Icons.favorite,
              AppTheme.healthColor,
              '${((stats['healthProgress'] ?? 0.0) * 100).toInt()}% avg progress',
            ),
            _buildStatCard(
              'Wealth Goals',
              '${stats['wealthGoals']}',
              Icons.attach_money,
              AppTheme.wealthColor,
              '${((stats['wealthProgress'] ?? 0.0) * 100).toInt()}% avg progress',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
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

  Widget _buildCategorySummary(List<GoalProgress> goals) {
    final healthGoals = goals.where((g) => g.category == 'health').toList();
    final wealthGoals = goals.where((g) => g.category == 'wealth').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Summary',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        if (healthGoals.isNotEmpty)
          GoalCategorySummary(
            category: 'Health',
            goals: healthGoals,
            categoryColor: AppTheme.healthColor,
            categoryIcon: Icons.favorite,
          ),
        const SizedBox(height: 16),
        if (wealthGoals.isNotEmpty)
          GoalCategorySummary(
            category: 'Wealth',
            goals: wealthGoals,
            categoryColor: AppTheme.wealthColor,
            categoryIcon: Icons.attach_money,
          ),
      ],
    );
  }

  Widget _buildGoalsDueSoon(String userId) {
    return Consumer(
      builder: (context, ref, child) {
        final goalsDueSoonAsync = ref.watch(goalsDueSoonProvider(userId));

        return goalsDueSoonAsync.when(
          data: (goals) {
            if (goals.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.schedule,
                        color: AppTheme.warningColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Goals Due Soon',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.warningColor,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 16),
                        child: CompactGoalProgress(
                          goal: goals[index],
                          onTap: () => _showGoalDetails(context, goals[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildEmptyActiveGoals() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flag_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'No Active Goals',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Set your first goal to start tracking your progress and achievements',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showCreateGoalDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Your First Goal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCompletedGoals() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'No Completed Goals Yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Complete your active goals to see them here and earn achievements',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _tabController.animateTo(1),
              icon: const Icon(Icons.visibility),
              label: const Text('View Active Goals'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Goal'),
        content: const Text(
          'Goal creation feature will be implemented in the next update. '
          'For now, you can view and track the sample goals provided.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showGoalDetails(BuildContext context, GoalProgress goal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Goal header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: goal.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          goal.icon,
                          color: goal.color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              goal.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Progress section
                  Text(
                    'Progress',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: goal.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(goal.currentProgress * 100).toInt()}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: goal.color,
                                  ),
                            ),
                            Text(
                              '${goal.currentValue.toStringAsFixed(1)} / ${goal.targetValue.toStringAsFixed(1)} ${goal.unit}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: goal.currentProgress,
                          backgroundColor: Colors.white.withValues(alpha: 0.5),
                          valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                          minHeight: 12,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Milestones
                  if (goal.milestones.isNotEmpty) ...[
                    Text(
                      'Milestones',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ...goal.milestones.map((milestone) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: milestone.isCompleted
                                ? AppTheme.successColor.withValues(alpha: 0.1)
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: milestone.isCompleted
                                  ? AppTheme.successColor.withValues(alpha: 0.3)
                                  : Colors.grey.shade200,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                milestone.isCompleted
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: milestone.isCompleted
                                    ? AppTheme.successColor
                                    : Colors.grey.shade400,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      milestone.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            decoration: milestone.isCompleted
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(milestone.progressThreshold * 100).toInt()}% • ${milestone.reward}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                    ),
                                    if (milestone.isCompleted &&
                                        milestone.completedAt != null)
                                      Text(
                                        'Completed ${_formatDate(milestone.completedAt!)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppTheme.successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 32),
                  ],

                  // Goal info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailItem(
                                'Created',
                                _formatDate(goal.createdAt),
                                Icons.calendar_today,
                              ),
                            ),
                            Expanded(
                              child: _buildDetailItem(
                                'Target Date',
                                _formatDate(goal.targetDate),
                                Icons.event,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailItem(
                                'Category',
                                goal.category.toUpperCase(),
                                goal.category == 'health'
                                    ? Icons.favorite
                                    : Icons.attach_money,
                              ),
                            ),
                            Expanded(
                              child: _buildDetailItem(
                                'Status',
                                goal.isCompleted ? 'Completed' : 'Active',
                                goal.isCompleted
                                    ? Icons.check_circle
                                    : Icons.schedule,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action buttons
                  if (!goal.isCompleted) ...[
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Update progress functionality
                              Navigator.of(context).pop();
                              _showUpdateProgressDialog(context, goal);
                            },
                            icon: const Icon(Icons.trending_up),
                            label: const Text('Update Progress'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: goal.color,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Edit goal functionality
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit Goal'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: goal.color,
                              side: BorderSide(color: goal.color),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  void _showUpdateProgressDialog(BuildContext context, GoalProgress goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Progress'),
        content: Text(
          'Progress update feature will be implemented in the next update. '
          'Current progress: ${(goal.currentProgress * 100).toInt()}%',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference == -1) return 'Tomorrow';
    if (difference < 7 && difference > 0) return '$difference days ago';
    if (difference > -7 && difference < 0) return 'In ${-difference} days';
    if (difference < 30 && difference > 0) {
      return '${(difference / 7).floor()} weeks ago';
    }
    if (difference > -30 && difference < 0) {
      return 'In ${(-difference / 7).floor()} weeks';
    }

    // Default format for older dates
    return '${date.day}/${date.month}/${date.year}';
  }
}
