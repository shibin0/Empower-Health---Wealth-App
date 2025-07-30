import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../utils/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _healthGoalController = TextEditingController();
  final TextEditingController _wealthGoalController = TextEditingController();

  final List<String> _selectedGoals = [];
  String _selectedLevel = 'beginner';

  final List<Map<String, dynamic>> _goalOptions = [
    {'id': 'fitness', 'label': 'Get Fit & Healthy', 'icon': '💪'},
    {'id': 'nutrition', 'label': 'Eat Better', 'icon': '🥗'},
    {'id': 'mental', 'label': 'Mental Wellbeing', 'icon': '🧘'},
    {'id': 'budget', 'label': 'Budget & Save Money', 'icon': '💰'},
    {'id': 'invest', 'label': 'Learn Investing', 'icon': '📈'},
    {'id': 'debt', 'label': 'Manage Debt', 'icon': '💳'},
  ];

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final profile = UserProfile(
        name: _nameController.text,
        age: _ageController.text,
        city: _cityController.text,
        primaryGoals: _selectedGoals,
        healthGoal: _healthGoalController.text,
        wealthGoal: _wealthGoalController.text,
        currentLevel: _selectedLevel,
      );

      // Update user profile in database
      await AuthService().updateUserProfile(profile.toJson());

      // Create initial health and wealth goals
      final databaseService = DatabaseService();
      
      if (_healthGoalController.text.isNotEmpty) {
        await databaseService.createHealthGoal({
          'title': _healthGoalController.text,
          'description': 'Primary health goal set during onboarding',
          'category': _selectedGoals.contains('fitness') ? 'fitness' :
                     _selectedGoals.contains('nutrition') ? 'nutrition' : 'general',
          'status': 'active',
        });
      }

      if (_wealthGoalController.text.isNotEmpty) {
        await databaseService.createWealthGoal({
          'title': _wealthGoalController.text,
          'description': 'Primary wealth goal set during onboarding',
          'category': _selectedGoals.contains('budget') ? 'savings' :
                     _selectedGoals.contains('invest') ? 'investment' : 'general',
          'status': 'active',
        });
      }

      // Hide loading and trigger auth state refresh
      if (mounted) {
        Navigator.of(context).pop(); // Remove loading dialog
        // Pop back to auth wrapper which will detect the new profile
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } catch (e) {
      // Hide loading and show error
      if (mounted) {
        Navigator.of(context).pop(); // Remove loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error completing onboarding: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _nameController.text.isNotEmpty &&
            _ageController.text.isNotEmpty &&
            _cityController.text.isNotEmpty;
      case 1:
        return _selectedGoals.isNotEmpty;
      case 2:
        return _healthGoalController.text.isNotEmpty &&
            _wealthGoalController.text.isNotEmpty;
      case 3:
        return _selectedLevel.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppTheme.spacing5),
            // Progress indicator
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.spacing6),
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / 4,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: AppTheme.spacing5),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildBasicInfoStep(),
                  _buildGoalsStep(),
                  _buildSpecificGoalsStep(),
                  _buildLevelStep(),
                ],
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing6),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canProceed() ? () async {
                    if (_currentStep == 3) {
                      await _completeOnboarding();
                    } else {
                      _nextStep();
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppTheme.spacing4),
                  ),
                  child: Text(
                    _currentStep == 3 ? 'Start My Journey' : 'Continue',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacing6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppTheme.spacing20,
            height: AppTheme.spacing20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.spacing10),
            ),
            child: Icon(
              Icons.track_changes,
              size: AppTheme.spacing10,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing6),
          Text(
            'Welcome to Empower!',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            'Let\'s start your journey to better health and wealth',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              hintText: 'Enter your name',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppTheme.spacing4),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(
              labelText: 'Age',
              hintText: '22-28',
            ),
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppTheme.spacing4),
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              hintText: 'Bangalore, Mumbai, Delhi...',
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsStep() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacing6),
      child: Column(
        children: [
          const SizedBox(height: AppTheme.spacing10),
          Text(
            'What matters most to you?',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            'Choose 1-2 areas you want to focus on',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing8),
          Expanded(
            child: ListView.builder(
              itemCount: _goalOptions.length,
              itemBuilder: (context, index) {
                final goal = _goalOptions[index];
                final isSelected = _selectedGoals.contains(goal['id']);

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacing3),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedGoals.remove(goal['id']);
                        } else {
                          if (_selectedGoals.length < 2) {
                            _selectedGoals.add(goal['id']);
                          }
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    child: Container(
                      padding: const EdgeInsets.all(AppTheme.spacing4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        color: isSelected
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.05)
                            : Theme.of(context).colorScheme.surface,
                      ),
                      child: Row(
                        children: [
                          Text(
                            goal['icon'],
                            style:
                                const TextStyle(fontSize: AppTheme.fontSize2xl),
                          ),
                          const SizedBox(width: AppTheme.spacing4),
                          Expanded(
                            child: Text(
                              goal['label'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificGoalsStep() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacing6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set Your Goals',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            'What specific goals would you like to achieve?',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              const Icon(Icons.favorite, color: AppTheme.healthColor, size: AppTheme.spacing5),
              const SizedBox(width: AppTheme.spacing2),
              Text(
                'Health Goal',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing2),
          TextField(
            controller: _healthGoalController,
            decoration: const InputDecoration(
              hintText: 'e.g., Lose 5kg in 3 months',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppTheme.spacing6),
          Row(
            children: [
              const Icon(Icons.attach_money,
                  color: AppTheme.wealthColor, size: AppTheme.spacing5),
              const SizedBox(width: AppTheme.spacing2),
              Text(
                'Wealth Goal',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing2),
          TextField(
            controller: _wealthGoalController,
            decoration: const InputDecoration(
              hintText: 'e.g., Save ₹50,000 by December',
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelStep() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacing6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How would you rate yourself?',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            'This helps us personalize your learning journey',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing8),
          _buildLevelOption(
            'beginner',
            '🌱 Complete Beginner',
            'Just starting my health & wealth journey',
          ),
          const SizedBox(height: AppTheme.spacing4),
          _buildLevelOption(
            'intermediate',
            '🚀 Some Knowledge',
            'I know basics but want to learn more',
          ),
          const SizedBox(height: AppTheme.spacing4),
          _buildLevelOption(
            'advanced',
            '⭐ Pretty Good',
            'I have good habits but want to optimize',
          ),
        ],
      ),
    );
  }

  Widget _buildLevelOption(String value, String title, String subtitle) {
    final isSelected = _selectedLevel == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedLevel = value;
        });
      },
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppTheme.spacing4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          color: isSelected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.05)
            : Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _selectedLevel,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLevel = newValue!;
                });
              },
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: AppTheme.spacing2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _healthGoalController.dispose();
    _wealthGoalController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
