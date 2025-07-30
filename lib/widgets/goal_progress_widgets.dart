import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';

// Goal Progress Models
class GoalProgress {
  final String id;
  final String title;
  final String description;
  final String category; // 'health' or 'wealth'
  final double currentProgress; // 0.0 to 1.0
  final double targetValue;
  final double currentValue;
  final String unit;
  final DateTime targetDate;
  final DateTime createdAt;
  final List<GoalMilestone> milestones;
  final bool isCompleted;
  final Color color;
  final IconData icon;

  GoalProgress({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.currentProgress,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
    required this.targetDate,
    required this.createdAt,
    required this.milestones,
    required this.isCompleted,
    required this.color,
    required this.icon,
  });
}

class GoalMilestone {
  final String id;
  final String title;
  final double progressThreshold; // 0.0 to 1.0
  final bool isCompleted;
  final DateTime? completedAt;
  final String reward;

  GoalMilestone({
    required this.id,
    required this.title,
    required this.progressThreshold,
    required this.isCompleted,
    this.completedAt,
    required this.reward,
  });
}

// Goal Progress Card Widget
class GoalProgressCard extends ConsumerWidget {
  final GoalProgress goal;
  final VoidCallback? onTap;
  final bool showDetails;

  const GoalProgressCard({
    super.key,
    required this.goal,
    this.onTap,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: goal.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      goal.icon,
                      color: goal.color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (showDetails) ...[
                          const SizedBox(height: 4),
                          Text(
                            goal.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (goal.isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppTheme.successColor,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Completed',
                            style: TextStyle(
                              color: AppTheme.successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(goal.currentProgress * 100).toInt()}%',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: goal.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: goal.currentProgress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                    minHeight: 8,
                  ),
                ],
              ),
              
              if (showDetails) ...[
                const SizedBox(height: 16),
                
                // Current vs Target
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Current',
                        '${goal.currentValue.toStringAsFixed(1)} ${goal.unit}',
                        goal.color,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatItem(
                        'Target',
                        '${goal.targetValue.toStringAsFixed(1)} ${goal.unit}',
                        Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatItem(
                        'Days Left',
                        '${goal.targetDate.difference(DateTime.now()).inDays}',
                        AppTheme.warningColor,
                      ),
                    ),
                  ],
                ),
                
                // Milestones
                if (goal.milestones.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Milestones',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...goal.milestones.take(3).map((milestone) => 
                    _buildMilestoneItem(context, milestone, goal.color)
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneItem(BuildContext context, GoalMilestone milestone, Color goalColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: milestone.isCompleted 
            ? AppTheme.successColor.withValues(alpha: 0.1)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: milestone.isCompleted 
              ? AppTheme.successColor.withValues(alpha: 0.3)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            milestone.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: milestone.isCompleted ? AppTheme.successColor : Colors.grey.shade400,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: milestone.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  '${(milestone.progressThreshold * 100).toInt()}% • ${milestone.reward}',
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
}

// Compact Goal Progress Widget
class CompactGoalProgress extends StatelessWidget {
  final GoalProgress goal;
  final VoidCallback? onTap;

  const CompactGoalProgress({
    super.key,
    required this.goal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: goal.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: goal.color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(goal.icon, color: goal.color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: goal.currentProgress,
              backgroundColor: Colors.white.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(goal.color),
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(goal.currentProgress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: goal.color,
                  ),
                ),
                Text(
                  '${goal.targetDate.difference(DateTime.now()).inDays}d left',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Goal Progress Grid Widget
class GoalProgressGrid extends ConsumerWidget {
  final List<GoalProgress> goals;
  final Function(GoalProgress)? onGoalTap;

  const GoalProgressGrid({
    super.key,
    required this.goals,
    this.onGoalTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (goals.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        return CompactGoalProgress(
          goal: goal,
          onTap: () => onGoalTap?.call(goal),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.flag_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Goals Set',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Set your first goal to start tracking your progress',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to goal creation
            },
            icon: const Icon(Icons.add),
            label: const Text('Set Goal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Goal Category Summary Widget
class GoalCategorySummary extends StatelessWidget {
  final String category;
  final List<GoalProgress> goals;
  final Color categoryColor;
  final IconData categoryIcon;

  const GoalCategorySummary({
    super.key,
    required this.category,
    required this.goals,
    required this.categoryColor,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    final completedGoals = goals.where((g) => g.isCompleted).length;
    final averageProgress = goals.isEmpty 
        ? 0.0 
        : goals.map((g) => g.currentProgress).reduce((a, b) => a + b) / goals.length;

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
                    color: categoryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    categoryIcon,
                    color: categoryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$category Goals',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$completedGoals of ${goals.length} completed',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(averageProgress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: averageProgress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
              minHeight: 8,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCategoryStat(
                    context,
                    'Active',
                    '${goals.where((g) => !g.isCompleted).length}',
                    AppTheme.infoColor,
                  ),
                ),
                Expanded(
                  child: _buildCategoryStat(
                    context,
                    'Completed',
                    '$completedGoals',
                    AppTheme.successColor,
                  ),
                ),
                Expanded(
                  child: _buildCategoryStat(
                    context,
                    'Avg Progress',
                    '${(averageProgress * 100).toInt()}%',
                    categoryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryStat(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// Goal Achievement Badge Widget
class GoalAchievementBadge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isEarned;
  final DateTime? earnedDate;

  const GoalAchievementBadge({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.isEarned,
    this.earnedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEarned 
            ? color.withValues(alpha: 0.1)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEarned 
              ? color.withValues(alpha: 0.3)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isEarned ? color : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isEarned ? color : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isEarned && earnedDate != null) ...[
            const SizedBox(height: 8),
            Text(
              'Earned ${_formatDate(earnedDate!)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    if (difference < 30) return '${(difference / 7).floor()} weeks ago';
    return '${(difference / 30).floor()} months ago';
  }
}

// Goal Progress Timeline Widget
class GoalProgressTimeline extends StatelessWidget {
  final List<GoalProgress> goals;

  const GoalProgressTimeline({
    super.key,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    final sortedGoals = List<GoalProgress>.from(goals)
      ..sort((a, b) => a.targetDate.compareTo(b.targetDate));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal Timeline',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...sortedGoals.map((goal) => _buildTimelineItem(context, goal)),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, GoalProgress goal) {
    final daysLeft = goal.targetDate.difference(DateTime.now()).inDays;
    final isOverdue = daysLeft < 0;
    final isUpcoming = daysLeft <= 7 && daysLeft >= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: goal.isCompleted 
                      ? AppTheme.successColor
                      : isOverdue 
                          ? AppTheme.errorColor
                          : isUpcoming 
                              ? AppTheme.warningColor
                              : goal.color,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          const SizedBox(width: 16),
          
          // Goal info
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(goal.icon, color: goal.color, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          goal.title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (goal.isCompleted)
                        const Icon(Icons.check_circle, color: AppTheme.successColor, size: 16)
                      else if (isOverdue)
                        const Icon(Icons.warning, color: AppTheme.errorColor, size: 16)
                      else if (isUpcoming)
                        const Icon(Icons.schedule, color: AppTheme.warningColor, size: 16),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: goal.currentProgress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                    minHeight: 4,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(goal.currentProgress * 100).toInt()}% complete',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        goal.isCompleted 
                            ? 'Completed'
                            : isOverdue 
                                ? '${-daysLeft} days overdue'
                                : '$daysLeft days left',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: goal.isCompleted 
                              ? AppTheme.successColor
                              : isOverdue 
                                  ? AppTheme.errorColor
                                  : isUpcoming 
                                      ? AppTheme.warningColor
                                      : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Goal Quick Actions Widget
class GoalQuickActions extends StatelessWidget {
  final VoidCallback? onCreateGoal;
  final VoidCallback? onViewAllGoals;
  final VoidCallback? onViewAchievements;

  const GoalQuickActions({
    super.key,
    this.onCreateGoal,
    this.onViewAllGoals,
    this.onViewAchievements,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    'Create Goal',
                    Icons.add_circle_outline,
                    AppTheme.primaryColor,
                    onCreateGoal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    context,
                    'View All',
                    Icons.list,
                    AppTheme.infoColor,
                    onViewAllGoals,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    context,
                    'Achievements',
                    Icons.emoji_events,
                    AppTheme.warningColor,
                    onViewAchievements,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}