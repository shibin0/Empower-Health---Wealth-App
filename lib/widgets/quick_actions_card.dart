import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../screens/lesson_screen.dart';
import '../screens/detailed_progress_screen.dart';

class QuickActionsCard extends ConsumerWidget {
  const QuickActionsCard({super.key});

  // Navigation helper methods
  void _navigateToHealthLesson(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LessonScreen(
          moduleId: 'nutrition',
          moduleTitle: 'Nutrition Basics',
          category: 'health',
        ),
      ),
    );
  }

  void _navigateToWealthLesson(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LessonScreen(
          moduleId: 'budgeting',
          moduleTitle: 'Smart Budgeting',
          category: 'wealth',
        ),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context) {
    // Show a dialog to let user choose between health or wealth quiz
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Quiz Category'),
          content: const Text('Which type of quiz would you like to take?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LessonScreen(
                      moduleId: 'nutrition',
                      moduleTitle: 'Nutrition Basics',
                      category: 'health',
                    ),
                  ),
                );
              },
              child: const Text('Health Quiz'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LessonScreen(
                      moduleId: 'budgeting',
                      moduleTitle: 'Smart Budgeting',
                      category: 'wealth',
                    ),
                  ),
                );
              },
              child: const Text('Wealth Quiz'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToProgress(BuildContext context, WidgetRef ref) {
    // Navigate to detailed progress screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailedProgressScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing2),
                  decoration: BoxDecoration(
                    color: AppTheme.purpleColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: const Icon(
                    Icons.rocket_launch,
                    size: AppTheme.spacing5,
                    color: AppTheme.purpleColor,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                Text(
                  'Quick Start',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppTheme.spacing3,
              mainAxisSpacing: AppTheme.spacing3,
              childAspectRatio: 1.2,
              children: [
                _buildQuickAction(
                  context,
                  icon: Icons.favorite,
                  iconColor: AppTheme.healthColor,
                  label: 'Health Lesson',
                  onTap: () => _navigateToHealthLesson(context),
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.attach_money,
                  iconColor: AppTheme.wealthColor,
                  label: 'Wealth Lesson',
                  onTap: () => _navigateToWealthLesson(context),
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.quiz,
                  iconColor: AppTheme.infoColor,
                  label: 'Take Quiz',
                  onTap: () => _navigateToQuiz(context),
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.track_changes,
                  iconColor: AppTheme.purpleColor,
                  label: 'Track Progress',
                  onTap: () => _navigateToProgress(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing2),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: AppTheme.spacing6,
            ),
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}