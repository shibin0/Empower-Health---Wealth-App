import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../services/simple_onboarding_service.dart';
import 'interests_selection_screen.dart';

class GoalsSelectionScreen extends ConsumerStatefulWidget {
  const GoalsSelectionScreen({super.key});

  @override
  ConsumerState<GoalsSelectionScreen> createState() => _GoalsSelectionScreenState();
}

class _GoalsSelectionScreenState extends ConsumerState<GoalsSelectionScreen> {
  List<String> _selectedHealthGoals = [];
  List<String> _selectedWealthGoals = [];
  
  final List<Map<String, dynamic>> _healthGoals = [
    {
      'id': 'weight_management',
      'title': 'Weight Management',
      'description': 'Achieve and maintain a healthy weight',
      'icon': Icons.fitness_center,
    },
    {
      'id': 'exercise_routine',
      'title': 'Regular Exercise',
      'description': 'Build a consistent workout routine',
      'icon': Icons.directions_run,
    },
    {
      'id': 'better_sleep',
      'title': 'Better Sleep',
      'description': 'Improve sleep quality and duration',
      'icon': Icons.bedtime,
    },
    {
      'id': 'stress_management',
      'title': 'Stress Management',
      'description': 'Learn techniques to manage stress',
      'icon': Icons.self_improvement,
    },
    {
      'id': 'nutrition',
      'title': 'Healthy Nutrition',
      'description': 'Develop better eating habits',
      'icon': Icons.restaurant,
    },
    {
      'id': 'mental_wellness',
      'title': 'Mental Wellness',
      'description': 'Focus on mental health and mindfulness',
      'icon': Icons.psychology,
    },
  ];
  
  final List<Map<String, dynamic>> _wealthGoals = [
    {
      'id': 'emergency_fund',
      'title': 'Emergency Fund',
      'description': 'Build a financial safety net',
      'icon': Icons.security,
    },
    {
      'id': 'debt_reduction',
      'title': 'Debt Reduction',
      'description': 'Pay off existing debts',
      'icon': Icons.trending_down,
    },
    {
      'id': 'investment_growth',
      'title': 'Investment Growth',
      'description': 'Grow wealth through investments',
      'icon': Icons.trending_up,
    },
    {
      'id': 'retirement_planning',
      'title': 'Retirement Planning',
      'description': 'Plan for long-term financial security',
      'icon': Icons.elderly,
    },
    {
      'id': 'budgeting',
      'title': 'Better Budgeting',
      'description': 'Track and manage expenses',
      'icon': Icons.account_balance_wallet,
    },
    {
      'id': 'financial_literacy',
      'title': 'Financial Education',
      'description': 'Learn about money management',
      'icon': Icons.school,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  void _loadExistingData() {
    final onboardingData = ref.read(onboardingDataProvider);
    if (onboardingData != null) {
      // Convert single goal strings to lists for multi-selection
      if (onboardingData.healthGoal.isNotEmpty) {
        _selectedHealthGoals = [onboardingData.healthGoal];
      }
      if (onboardingData.wealthGoal.isNotEmpty) {
        _selectedWealthGoals = [onboardingData.wealthGoal];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.lightForeground),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Your Goals',
          style: TextStyle(
            color: AppTheme.lightForeground,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What are your goals?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Text(
                      'Select the areas you\'d like to focus on. You can choose multiple goals.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.lightForeground.withOpacity(0.6),
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Health Goals Section
                    const Text(
                      'Health & Wellness Goals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    ..._healthGoals.map((goal) => _buildGoalCard(
                      goal,
                      _selectedHealthGoals.contains(goal['id']),
                      (selected) {
                        setState(() {
                          if (selected) {
                            _selectedHealthGoals.add(goal['id']);
                          } else {
                            _selectedHealthGoals.remove(goal['id']);
                          }
                        });
                      },
                    )),
                    
                    const SizedBox(height: 32),
                    
                    // Wealth Goals Section
                    const Text(
                      'Wealth & Financial Goals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    ..._wealthGoals.map((goal) => _buildGoalCard(
                      goal,
                      _selectedWealthGoals.contains(goal['id']),
                      (selected) {
                        setState(() {
                          if (selected) {
                            _selectedWealthGoals.add(goal['id']);
                          } else {
                            _selectedWealthGoals.remove(goal['id']);
                          }
                        });
                      },
                    )),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // Bottom button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canContinue() ? _saveAndContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: AppTheme.primaryColor.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(
    Map<String, dynamic> goal,
    bool isSelected,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onChanged(!isSelected),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? AppTheme.primaryColor
                  : AppTheme.lightBorder,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? AppTheme.primaryColor.withOpacity(0.05)
                : AppTheme.lightCard,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : AppTheme.lightBorder.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  goal['icon'],
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.lightForeground.withOpacity(0.6),
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      goal['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.lightForeground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.lightBorder,
                    width: 2,
                  ),
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canContinue() {
    return _selectedHealthGoals.isNotEmpty || _selectedWealthGoals.isNotEmpty;
  }

  void _saveAndContinue() {
    final currentData = ref.read(onboardingDataProvider);
    if (currentData != null) {
      // For now, take the first selected goal as the primary goal
      final primaryHealthGoal = _selectedHealthGoals.isNotEmpty ? _selectedHealthGoals.first : '';
      final primaryWealthGoal = _selectedWealthGoals.isNotEmpty ? _selectedWealthGoals.first : '';
      
      final updatedData = currentData.copyWith(
        healthGoal: primaryHealthGoal,
        wealthGoal: primaryWealthGoal,
        primaryGoals: [
          if (_selectedHealthGoals.isNotEmpty) 'Health',
          if (_selectedWealthGoals.isNotEmpty) 'Wealth',
        ],
      );
      
      ref.read(onboardingDataProvider.notifier).updateData(updatedData);
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const InterestsSelectionScreen(),
        ),
      );
    }
  }
}