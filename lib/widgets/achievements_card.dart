import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/app_providers.dart';
import '../utils/app_theme.dart';

class AchievementsCard extends ConsumerWidget {
  const AchievementsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(achievementsSimpleProvider);
        
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
                    color: AppTheme.warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: AppTheme.spacing5,
                    color: AppTheme.warningColor,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                Text(
                  'Recent Achievements',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: achievements.map((achievement) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing1),
                  padding: const EdgeInsets.all(AppTheme.spacing3),
                  decoration: BoxDecoration(
                    color: achievement.earned
                      ? AppTheme.warningColorLight
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: achievement.earned
                      ? Border.all(color: AppTheme.warningColor.withValues(alpha: 0.2))
                      : null,
                  ),
                  child: Column(
                    children: [
                      Text(
                        achievement.icon,
                        style: TextStyle(
                          fontSize: AppTheme.fontSize2xl,
                          color: achievement.earned
                            ? null
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing1),
                      Text(
                        achievement.title,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: achievement.earned
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: achievement.earned ? FontWeight.w500 : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}