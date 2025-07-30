import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import 'lesson_screen.dart';
import '../services/progress_tracking_service.dart';
import '../services/auth_service.dart';
import '../services/simple_onboarding_service.dart';

class WealthScreen extends ConsumerStatefulWidget {
  const WealthScreen({super.key});

  @override
  ConsumerState<WealthScreen> createState() => _WealthScreenState();
}

class _WealthScreenState extends ConsumerState<WealthScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // Map UI module titles to lesson moduleIds
  String _getModuleId(String title) {
    switch (title) {
      case 'Smart Budgeting':
        return 'budgeting';
      case 'Investment Basics':
        return 'investing';
      case 'Credit & Loans':
        return 'credit';
      case 'Insurance Planning':
        return 'insurance';
      default:
        return 'budgeting'; // fallback
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
          category: 'wealth',
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
                        Icons.attach_money,
                        color: AppTheme.wealthColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Wealth Journey',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Build your financial future',
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
              indicatorColor: AppTheme.wealthColor,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Learn'),
                Tab(text: 'Progress'),
                Tab(text: 'Budget'),
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
                  _buildBudgetTab(),
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
            final wealthModules = allModuleProgress.where((m) => m.category == 'wealth').toList();
            
            // Get personalized module order and recommendations
            final personalizedModules = _getPersonalizedWealthModules(wealthModules, onboardingData);
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: personalizedModules.length + (onboardingData != null ? 1 : 0),
              itemBuilder: (context, index) {
                // Show personalized welcome message if onboarding data exists
                if (onboardingData != null && index == 0) {
                  return _buildPersonalizedWealthWelcomeCard(onboardingData);
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
                                  color: AppTheme.wealthColor.withValues(alpha: 0.1),
                                  border: Border.all(
                                    color: AppTheme.wealthColor.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Recommended',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.wealthColor,
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
                              color: AppTheme.wealthColor.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.wealthColor.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline,
                                  size: 16,
                                  color: AppTheme.wealthColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    module['personalizedTip'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.wealthColor,
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

  int _getModuleProgress(List<ModuleProgress> wealthModules, String moduleId) {
    final moduleProgress = wealthModules.where((m) => m.moduleId == moduleId).firstOrNull;
    if (moduleProgress == null) return 0;
    return (moduleProgress.overallProgress * 100).round();
  }

  List<Map<String, dynamic>> _getPersonalizedWealthModules(List<ModuleProgress> wealthModules, onboardingData) {
    final baseModules = [
      {
        'title': 'Smart Budgeting',
        'moduleId': 'budgeting',
        'icon': Icons.calculate,
        'color': Colors.green,
        'description': 'Master the 50-30-20 rule and track expenses',
        'progress': _getModuleProgress(wealthModules, 'budgeting'),
        'lessons': ProgressTrackingService.moduleLessonCounts['budgeting'] ?? 2,
        'recommended': false,
        'personalizedTip': null,
      },
      {
        'title': 'Investment Basics',
        'moduleId': 'investing',
        'icon': Icons.trending_up,
        'color': Colors.blue,
        'description': 'SIPs, mutual funds, and stock basics',
        'progress': _getModuleProgress(wealthModules, 'investing'),
        'lessons': ProgressTrackingService.moduleLessonCounts['investing'] ?? 2,
        'recommended': false,
        'personalizedTip': null,
      },
      {
        'title': 'Credit & Loans',
        'moduleId': 'credit',
        'icon': Icons.credit_card,
        'color': Colors.red,
        'description': 'Understand credit scores and avoid debt traps',
        'progress': _getModuleProgress(wealthModules, 'credit'),
        'lessons': ProgressTrackingService.moduleLessonCounts['credit'] ?? 4,
        'recommended': false,
        'personalizedTip': null,
      },
      {
        'title': 'Insurance Planning',
        'moduleId': 'insurance',
        'icon': Icons.security,
        'color': AppTheme.purpleColor,
        'description': 'Protect your wealth with smart insurance',
        'progress': _getModuleProgress(wealthModules, 'insurance'),
        'lessons': ProgressTrackingService.moduleLessonCounts['insurance'] ?? 4,
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
          module['personalizedTip'] = _getPersonalizedWealthTip(moduleId, onboardingData);
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

  String? _getPersonalizedWealthTip(String moduleId, onboardingData) {
    if (onboardingData == null) return null;
    
    switch (moduleId) {
      case 'budgeting':
        if (onboardingData.wealthGoal.contains('Saving') || onboardingData.interests.contains('Budgeting')) {
          return 'Perfect for your savings and budgeting goals!';
        }
        return 'Essential foundation for financial success';
      case 'investing':
        if (onboardingData.wealthGoal.contains('Investment') || onboardingData.interests.contains('Investing')) {
          return 'Directly aligned with your investment goals';
        }
        if (onboardingData.experienceLevel == 'Beginner') {
          return 'Start with basics and build your investment knowledge';
        }
        return 'Grow your wealth through smart investing';
      case 'credit':
        if (onboardingData.wealthGoal.contains('Credit') || onboardingData.interests.contains('Credit')) {
          return 'Essential for your credit improvement goals';
        }
        return 'Build and maintain excellent credit health';
      case 'insurance':
        if (onboardingData.wealthGoal.contains('Insurance') || onboardingData.interests.contains('Insurance')) {
          return 'Perfect for your insurance planning needs';
        }
        return 'Protect your financial future with smart insurance';
      default:
        return null;
    }
  }

  Widget _buildPersonalizedWealthWelcomeCard(onboardingData) {
    final service = SimpleOnboardingService();
    final personalizedContent = service.generatePersonalizedContent(onboardingData);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppTheme.wealthColor.withValues(alpha: 0.1),
              AppTheme.wealthColor.withValues(alpha: 0.05),
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
                    Icons.account_balance_wallet,
                    color: AppTheme.wealthColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your Wealth Journey',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.wealthColor,
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
                'Financial Tips for You:',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.wealthColor,
                ),
              ),
              const SizedBox(height: 8),
              ...(personalizedContent['customTips'] as List<String>).take(2).map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: AppTheme.wealthColor)),
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
                final wealthModules = allModuleProgress.where((m) => m.category == 'wealth').toList();
                
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
                                'Overall Wealth Progress',
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
                                value: (stats['wealthProgress'] as double? ?? 0.0),
                                backgroundColor: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 8),
                              Text('${((stats['wealthProgress'] as double? ?? 0.0) * 100).round()}% Complete'),
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
                      ...wealthModules.map((module) => Card(
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
                            if (wealthModules.where((m) => m.lessonCompleted).isNotEmpty)
                              const ListTile(
                                leading: Icon(Icons.star, color: Colors.orange),
                                title: Text('Making great progress!'),
                                subtitle: Text('You\'re building wealth knowledge!'),
                              ),
                            if ((stats['completedLessons'] as int? ?? 0) == 0 && (stats['passedQuizzes'] as int? ?? 0) == 0)
                              const ListTile(
                                leading: Icon(Icons.info, color: Colors.blue),
                                title: Text('Start your wealth journey'),
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

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Monthly Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildOverviewItem('Income', '₹45,000', Colors.green),
                      _buildOverviewItem('Expenses', '₹32,000', Colors.red),
                      _buildOverviewItem('Savings', '₹13,000', Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Savings Rate',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.29,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '29% (Goal: 20%)',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Add Expense
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Expense',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Category',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Amount',
                          ),
                          keyboardType: TextInputType.number,
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
                  Text(
                    'Recent Expenses',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  _buildExpenseItem('Food', '₹150', 'Today'),
                  _buildExpenseItem('Transport', '₹80', 'Today'),
                  _buildExpenseItem('Entertainment', '₹200', 'Yesterday'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Investment Simulator
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.trending_up, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Investment Simulator',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'Portfolio Value',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                '₹25,400',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                '+12.5% ↗',
                                style: TextStyle(fontSize: 12, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'Monthly SIP',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                '₹5,000',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                '3 funds',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.book),
                      label: const Text('Learn About SIPs'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
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

  Widget _buildExpenseItem(String category, String amount, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(category),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    final tips = [
      "💰 Save at least 20% of your income every month",
      "📊 Review your expenses weekly to identify spending patterns",
      "🎯 Set up automatic transfers to your savings account",
      "💳 Pay your credit card bills in full to avoid interest charges",
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
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Calculators',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _buildCalculatorButton(Icons.calculate, 'SIP Calculator'),
                      _buildCalculatorButton(Icons.savings, 'Goal Planner'),
                      _buildCalculatorButton(Icons.credit_card, 'EMI Calculator'),
                      _buildCalculatorButton(Icons.trending_up, 'Return Calculator'),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildCalculatorButton(IconData icon, String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
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