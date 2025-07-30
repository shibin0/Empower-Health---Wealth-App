import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../models/onboarding_data.dart';
import '../../services/simple_onboarding_service.dart';
import 'personal_info_screen.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      title: 'Welcome to Empower',
      subtitle: 'Your Health & Wealth Journey Starts Here',
      description: 'Transform your life with personalized guidance for better health and financial wellness.',
      iconPath: 'assets/icons/welcome.png',
      benefits: [
        'Personalized health recommendations',
        'Smart financial planning tools',
        'Progress tracking and insights',
        'Expert-backed content'
      ],
    ),
    OnboardingStep(
      title: 'Health & Wellness',
      subtitle: 'Build Healthy Habits That Last',
      description: 'Get customized nutrition, exercise, sleep, and mental health guidance based on your goals.',
      iconPath: 'assets/icons/health.png',
      benefits: [
        'Nutrition tracking and meal plans',
        'Personalized workout routines',
        'Sleep optimization strategies',
        'Mental wellness techniques'
      ],
    ),
    OnboardingStep(
      title: 'Financial Empowerment',
      subtitle: 'Take Control of Your Financial Future',
      description: 'Learn budgeting, investing, and wealth-building strategies tailored to your situation.',
      iconPath: 'assets/icons/wealth.png',
      benefits: [
        'Smart budgeting tools',
        'Investment guidance',
        'Credit score improvement',
        'Insurance planning'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: List.generate(
                  _steps.length,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index < _steps.length - 1 ? 8 : 0),
                      decoration: BoxDecoration(
                        color: index <= _currentPage 
                            ? AppTheme.primaryColor 
                            : AppTheme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        
                        // Icon placeholder (you can replace with actual images)
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Icon(
                            index == 0 ? Icons.waving_hand : 
                            index == 1 ? Icons.favorite : Icons.account_balance_wallet,
                            size: 60,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Title
                        Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightForeground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Subtitle
                        Text(
                          step.subtitle,
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.lightForeground.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Description
                        Text(
                          step.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.lightForeground.withOpacity(0.6),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Benefits
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.lightCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            children: step.benefits.map((benefit) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      benefit,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.lightForeground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),
                        ),
                        
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Bottom navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: AppTheme.lightForeground.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  
                  const Spacer(),
                  
                  // Page indicators
                  Row(
                    children: List.generate(
                      _steps.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: index == _currentPage 
                              ? AppTheme.primaryColor 
                              : AppTheme.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _steps.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _startOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentPage < _steps.length - 1 ? 'Next' : 'Get Started',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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

  void _startOnboarding() {
    // Initialize empty onboarding data
    final initialData = OnboardingData(
      name: '',
      age: 25,
      city: '',
      primaryGoals: [],
      healthGoal: '',
      wealthGoal: '',
      experienceLevel: 'Beginner',
      interests: [],
      preferences: {},
    );
    
    ref.read(onboardingDataProvider.notifier).updateData(initialData);
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const PersonalInfoScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}