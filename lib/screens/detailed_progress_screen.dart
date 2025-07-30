import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../services/progress_tracking_service.dart';
import '../services/auth_service.dart';

class DetailedProgressScreen extends ConsumerWidget {
  const DetailedProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = AuthService();
    final userId = authService.currentUser?.id ?? 'demo_user';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Stats Card
            _buildOverallStatsCard(ref, userId),
            const SizedBox(height: AppTheme.spacing4),
            
            // Module Progress Section
            _buildModuleProgressSection(ref, userId),
            const SizedBox(height: AppTheme.spacing4),
            
            // Achievements Section
            _buildAchievementsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallStatsCard(WidgetRef ref, String userId) {
    final overallStatsAsync = ref.watch(overallStatsProvider(userId));
    
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
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: const Icon(
                    Icons.analytics,
                    color: AppTheme.primaryColor,
                    size: AppTheme.spacing5,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                const Text(
                  'Overall Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            overallStatsAsync.when(
              data: (stats) => _buildStatsContent(stats),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Text(
                'Error loading stats: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsContent(Map<String, dynamic> stats) {
    final overallProgress = (stats['overallProgress'] * 100).round();
    final healthProgress = (stats['healthProgress'] * 100).round();
    final wealthProgress = (stats['wealthProgress'] * 100).round();
    
    return Column(
      children: [
        // Overall Progress Bar
        _buildProgressItem(
          '🎯 Total Progress',
          overallProgress,
          AppTheme.primaryColor,
        ),
        const SizedBox(height: AppTheme.spacing3),
        
        // Health Progress Bar
        _buildProgressItem(
          '🏥 Health Modules',
          healthProgress,
          AppTheme.healthColor,
        ),
        const SizedBox(height: AppTheme.spacing3),
        
        // Wealth Progress Bar
        _buildProgressItem(
          '💰 Wealth Modules',
          wealthProgress,
          AppTheme.wealthColor,
        ),
        const SizedBox(height: AppTheme.spacing4),
        
        // Stats Grid
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Lessons\nCompleted',
                '${stats['completedLessons']}/${stats['totalModules']}',
                Icons.school,
                AppTheme.successColor,
              ),
            ),
            const SizedBox(width: AppTheme.spacing3),
            Expanded(
              child: _buildStatCard(
                'Quizzes\nPassed',
                '${stats['passedQuizzes']}/${stats['completedQuizzes']}',
                Icons.quiz,
                AppTheme.infoColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressItem(String label, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing2),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: color.withValues(alpha: 0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: AppTheme.spacing6,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppTheme.spacing1),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleProgressSection(WidgetRef ref, String userId) {
    final moduleProgressAsync = ref.watch(moduleProgressProvider(userId));
    
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
                    Icons.library_books,
                    color: AppTheme.infoColor,
                    size: AppTheme.spacing5,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                const Text(
                  'Module Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            moduleProgressAsync.when(
              data: (modules) => _buildModulesList(modules),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Text(
                'Error loading modules: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesList(List<ModuleProgress> modules) {
    // Group modules by category
    final healthModules = modules.where((m) => m.category == 'health').toList();
    final wealthModules = modules.where((m) => m.category == 'wealth').toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Health Modules
        _buildCategorySection('🏥 Health Modules', healthModules, AppTheme.healthColor),
        const SizedBox(height: AppTheme.spacing4),
        
        // Wealth Modules
        _buildCategorySection('💰 Wealth Modules', wealthModules, AppTheme.wealthColor),
      ],
    );
  }

  Widget _buildCategorySection(String title, List<ModuleProgress> modules, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: AppTheme.spacing3),
        ...modules.map((module) => _buildModuleItem(module, color)),
      ],
    );
  }

  Widget _buildModuleItem(ModuleProgress module, Color categoryColor) {
    final progressPercentage = (module.overallProgress * 100).round();
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing3),
      padding: const EdgeInsets.all(AppTheme.spacing3),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: categoryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  module.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                '$progressPercentage%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing2),
          LinearProgressIndicator(
            value: module.overallProgress,
            backgroundColor: categoryColor.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
            minHeight: 6,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Row(
            children: [
              _buildStatusChip(
                module.lessonCompleted ? 'Lesson ✓' : 'Lesson',
                module.lessonCompleted ? AppTheme.successColor : Colors.grey,
              ),
              const SizedBox(width: AppTheme.spacing2),
              _buildStatusChip(
                module.quizPassed ? 'Quiz ✓' : (module.quizCompleted ? 'Quiz ✗' : 'Quiz'),
                module.quizPassed ? AppTheme.successColor : 
                (module.quizCompleted ? AppTheme.errorColor : Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing2,
        vertical: AppTheme.spacing1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
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
                    color: AppTheme.warningColor,
                    size: AppTheme.spacing5,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing3),
                const Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            const Text(
              'Keep learning to unlock achievements! Complete lessons and pass quizzes to earn badges and XP.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: AppTheme.spacing3),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing3),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.warningColor,
                  ),
                  SizedBox(width: AppTheme.spacing2),
                  Expanded(
                    child: Text(
                      'Achievement system will be enhanced in the next update with detailed badges and rewards!',
                      style: TextStyle(
                        color: AppTheme.warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}