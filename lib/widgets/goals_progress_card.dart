import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/app_providers.dart';
import '../utils/app_theme.dart';

class GoalsProgressCard extends ConsumerWidget {
  const GoalsProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileSimpleProvider);

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
                    Icons.flag,
                    size: AppTheme.spacing5,
                    color: AppTheme.purpleColor,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                Text(
                  'Your Goals',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),

            // Health Goal
            _buildGoalItem(
              context,
              icon: Icons.favorite,
              iconColor: AppTheme.healthColor,
              title: userProfile?.healthGoal ?? 'Set your health goal',
              progress: 0.4,
              progressText: '40%',
            ),
            const SizedBox(height: AppTheme.spacing4),

            // Wealth Goal
            _buildGoalItem(
              context,
              icon: Icons.attach_money,
              iconColor: AppTheme.wealthColor,
              title: userProfile?.wealthGoal ?? 'Set your wealth goal',
              progress: 0.6,
              progressText: '60%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required double progress,
    required String progressText,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing3),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: AppTheme.spacing4,
              ),
              const SizedBox(width: AppTheme.spacing2),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing2,
                  vertical: AppTheme.spacing1,
                ),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Text(
                  progressText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: iconColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing2),
          LinearProgressIndicator(
            value: progress,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(iconColor),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
        ],
      ),
    );
  }
}
