import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../utils/app_theme.dart';

class DailyTasksCard extends ConsumerWidget {
  const DailyTasksCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create some mock daily tasks for now
    final dailyTasks = [
      DailyTask(
        id: '1',
        title: 'Drink 8 glasses of water',
        type: 'health',
        completed: false,
      ),
      DailyTask(
        id: '2',
        title: 'Review budget',
        type: 'wealth',
        completed: true,
      ),
      DailyTask(
        id: '3',
        title: 'Take a 30-minute walk',
        type: 'health',
        completed: false,
      ),
    ];

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
                    color: AppTheme.infoColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    size: AppTheme.spacing5,
                    color: AppTheme.infoColor,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                Text(
                  'Today\'s Tasks',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            ...dailyTasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing3),
              child: InkWell(
                onTap: () {
                  // TODO: Implement task completion with Riverpod
                },
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacing2),
                  child: Row(
                    children: [
                      Container(
                        width: AppTheme.spacing5,
                        height: AppTheme.spacing5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: task.completed
                              ? AppTheme.successColor
                              : Theme.of(context).colorScheme.outline,
                            width: 2,
                          ),
                          color: task.completed ? AppTheme.successColor : null,
                        ),
                        child: task.completed
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: AppTheme.fontSizeSm,
                            )
                          : null,
                      ),
                      const SizedBox(width: AppTheme.spacing3),
                      Expanded(
                        child: Text(
                          task.title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: task.completed
                              ? TextDecoration.lineThrough
                              : null,
                            color: task.completed
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing2,
                          vertical: AppTheme.spacing1,
                        ),
                        decoration: BoxDecoration(
                          color: task.type == 'health'
                            ? AppTheme.healthColorLight
                            : AppTheme.wealthColorLight,
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              task.type == 'health'
                                ? Icons.favorite
                                : Icons.attach_money,
                              color: task.type == 'health'
                                ? AppTheme.healthColor
                                : AppTheme.wealthColor,
                              size: AppTheme.fontSizeXs,
                            ),
                            const SizedBox(width: AppTheme.spacing1),
                            Text(
                              task.type,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: task.type == 'health'
                                  ? AppTheme.healthColor
                                  : AppTheme.wealthColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}