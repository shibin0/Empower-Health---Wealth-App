import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../screens/lesson_screen.dart';
import '../screens/health_screen.dart';
import '../screens/wealth_screen.dart';
import '../screens/detailed_progress_screen.dart';
import '../services/progress_tracking_service.dart';
import '../services/auth_service.dart';
import '../services/simple_onboarding_service.dart';

class PersonalizedQuickActionsCard extends ConsumerWidget {
  const PersonalizedQuickActionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = AuthService();
    final user = authService.currentUser;
    final onboardingData = ref.watch(onboardingDataProvider);
    
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, child) {
        final moduleProgressAsync = ref.watch(moduleProgressProvider(user.id));
        
        return moduleProgressAsync.when(
          data: (allModuleProgress) {
            final personalizedActions = _getPersonalizedActions(
              context, 
              ref, 
              allModuleProgress, 
              onboardingData
            );
            
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
                            Icons.auto_awesome,
                            size: AppTheme.spacing5,
                            color: AppTheme.purpleColor,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recommended for You',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (onboardingData != null)
                                Text(
                                  'Based on your goals and progress',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    
                    // Personalized Actions Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: AppTheme.spacing3,
                      mainAxisSpacing: AppTheme.spacing3,
                      childAspectRatio: 1.1,
                      children: personalizedActions,
                    ),
                    
                    // Quick Tips Section
                    if (onboardingData != null) ...[
                      const SizedBox(height: AppTheme.spacing4),
                      const Divider(),
                      const SizedBox(height: AppTheme.spacing3),
                      _buildQuickTipsSection(context, onboardingData),
                    ],
                  ],
                ),
              ),
            );
          },
          loading: () => const Card(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.spacing4),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          error: (error, stack) => Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing4),
              child: Text('Error loading recommendations: $error'),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _getPersonalizedActions(
    BuildContext context,
    WidgetRef ref,
    List<ModuleProgress> allModuleProgress,
    dynamic onboardingData,
  ) {
    final actions = <Widget>[];
    
    if (onboardingData != null) {
      final service = SimpleOnboardingService();
      final recommendedModules = service.getRecommendedModules(onboardingData);
      
      // Add recommended health module
      final healthModules = allModuleProgress.where((m) => m.category == 'health').toList();
      final recommendedHealthModule = _getRecommendedModule(healthModules, recommendedModules, 'health');
      if (recommendedHealthModule != null) {
        actions.add(_buildPersonalizedAction(
          context,
          icon: Icons.favorite,
          iconColor: AppTheme.healthColor,
          label: _getModuleDisplayName(recommendedHealthModule['moduleId']),
          subtitle: 'Recommended',
          progress: recommendedHealthModule['progress'],
          onTap: () => _navigateToLesson(
            context, 
            recommendedHealthModule['moduleId'], 
            _getModuleDisplayName(recommendedHealthModule['moduleId']), 
            'health'
          ),
        ));
      }
      
      // Add recommended wealth module
      final wealthModules = allModuleProgress.where((m) => m.category == 'wealth').toList();
      final recommendedWealthModule = _getRecommendedModule(wealthModules, recommendedModules, 'wealth');
      if (recommendedWealthModule != null) {
        actions.add(_buildPersonalizedAction(
          context,
          icon: Icons.attach_money,
          iconColor: AppTheme.wealthColor,
          label: _getModuleDisplayName(recommendedWealthModule['moduleId']),
          subtitle: 'Recommended',
          progress: recommendedWealthModule['progress'],
          onTap: () => _navigateToLesson(
            context, 
            recommendedWealthModule['moduleId'], 
            _getModuleDisplayName(recommendedWealthModule['moduleId']), 
            'wealth'
          ),
        ));
      }
    }
    
    // Add next best action based on progress
    final nextBestAction = _getNextBestAction(context, allModuleProgress);
    if (nextBestAction != null) {
      actions.add(nextBestAction);
    }
    
    // Add progress tracking
    actions.add(_buildPersonalizedAction(
      context,
      icon: Icons.analytics,
      iconColor: AppTheme.purpleColor,
      label: 'View Analytics',
      subtitle: 'Track your journey',
      onTap: () => _navigateToProgress(context, ref),
    ));
    
    // Fill remaining slots with default actions if needed
    while (actions.length < 4) {
      if (actions.length == 2) {
        actions.add(_buildPersonalizedAction(
          context,
          icon: Icons.quiz,
          iconColor: AppTheme.infoColor,
          label: 'Take Quiz',
          subtitle: 'Test knowledge',
          onTap: () => _navigateToQuiz(context),
        ));
      } else {
        actions.add(_buildPersonalizedAction(
          context,
          icon: Icons.explore,
          iconColor: AppTheme.successColor,
          label: 'Explore More',
          subtitle: 'Discover content',
          onTap: () => _navigateToExplore(context),
        ));
      }
    }
    
    return actions.take(4).toList();
  }

  Map<String, dynamic>? _getRecommendedModule(
    List<ModuleProgress> modules, 
    List<String> recommendedModules, 
    String category
  ) {
    for (final moduleId in recommendedModules) {
      final moduleProgress = modules.where((m) => m.moduleId == moduleId).firstOrNull;
      if (moduleProgress != null) {
        return {
          'moduleId': moduleId,
          'progress': (moduleProgress.overallProgress * 100).round(),
        };
      }
    }
    
    // Fallback to first module in category
    if (modules.isNotEmpty) {
      final firstModule = modules.first;
      return {
        'moduleId': firstModule.moduleId,
        'progress': (firstModule.overallProgress * 100).round(),
      };
    }
    
    return null;
  }

  Widget? _getNextBestAction(BuildContext context, List<ModuleProgress> allModuleProgress) {
    // Find module with highest progress that's not completed
    ModuleProgress? bestModule;
    double highestProgress = 0;
    
    for (final module in allModuleProgress) {
      if (module.overallProgress > highestProgress && module.overallProgress < 1.0) {
        highestProgress = module.overallProgress;
        bestModule = module;
      }
    }
    
    if (bestModule != null) {
      return _buildPersonalizedAction(
        context,
        icon: bestModule.category == 'health' ? Icons.favorite : Icons.attach_money,
        iconColor: bestModule.category == 'health' ? AppTheme.healthColor : AppTheme.wealthColor,
        label: 'Continue ${_getModuleDisplayName(bestModule.moduleId)}',
        subtitle: '${(bestModule.overallProgress * 100).round()}% complete',
        progress: (bestModule.overallProgress * 100).round(),
        onTap: () => _navigateToLesson(
          context,
          bestModule!.moduleId,
          _getModuleDisplayName(bestModule.moduleId),
          bestModule.category
        ),
      );
    }
    
    return null;
  }

  Widget _buildQuickTipsSection(BuildContext context, dynamic onboardingData) {
    final service = SimpleOnboardingService();
    final personalizedContent = service.generatePersonalizedContent(onboardingData);
    final tips = personalizedContent['customTips'] as List<String>? ?? [];
    
    if (tips.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lightbulb_outline, size: 16, color: AppTheme.warningColor),
            const SizedBox(width: AppTheme.spacing2),
            Text(
              'Quick Tips for You',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppTheme.warningColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing2),
        ...tips.take(2).map((tip) => Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacing1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(color: AppTheme.warningColor)),
              Expanded(
                child: Text(
                  tip,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildPersonalizedAction(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    String? subtitle,
    int? progress,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(AppTheme.spacing3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        side: BorderSide(
          color: iconColor.withValues(alpha: 0.3),
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
              size: 20,
            ),
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (progress != null && progress > 0) ...[
            const SizedBox(height: AppTheme.spacing1),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(iconColor),
            ),
          ],
        ],
      ),
    );
  }

  String _getModuleDisplayName(String moduleId) {
    switch (moduleId) {
      case 'nutrition':
        return 'Nutrition Basics';
      case 'exercise':
        return 'Exercise & Fitness';
      case 'sleep':
        return 'Sleep Hygiene';
      case 'mental':
        return 'Mental Wellness';
      case 'budgeting':
        return 'Smart Budgeting';
      case 'investing':
        return 'Investment Basics';
      case 'credit':
        return 'Credit & Loans';
      case 'insurance':
        return 'Insurance Planning';
      default:
        return moduleId;
    }
  }

  void _navigateToLesson(BuildContext context, String moduleId, String moduleTitle, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(
          moduleId: moduleId,
          moduleTitle: moduleTitle,
          category: category,
        ),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context) {
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailedProgressScreen(),
      ),
    );
  }

  void _navigateToExplore(BuildContext context) {
    // Navigate to health or wealth screen for exploration
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Explore Content'),
          content: const Text('What would you like to explore?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HealthScreen(),
                  ),
                );
              },
              child: const Text('Health'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WealthScreen(),
                  ),
                );
              },
              child: const Text('Wealth'),
            ),
          ],
        );
      },
    );
  }
}