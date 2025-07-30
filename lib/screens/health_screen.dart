import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import 'lesson_screen.dart';
import '../services/progress_tracking_service.dart';
import '../services/auth_service.dart';
import '../services/simple_onboarding_service.dart';

class HealthScreen extends ConsumerStatefulWidget {
  const HealthScreen({super.key});

  @override
  ConsumerState<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends ConsumerState<HealthScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // Map UI module titles to lesson moduleIds
  String _getModuleId(String title) {
    switch (title) {
      case 'Nutrition Basics':
        return 'nutrition';
      case 'Home Workouts':
        return 'fitness';
      case 'Sleep & Recovery':
        return 'sleep';
      case 'Mental Wellness':
        return 'mental';
      default:
        return 'nutrition'; // fallback
    }
  }

  void _navigateToLesson(String moduleTitle) {
    final moduleId = _getModuleId(moduleTitle);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(
          moduleId: moduleId,
          moduleTitle: moduleTitle,
          category: 'health',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: AppTheme.healthColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Health Journey',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your path to better wellness',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            
            // Tab Bar
            TabBar(
              controller: _tabController,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppTheme.healthColor,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Learn'),
                Tab(text: 'Progress'),
                Tab(text: 'Track'),
                Tab(text: 'Tips'),
              ],
            ),
            
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLearnTab(),
                  _buildProgressTab(),
                  _buildTrackTab(),
                  _buildTipsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearnTab() {
    final authService = AuthService();
    final user = authService.currentUser;
    
    if (user == null) {
      return const Center(child: Text('Please log in to view your progress'));
    }

    return Consumer(
      builder: (context, ref, child) {
        final moduleProgressAsync = ref.watch(moduleProgressProvider(user.id));
        final onboardingData = ref.watch(onboardingDataProvider);
        
        return moduleProgressAsync.when(
          data: (allModuleProgress) {
            final healthModules = allModuleProgress.where((m) => m.category == 'health').toList();
            
            // Get personalized module order and recommendations
            final personalizedModules = _getPersonalizedHealthModules(healthModules, onboardingData);
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: personalizedModules.length + (onboardingData != null ? 1 : 0),
              itemBuilder: (context, index) {
                // Show personalized welcome message if onboarding data exists
                if (onboardingData != null && index == 0) {
                  return _buildPersonalizedWelcomeCard(onboardingData);
                }
                
                final moduleIndex = onboardingData != null ? index - 1 : index;
                final module = personalizedModules[moduleIndex];
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              module['icon'] as IconData,
                              color: module['color'] as Color,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                module['title'] as String,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            if (module['recommended'] == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.healthColor.withValues(alpha: 0.1),
                                  border: Border.all(
                                    color: AppTheme.healthColor.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Recommended',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.healthColor,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: (module['color'] as Color).withValues(alpha: 0.1),
                                border: Border.all(
                                  color: (module['color'] as Color).withValues(alpha: 0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '${module['lessons']} lessons',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          module['description'] as String,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (module['personalizedTip'] != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.healthColor.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.healthColor.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline,
                                  size: 16,
                                  color: AppTheme.healthColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    module['personalizedTip'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.healthColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text('Progress'),
                            const Spacer(),
                            Text('${module['progress']}%'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: (module['progress'] as int) / 100,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _navigateToLesson(module['title'] as String),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(module['recommended'] == true ? 'Start Recommended' : 'Continue Learning'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error loading progress: $error')),
        );
      },
    );
  }

  int _getModuleProgress(List<ModuleProgress> healthModules, String moduleId) {
    final moduleProgress = healthModules.where((m) => m.moduleId == moduleId).firstOrNull;
    if (moduleProgress == null) return 0;
    return (moduleProgress.overallProgress * 100).round();
  }

  List<Map<String, dynamic>> _getPersonalizedHealthModules(List<ModuleProgress> healthModules, onboardingData) {
    final baseModules = [
      {
        'title': 'Nutrition Basics',
        'moduleId': 'nutrition',
        'icon': Icons.restaurant,
        'color': Colors.green,
        'description': 'Learn about balanced eating and meal planning',
        'progress': _getModuleProgress(healthModules, 'nutrition'),
        'lessons': ProgressTrackingService.moduleLessonCounts['nutrition'] ?? 3,
        'recommended': false,
        'personalizedTip': null,
      },
      {
        'title': 'Home Workouts',
        'moduleId': 'fitness',
        'icon': Icons.fitness_center,
        'color': Colors.orange,
        'description': 'Exercise routines you can do anywhere',
        'progress': _getModuleProgress(healthModules, 'fitness'),
        'lessons': ProgressTrackingService.moduleLessonCounts['fitness'] ?? 2,
        'recommended': false,
        'personalizedTip': null,
      },
      {
        'title': 'Sleep & Recovery',
        'moduleId': 'sleep',
        'icon': Icons.bedtime,
        'color': Colors.blue,
        'description': 'Master the science of quality sleep',
        'progress': _getModuleProgress(healthModules, 'sleep'),
        'lessons': ProgressTrackingService.moduleLessonCounts['sleep'] ?? 4,
        'recommended': false,
        'personalizedTip': null,
      },
      {
        'title': 'Mental Wellness',
        'moduleId': 'mental',
        'icon': Icons.psychology,
        'color': AppTheme.purpleColor,
        'description': 'Build resilience and emotional intelligence',
        'progress': _getModuleProgress(healthModules, 'mental'),
        'lessons': ProgressTrackingService.moduleLessonCounts['mental'] ?? 4,
        'recommended': false,
        'personalizedTip': null,
      },
    ];

    if (onboardingData != null) {
      final service = SimpleOnboardingService();
      final recommendedModules = service.getRecommendedModules(onboardingData);
      
      // Mark recommended modules and add personalized tips
      for (var module in baseModules) {
        final moduleId = module['moduleId'] as String;
        if (recommendedModules.contains(moduleId)) {
          module['recommended'] = true;
          module['personalizedTip'] = _getPersonalizedTip(moduleId, onboardingData);
        }
      }
      
      // Sort modules: recommended first, then by progress
      baseModules.sort((a, b) {
        if (a['recommended'] == true && b['recommended'] != true) return -1;
        if (b['recommended'] == true && a['recommended'] != true) return 1;
        return (b['progress'] as int).compareTo(a['progress'] as int);
      });
    }

    return baseModules;
  }

  String? _getPersonalizedTip(String moduleId, onboardingData) {
    if (onboardingData == null) return null;
    
    switch (moduleId) {
      case 'nutrition':
        if (onboardingData.healthGoal.contains('Weight')) {
          return 'Perfect for your weight management goals!';
        }
        return 'Great foundation for overall health improvement';
      case 'fitness':
        if (onboardingData.experienceLevel == 'Beginner') {
          return 'Start with basic exercises and build gradually';
        }
        return 'Enhance your fitness routine with structured workouts';
      case 'sleep':
        if (onboardingData.healthGoal.contains('Sleep')) {
          return 'Directly aligned with your sleep improvement goals';
        }
        return 'Quality sleep supports all your health goals';
      case 'mental':
        if (onboardingData.healthGoal.contains('Mental') || onboardingData.interests.contains('Mental Health')) {
          return 'Essential for your mental wellness journey';
        }
        return 'Mental wellness enhances all aspects of life';
      default:
        return null;
    }
  }

  Widget _buildPersonalizedWelcomeCard(onboardingData) {
    final service = SimpleOnboardingService();
    final personalizedContent = service.generatePersonalizedContent(onboardingData);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppTheme.healthColor.withValues(alpha: 0.1),
              AppTheme.healthColor.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: AppTheme.healthColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your Health Journey',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.healthColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                personalizedContent['welcomeMessage'] as String,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              if (personalizedContent['customTips'] != null) ...[
                Text(
                  'Personalized Tips:',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.healthColor,
                  ),
                ),
                const SizedBox(height: 8),
                ...(personalizedContent['customTips'] as List<String>).take(2).map(
                  (tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: AppTheme.healthColor)),
                        Expanded(
                          child: Text(
                            tip,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressTab() {
    final authService = AuthService();
    final user = authService.currentUser;
    
    if (user == null) {
      return const Center(child: Text('Please log in to view your progress'));
    }

    return Consumer(
      builder: (context, ref, child) {
        final overallStatsAsync = ref.watch(overallStatsProvider(user.id));
        final moduleProgressAsync = ref.watch(moduleProgressProvider(user.id));
        
        return overallStatsAsync.when(
          data: (stats) {
            return moduleProgressAsync.when(
              data: (allModuleProgress) {
                final healthModules = allModuleProgress.where((m) => m.category == 'health').toList();
                
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Overall Progress Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overall Health Progress',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Lessons Completed'),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${stats['completedLessons']} / ${stats['totalModules']}',
                                          style: Theme.of(context).textTheme.headlineSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Quizzes Passed'),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${stats['passedQuizzes']} / ${stats['completedQuizzes']}',
                                          style: Theme.of(context).textTheme.headlineSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              LinearProgressIndicator(
                                value: (stats['healthProgress'] as double? ?? 0.0),
                                backgroundColor: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 8),
                              Text('${((stats['healthProgress'] as double? ?? 0.0) * 100).round()}% Complete'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Module Progress
                      Text(
                        'Module Progress',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ...healthModules.map((module) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircularProgressIndicator(
                            value: module.overallProgress,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          title: Text(_getModuleTitle(module.moduleId)),
                          subtitle: Text(module.lessonCompleted ? 'Lesson completed' : 'Lesson in progress'),
                          trailing: Text('${(module.overallProgress * 100).round()}%'),
                        ),
                      )),
                      
                      const SizedBox(height: 16),
                      
                      // Recent Activity
                      Text(
                        'Recent Activity',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Column(
                          children: [
                            if ((stats['completedLessons'] as int? ?? 0) > 0)
                              ListTile(
                                leading: const Icon(Icons.check_circle, color: Colors.green),
                                title: Text('Completed ${stats['completedLessons']} lessons'),
                                subtitle: const Text('Keep up the great work!'),
                              ),
                            if ((stats['passedQuizzes'] as int? ?? 0) > 0)
                              ListTile(
                                leading: const Icon(Icons.quiz, color: Colors.blue),
                                title: Text('Passed ${stats['passedQuizzes']} quizzes'),
                                subtitle: const Text('Excellent progress!'),
                              ),
                            if (healthModules.where((m) => m.lessonCompleted).isNotEmpty)
                              const ListTile(
                                leading: Icon(Icons.star, color: Colors.orange),
                                title: Text('Making great progress!'),
                                subtitle: Text('You\'re doing amazing!'),
                              ),
                            if ((stats['completedLessons'] as int? ?? 0) == 0 && (stats['passedQuizzes'] as int? ?? 0) == 0)
                              const ListTile(
                                leading: Icon(Icons.info, color: Colors.blue),
                                title: Text('Start your health journey'),
                                subtitle: Text('Complete your first lesson to see progress here'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error loading module progress: $error')),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error loading stats: $error')),
        );
      },
    );
  }

  String _getModuleTitle(String moduleId) {
    switch (moduleId) {
      case 'nutrition':
        return 'Nutrition Basics';
      case 'fitness':
        return 'Home Workouts';
      case 'sleep':
        return 'Sleep & Recovery';
      case 'mental':
        return 'Mental Wellness';
      default:
        return moduleId;
    }
  }

  Widget _buildTrackTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Tracker Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildTrackerCard('💧', 'Water', '6 glasses', 'Goal: 8 glasses'),
              _buildTrackerCard('👟', 'Steps', '8,500', 'Goal: 10,000'),
              _buildTrackerCard('😴', 'Sleep', '7.5h', 'Goal: 7-8 hours'),
              _buildTrackerCard('😊', 'Mood', '4/5', 'How are you feeling?'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Food Journal
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Journal',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'What did you eat?',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFoodEntry('🍳 Breakfast: Oats with fruits', '350 cal'),
                  _buildFoodEntry('🥗 Lunch: Chicken salad', '420 cal'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerCard(String emoji, String title, String value, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodEntry(String food, String calories) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(food, style: const TextStyle(fontSize: 14)),
          Text(
            calories,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    final tips = [
      "💡 Drink a glass of water first thing in the morning to kickstart your metabolism",
      "🥗 Try to fill half your plate with vegetables at lunch and dinner",
      "🚶 Take a 10-minute walk after meals to improve digestion",
      "😴 Keep your bedroom cool (65-68°F) for better sleep quality",
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tips.length + 1,
      itemBuilder: (context, index) {
        if (index < tips.length) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(tips[index]),
            ),
          );
        } else {
          // Weekly Challenges section
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Challenges',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildChallengeItem('🥛', 'Hydration Hero', 'Drink 8 glasses daily for 7 days', 4, 7),
                  const SizedBox(height: 12),
                  _buildChallengeItem('🚶', 'Step Master', '10,000 steps for 5 days', 2, 5),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChallengeItem(String emoji, String title, String description, int current, int total) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$current/$total days', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              SizedBox(
                width: 60,
                child: LinearProgressIndicator(
                  value: current / total,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}