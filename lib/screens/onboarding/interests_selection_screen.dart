import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../services/simple_onboarding_service.dart';
import '../main_screen.dart';

class InterestsSelectionScreen extends ConsumerStatefulWidget {
  const InterestsSelectionScreen({super.key});

  @override
  ConsumerState<InterestsSelectionScreen> createState() => _InterestsSelectionScreenState();
}

class _InterestsSelectionScreenState extends ConsumerState<InterestsSelectionScreen> {
  List<String> _selectedInterests = [];
  Map<String, bool> _preferences = {};
  
  final List<Map<String, dynamic>> _interests = [
    {
      'id': 'fitness',
      'title': 'Fitness & Exercise',
      'description': 'Workouts, training, and physical activity',
      'icon': Icons.fitness_center,
      'category': 'health',
    },
    {
      'id': 'nutrition',
      'title': 'Nutrition & Diet',
      'description': 'Healthy eating and meal planning',
      'icon': Icons.restaurant,
      'category': 'health',
    },
    {
      'id': 'mental_health',
      'title': 'Mental Health',
      'description': 'Mindfulness, stress management, and wellbeing',
      'icon': Icons.psychology,
      'category': 'health',
    },
    {
      'id': 'sleep',
      'title': 'Sleep Optimization',
      'description': 'Better sleep habits and recovery',
      'icon': Icons.bedtime,
      'category': 'health',
    },
    {
      'id': 'investing',
      'title': 'Investing',
      'description': 'Stocks, bonds, and investment strategies',
      'icon': Icons.trending_up,
      'category': 'wealth',
    },
    {
      'id': 'budgeting',
      'title': 'Budgeting',
      'description': 'Money management and expense tracking',
      'icon': Icons.account_balance_wallet,
      'category': 'wealth',
    },
    {
      'id': 'credit',
      'title': 'Credit & Debt',
      'description': 'Credit scores and debt management',
      'icon': Icons.credit_card,
      'category': 'wealth',
    },
    {
      'id': 'insurance',
      'title': 'Insurance',
      'description': 'Protection and risk management',
      'icon': Icons.security,
      'category': 'wealth',
    },
    {
      'id': 'entrepreneurship',
      'title': 'Entrepreneurship',
      'description': 'Starting and growing businesses',
      'icon': Icons.business,
      'category': 'wealth',
    },
    {
      'id': 'real_estate',
      'title': 'Real Estate',
      'description': 'Property investment and ownership',
      'icon': Icons.home,
      'category': 'wealth',
    },
  ];

  final List<Map<String, dynamic>> _preferenceOptions = [
    {
      'id': 'daily_reminders',
      'title': 'Daily Reminders',
      'description': 'Get daily notifications to stay on track',
    },
    {
      'id': 'weekly_reports',
      'title': 'Weekly Progress Reports',
      'description': 'Receive weekly summaries of your progress',
    },
    {
      'id': 'community_features',
      'title': 'Community Features',
      'description': 'Connect with others on similar journeys',
    },
    {
      'id': 'advanced_analytics',
      'title': 'Advanced Analytics',
      'description': 'Detailed insights and trend analysis',
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
      _selectedInterests = List.from(onboardingData.interests);
      _preferences = Map.from(onboardingData.preferences);
    }
  }

  @override
  Widget build(BuildContext context) {
    final healthInterests = _interests.where((i) => i['category'] == 'health').toList();
    final wealthInterests = _interests.where((i) => i['category'] == 'wealth').toList();
    
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
          'Your Interests',
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
                      'What interests you most?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Text(
                      'Select topics you\'d like to learn more about. This helps us personalize your content.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.lightForeground.withOpacity(0.6),
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Health Interests Section
                    const Text(
                      'Health & Wellness',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    ...healthInterests.map((interest) => _buildInterestCard(interest)),
                    
                    const SizedBox(height: 32),
                    
                    // Wealth Interests Section
                    const Text(
                      'Wealth & Finance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    ...wealthInterests.map((interest) => _buildInterestCard(interest)),
                    
                    const SizedBox(height: 32),
                    
                    // Preferences Section
                    const Text(
                      'App Preferences',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Text(
                      'Customize your app experience',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.lightForeground.withOpacity(0.6),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    ..._preferenceOptions.map((pref) => _buildPreferenceCard(pref)),
                    
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
                  onPressed: _completeOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Complete Setup',
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

  Widget _buildInterestCard(Map<String, dynamic> interest) {
    final isSelected = _selectedInterests.contains(interest['id']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedInterests.remove(interest['id']);
            } else {
              _selectedInterests.add(interest['id']);
            }
          });
        },
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : AppTheme.lightBorder.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  interest['icon'],
                  color: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.lightForeground.withOpacity(0.6),
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      interest['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightForeground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      interest['description'],
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
                width: 20,
                height: 20,
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
                        size: 12,
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

  Widget _buildPreferenceCard(Map<String, dynamic> preference) {
    final isEnabled = _preferences[preference['id']] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.lightBorder),
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.lightCard,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    preference['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightForeground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    preference['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.lightForeground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 16),
            
            Switch(
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  _preferences[preference['id']] = value;
                });
              },
              activeColor: AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _completeOnboarding() async {
    final currentData = ref.read(onboardingDataProvider);
    if (currentData != null) {
      final updatedData = currentData.copyWith(
        interests: _selectedInterests,
        preferences: _preferences,
      );
      
      ref.read(onboardingDataProvider.notifier).updateData(updatedData);
      
      // Save to persistent storage
      final service = ref.read(simpleOnboardingServiceProvider);
      await service.saveOnboardingData(updatedData);
      await service.markOnboardingCompleted();
      
      // Navigate to main app
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (route) => false,
        );
      }
    }
  }
}