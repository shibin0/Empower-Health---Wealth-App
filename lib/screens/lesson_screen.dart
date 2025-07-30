import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_theme.dart';
import '../services/progress_tracking_service.dart';
import '../services/auth_service.dart';

class LessonScreen extends ConsumerStatefulWidget {
  final String moduleId;
  final String moduleTitle;
  final String category; // 'health' or 'wealth'
  
  const LessonScreen({
    super.key,
    required this.moduleId,
    required this.moduleTitle,
    required this.category,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<Map<String, dynamic>> _lessons;

  @override
  void initState() {
    super.initState();
    _loadLessons();
    _startLessonTracking();
  }

  void _startLessonTracking() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;
      if (user != null) {
        final progressService = ref.read(progressTrackingServiceProvider);
        await progressService.startLesson(user.id, widget.moduleId, widget.category);
      }
    } catch (e) {
      print('Error starting lesson tracking: $e');
    }
  }

  void _loadLessons() {
    // Mock lesson data based on module
    switch (widget.moduleId) {
      case 'nutrition':
        _lessons = [
          {
            'title': 'Understanding Macronutrients',
            'content': 'Macronutrients are the main nutrients your body needs in large amounts: carbohydrates, proteins, and fats. Each plays a crucial role in your health.',
            'image': '🍎',
            'keyPoints': [
              'Carbohydrates provide energy for daily activities',
              'Proteins help build and repair muscles',
              'Healthy fats support brain function',
              'Balance is key - aim for 50% carbs, 25% protein, 25% fats'
            ]
          },
          {
            'title': 'Meal Planning Basics',
            'content': 'Planning your meals ahead of time helps you make healthier choices and saves time and money.',
            'image': '📝',
            'keyPoints': [
              'Plan meals for the week every Sunday',
              'Include a variety of colors on your plate',
              'Prep ingredients in advance',
              'Keep healthy snacks readily available'
            ]
          },
          {
            'title': 'Reading Food Labels',
            'content': 'Understanding food labels helps you make informed choices about what you eat.',
            'image': '🏷️',
            'keyPoints': [
              'Check serving sizes first',
              'Look for hidden sugars and sodium',
              'Choose foods with fewer ingredients',
              'Avoid trans fats completely'
            ]
          }
        ];
        break;
      case 'fitness':
        _lessons = [
          {
            'title': 'Starting Your Fitness Journey',
            'content': 'Beginning a fitness routine can be overwhelming, but starting small and being consistent is the key to success.',
            'image': '🏃',
            'keyPoints': [
              'Start with 15-20 minutes of activity daily',
              'Choose activities you enjoy',
              'Focus on consistency over intensity',
              'Listen to your body and rest when needed'
            ]
          },
          {
            'title': 'Home Workout Essentials',
            'content': 'You don\'t need a gym to stay fit. Many effective exercises can be done at home with minimal equipment.',
            'image': '🏠',
            'keyPoints': [
              'Bodyweight exercises are highly effective',
              'Use household items as weights',
              'Create a dedicated workout space',
              'Follow online workout videos for guidance'
            ]
          }
        ];
        break;
      case 'budgeting':
        _lessons = [
          {
            'title': 'The 50-30-20 Rule',
            'content': 'This simple budgeting rule helps you allocate your income effectively: 50% for needs, 30% for wants, and 20% for savings.',
            'image': '💰',
            'keyPoints': [
              '50% for essential expenses (rent, food, utilities)',
              '30% for discretionary spending (entertainment, dining out)',
              '20% for savings and debt repayment',
              'Adjust percentages based on your situation'
            ]
          },
          {
            'title': 'Tracking Your Expenses',
            'content': 'Understanding where your money goes is the first step to better financial health.',
            'image': '📊',
            'keyPoints': [
              'Use apps or spreadsheets to track spending',
              'Categorize your expenses',
              'Review weekly to identify patterns',
              'Set alerts for overspending'
            ]
          }
        ];
        break;
      case 'investing':
        _lessons = [
          {
            'title': 'Investment Basics',
            'content': 'Investing helps your money grow over time through the power of compound interest.',
            'image': '📈',
            'keyPoints': [
              'Start early to benefit from compound interest',
              'Diversify your investments',
              'Understand risk vs. return',
              'Invest regularly, not just lump sums'
            ]
          },
          {
            'title': 'Understanding SIPs',
            'content': 'Systematic Investment Plans (SIPs) allow you to invest small amounts regularly in mutual funds.',
            'image': '🔄',
            'keyPoints': [
              'Invest a fixed amount monthly',
              'Reduces impact of market volatility',
              'Builds discipline in investing',
              'Can start with as little as ₹500'
            ]
          }
        ];
        break;
      case 'sleep':
        _lessons = [
          {
            'title': 'Understanding Sleep Cycles',
            'content': 'Sleep occurs in cycles of about 90 minutes, each containing four stages: light sleep, deep sleep, and REM (Rapid Eye Movement) sleep. Understanding these cycles helps you optimize your rest.',
            'image': '😴',
            'keyPoints': [
              'Complete sleep cycles last 90 minutes',
              'Deep sleep is crucial for physical recovery',
              'REM sleep supports memory and learning',
              'Most adults need 4-6 complete cycles nightly'
            ]
          },
          {
            'title': 'Creating the Perfect Sleep Environment',
            'content': 'Your bedroom environment significantly impacts sleep quality. Temperature, lighting, noise, and comfort all play crucial roles in achieving restorative sleep.',
            'image': '🛏️',
            'keyPoints': [
              'Keep bedroom temperature between 65-68°F (18-20°C)',
              'Use blackout curtains or eye masks',
              'Minimize noise or use white noise',
              'Invest in a comfortable mattress and pillows'
            ]
          },
          {
            'title': 'Sleep Hygiene Habits',
            'content': 'Good sleep hygiene involves consistent habits that signal to your body when it\'s time to sleep. These practices help regulate your circadian rhythm.',
            'image': '🌙',
            'keyPoints': [
              'Go to bed and wake up at the same time daily',
              'Avoid screens 1 hour before bedtime',
              'No caffeine after 2 PM',
              'Create a relaxing bedtime routine'
            ]
          },
          {
            'title': 'Managing Sleep Disorders',
            'content': 'Common sleep issues like insomnia, sleep apnea, and restless leg syndrome can significantly impact your health. Recognizing symptoms and seeking help is important.',
            'image': '⚕️',
            'keyPoints': [
              'Chronic insomnia affects 10% of adults',
              'Sleep apnea causes breathing interruptions',
              'Keep a sleep diary to track patterns',
              'Consult a doctor for persistent sleep problems'
            ]
          }
        ];
        break;
      case 'mental':
        _lessons = [
          {
            'title': 'Understanding Stress and Its Impact',
            'content': 'Stress is your body\'s natural response to challenges, but chronic stress can harm your physical and mental health. Learning to recognize and manage stress is essential for wellbeing.',
            'image': '🧘',
            'keyPoints': [
              'Acute stress can be beneficial and motivating',
              'Chronic stress leads to health problems',
              'Common symptoms include headaches, fatigue, anxiety',
              'Stress affects immune system and sleep quality'
            ]
          },
          {
            'title': 'Mindfulness and Meditation Basics',
            'content': 'Mindfulness is the practice of being present and fully engaged with the current moment. Regular meditation can reduce stress, improve focus, and enhance emotional regulation.',
            'image': '🧠',
            'keyPoints': [
              'Start with just 5 minutes of daily meditation',
              'Focus on your breath as an anchor',
              'Observe thoughts without judgment',
              'Use apps like Headspace or Calm for guidance'
            ]
          },
          {
            'title': 'Building Emotional Resilience',
            'content': 'Emotional resilience is your ability to adapt and bounce back from adversity. It\'s a skill that can be developed through practice and self-awareness.',
            'image': '💪',
            'keyPoints': [
              'Practice self-compassion and positive self-talk',
              'Build strong social connections',
              'Develop problem-solving skills',
              'Learn from setbacks and failures'
            ]
          },
          {
            'title': 'Healthy Coping Strategies',
            'content': 'Having a toolkit of healthy coping strategies helps you manage difficult emotions and situations effectively without resorting to harmful behaviors.',
            'image': '🛠️',
            'keyPoints': [
              'Exercise releases mood-boosting endorphins',
              'Journaling helps process emotions',
              'Deep breathing activates relaxation response',
              'Seek professional help when needed'
            ]
          }
        ];
        break;
      case 'credit':
        _lessons = [
          {
            'title': 'Understanding Credit Scores',
            'content': 'Your credit score is a three-digit number that represents your creditworthiness. It affects your ability to get loans, credit cards, and even impacts insurance rates and job applications.',
            'image': '📊',
            'keyPoints': [
              'Credit scores range from 300-850 in India',
              'Above 750 is considered excellent',
              'Payment history is the most important factor',
              'Check your credit score regularly for free'
            ]
          },
          {
            'title': 'Building Good Credit History',
            'content': 'Building good credit takes time and consistent responsible behavior. Start early and maintain good habits to establish a strong credit foundation.',
            'image': '🏗️',
            'keyPoints': [
              'Pay all bills on time, every time',
              'Keep credit utilization below 30%',
              'Don\'t close old credit cards',
              'Limit hard inquiries on your credit report'
            ]
          },
          {
            'title': 'Types of Loans and When to Use Them',
            'content': 'Different types of loans serve different purposes. Understanding when and how to use each type can help you make smart borrowing decisions.',
            'image': '🏦',
            'keyPoints': [
              'Home loans have the lowest interest rates',
              'Personal loans are unsecured but expensive',
              'Credit cards should be for convenience, not borrowing',
              'Education loans often have favorable terms'
            ]
          },
          {
            'title': 'Avoiding Debt Traps',
            'content': 'Debt can be a useful tool, but it can also become a trap that\'s difficult to escape. Learn to recognize and avoid common debt pitfalls.',
            'image': '⚠️',
            'keyPoints': [
              'Avoid minimum payment traps on credit cards',
              'Don\'t take loans for lifestyle expenses',
              'Beware of payday loans and high-interest debt',
              'Create an emergency fund to avoid debt'
            ]
          }
        ];
        break;
      case 'insurance':
        _lessons = [
          {
            'title': 'Why Insurance Matters',
            'content': 'Insurance protects you and your family from financial catastrophe. It\'s not about making money, but about transferring risk and ensuring financial security.',
            'image': '🛡️',
            'keyPoints': [
              'Insurance transfers financial risk to the insurer',
              'Protects your savings from unexpected expenses',
              'Provides peace of mind and security',
              'Some insurance is legally required (car, health)'
            ]
          },
          {
            'title': 'Types of Life Insurance',
            'content': 'Life insurance ensures your family\'s financial security if something happens to you. Understanding the different types helps you choose the right coverage.',
            'image': '👨‍👩‍👧‍👦',
            'keyPoints': [
              'Term insurance is pure protection, cheapest option',
              'Whole life combines insurance with investment',
              'Coverage should be 10-15 times your annual income',
              'Buy early when premiums are lower'
            ]
          },
          {
            'title': 'Health Insurance Essentials',
            'content': 'Health insurance is crucial in India where medical costs are rising rapidly. Good health coverage protects your savings from medical emergencies.',
            'image': '🏥',
            'keyPoints': [
              'Choose family floater plans for cost efficiency',
              'Look for cashless hospital networks',
              'Understand waiting periods for pre-existing conditions',
              'Consider top-up plans for higher coverage'
            ]
          },
          {
            'title': 'Other Important Insurance Types',
            'content': 'Beyond life and health, other insurance types protect specific assets and situations. Understanding these helps create comprehensive protection.',
            'image': '🚗',
            'keyPoints': [
              'Motor insurance is mandatory by law',
              'Home insurance protects your biggest asset',
              'Travel insurance covers trip-related risks',
              'Disability insurance replaces lost income'
            ]
          }
        ];
        break;
      default:
        _lessons = [
          {
            'title': 'Getting Started',
            'content': 'Welcome to your learning journey! This module will help you build better habits.',
            'image': '🌟',
            'keyPoints': [
              'Take it one step at a time',
              'Practice makes perfect',
              'Stay consistent',
              'Celebrate small wins'
            ]
          }
        ];
    }
  }

  void _nextPage() {
    if (_currentPage < _lessons.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeLesson();
    }
  }

  void _completeLesson() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;
      if (user != null) {
        final progressService = ref.read(progressTrackingServiceProvider);
        await progressService.completeLesson(user.id, widget.moduleId, widget.category);
      }
    } catch (e) {
      print('Error completing lesson tracking: $e');
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          moduleId: widget.moduleId,
          moduleTitle: widget.moduleTitle,
          category: widget.category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.category == 'health' 
        ? AppTheme.healthColor 
        : AppTheme.wealthColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moduleTitle),
        backgroundColor: primaryColor.withValues(alpha: 0.1),
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lesson ${_currentPage + 1} of ${_lessons.length}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${((_currentPage + 1) / _lessons.length * 100).round()}%',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentPage + 1) / _lessons.length,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),
          
          // Lesson content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _lessons.length,
              itemBuilder: (context, index) {
                final lesson = _lessons[index];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Lesson icon
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              lesson['image'],
                              style: const TextStyle(fontSize: 48),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Lesson title
                      Text(
                        lesson['title'],
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Lesson content
                      Text(
                        lesson['content'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      
                      // Key points
                      Text(
                        'Key Points:',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      ...lesson['keyPoints'].map<Widget>((point) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                point,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Navigation button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _currentPage < _lessons.length - 1 ? 'Next Lesson' : 'Take Quiz',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends ConsumerStatefulWidget {
  final String moduleId;
  final String moduleTitle;
  final String category;
  
  const QuizScreen({
    super.key,
    required this.moduleId,
    required this.moduleTitle,
    required this.category,
  });

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  List<int?> _selectedAnswers = [];
  late List<Map<String, dynamic>> _questions;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _selectedAnswers = List.filled(_questions.length, null);
  }

  void _loadQuestions() {
    // Mock quiz questions based on module
    switch (widget.moduleId) {
      case 'nutrition':
        _questions = [
          {
            'question': 'What percentage of your plate should be vegetables?',
            'options': ['25%', '50%', '75%', '100%'],
            'correct': 1,
            'explanation': 'Half your plate should be filled with vegetables for optimal nutrition.'
          },
          {
            'question': 'Which macronutrient provides the most energy per gram?',
            'options': ['Carbohydrates', 'Proteins', 'Fats', 'Vitamins'],
            'correct': 2,
            'explanation': 'Fats provide 9 calories per gram, while carbs and proteins provide 4 calories per gram.'
          },
          {
            'question': 'How much water should you drink daily?',
            'options': ['4 glasses', '6 glasses', '8 glasses', '12 glasses'],
            'correct': 2,
            'explanation': '8 glasses (about 2 liters) is the recommended daily water intake for most adults.'
          }
        ];
        break;
      case 'budgeting':
        _questions = [
          {
            'question': 'In the 50-30-20 rule, what does the 20% represent?',
            'options': ['Needs', 'Wants', 'Savings', 'Taxes'],
            'correct': 2,
            'explanation': 'The 20% should go towards savings and debt repayment.'
          },
          {
            'question': 'How often should you review your budget?',
            'options': ['Daily', 'Weekly', 'Monthly', 'Yearly'],
            'correct': 2,
            'explanation': 'Monthly reviews help you stay on track and make necessary adjustments.'
          }
        ];
        break;
      case 'fitness':
        _questions = [
          {
            'question': 'How many days per week should beginners exercise?',
            'options': ['Every day', '5-6 days', '3-4 days', '1-2 days'],
            'correct': 2,
            'explanation': 'Beginners should start with 3-4 days per week to allow proper recovery between workouts.'
          },
          {
            'question': 'What is the recommended duration for beginner workouts?',
            'options': ['10-15 minutes', '20-30 minutes', '45-60 minutes', '90+ minutes'],
            'correct': 1,
            'explanation': '20-30 minutes is ideal for beginners to build consistency without overwhelming the body.'
          }
        ];
        break;
      case 'investing':
        _questions = [
          {
            'question': 'What is the power of compound interest?',
            'options': ['Simple addition', 'Earning interest on interest', 'Fixed returns', 'Tax benefits'],
            'correct': 1,
            'explanation': 'Compound interest means earning returns on both your principal and previously earned interest.'
          },
          {
            'question': 'What is diversification in investing?',
            'options': ['Buying one stock', 'Spreading investments across different assets', 'Only investing in bonds', 'Day trading'],
            'correct': 1,
            'explanation': 'Diversification means spreading investments across different asset classes to reduce risk.'
          }
        ];
        break;
      case 'sleep':
        _questions = [
          {
            'question': 'How long does a complete sleep cycle typically last?',
            'options': ['60 minutes', '90 minutes', '120 minutes', '180 minutes'],
            'correct': 1,
            'explanation': 'A complete sleep cycle lasts about 90 minutes and includes all stages of sleep.'
          },
          {
            'question': 'What is the ideal bedroom temperature for sleep?',
            'options': ['60-63°F', '65-68°F', '70-73°F', '75-78°F'],
            'correct': 1,
            'explanation': '65-68°F (18-20°C) is the optimal temperature range for quality sleep.'
          },
          {
            'question': 'When should you stop consuming caffeine for better sleep?',
            'options': ['6 PM', '4 PM', '2 PM', '12 PM'],
            'correct': 2,
            'explanation': 'Caffeine can stay in your system for 6-8 hours, so stopping by 2 PM helps ensure better sleep.'
          },
          {
            'question': 'Which sleep stage is most important for physical recovery?',
            'options': ['Light sleep', 'Deep sleep', 'REM sleep', 'All stages equally'],
            'correct': 1,
            'explanation': 'Deep sleep is when your body repairs tissues, builds bone and muscle, and strengthens immunity.'
          }
        ];
        break;
      case 'mental':
        _questions = [
          {
            'question': 'What is the difference between acute and chronic stress?',
            'options': ['No difference', 'Acute is short-term, chronic is long-term', 'Acute is worse', 'Chronic is beneficial'],
            'correct': 1,
            'explanation': 'Acute stress is short-term and can be motivating, while chronic stress is prolonged and harmful to health.'
          },
          {
            'question': 'How long should beginners meditate daily?',
            'options': ['30 minutes', '20 minutes', '10 minutes', '5 minutes'],
            'correct': 3,
            'explanation': 'Beginners should start with just 5 minutes daily to build a sustainable meditation habit.'
          },
          {
            'question': 'Which hormone is released during exercise that improves mood?',
            'options': ['Cortisol', 'Insulin', 'Endorphins', 'Adrenaline'],
            'correct': 2,
            'explanation': 'Endorphins are natural mood-boosting chemicals released during exercise.'
          },
          {
            'question': 'What is emotional resilience?',
            'options': ['Avoiding all stress', 'Never feeling sad', 'Ability to bounce back from adversity', 'Being emotionally numb'],
            'correct': 2,
            'explanation': 'Emotional resilience is the ability to adapt and recover from difficult situations and setbacks.'
          }
        ];
        break;
      case 'credit':
        _questions = [
          {
            'question': 'What credit score is considered excellent in India?',
            'options': ['Above 650', 'Above 700', 'Above 750', 'Above 800'],
            'correct': 2,
            'explanation': 'A credit score above 750 is considered excellent and qualifies for the best loan terms.'
          },
          {
            'question': 'What should your credit utilization ratio be?',
            'options': ['Below 10%', 'Below 30%', 'Below 50%', 'Below 70%'],
            'correct': 1,
            'explanation': 'Keeping credit utilization below 30% helps maintain a good credit score.'
          },
          {
            'question': 'Which factor has the biggest impact on your credit score?',
            'options': ['Credit age', 'Payment history', 'Credit mix', 'New credit'],
            'correct': 1,
            'explanation': 'Payment history accounts for about 35% of your credit score calculation.'
          },
          {
            'question': 'What type of loan typically has the lowest interest rate?',
            'options': ['Personal loan', 'Credit card', 'Home loan', 'Car loan'],
            'correct': 2,
            'explanation': 'Home loans typically have the lowest interest rates because they are secured by property.'
          }
        ];
        break;
      case 'insurance':
        _questions = [
          {
            'question': 'How much life insurance coverage should you typically have?',
            'options': ['5-7 times annual income', '10-15 times annual income', '20-25 times annual income', '1-2 times annual income'],
            'correct': 1,
            'explanation': 'Financial experts recommend life insurance coverage of 10-15 times your annual income.'
          },
          {
            'question': 'What is the main difference between term and whole life insurance?',
            'options': ['No difference', 'Term is temporary, whole life is permanent', 'Whole life is cheaper', 'Term includes investment'],
            'correct': 1,
            'explanation': 'Term insurance provides temporary coverage, while whole life insurance is permanent and includes an investment component.'
          },
          {
            'question': 'What should you look for in a health insurance plan?',
            'options': ['Lowest premium only', 'Cashless hospital network', 'Highest coverage only', 'Celebrity endorsements'],
            'correct': 1,
            'explanation': 'A good cashless hospital network is crucial for convenient claim settlement during medical emergencies.'
          },
          {
            'question': 'When is the best time to buy life insurance?',
            'options': ['After retirement', 'When you have health problems', 'When young and healthy', 'Only when married'],
            'correct': 2,
            'explanation': 'Buying life insurance when young and healthy ensures lower premiums and easier approval.'
          }
        ];
        break;
      default:
        _questions = [
          {
            'question': 'What is the key to building good habits?',
            'options': ['Perfection', 'Consistency', 'Speed', 'Complexity'],
            'correct': 1,
            'explanation': 'Consistency is more important than perfection when building habits.'
          }
        ];
    }
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[_currentQuestion] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_selectedAnswers[_currentQuestion] != null) {
      if (_selectedAnswers[_currentQuestion] == _questions[_currentQuestion]['correct']) {
        _score++;
      }
      
      if (_currentQuestion < _questions.length - 1) {
        setState(() {
          _currentQuestion++;
        });
      } else {
        setState(() {
          _showResults = true;
        });
      }
    }
  }

  void _finishQuiz() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;
      if (user != null) {
        final progressService = ref.read(progressTrackingServiceProvider);
        await progressService.saveQuizResult(
          user.id,
          widget.moduleId,
          widget.category,
          _score,
          _questions.length
        );
      }
    } catch (e) {
      print('Error saving quiz result: $e');
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Great job! You scored $_score/${_questions.length}'),
        backgroundColor: widget.category == 'health'
            ? AppTheme.healthColor
            : AppTheme.wealthColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.category == 'health'
        ? AppTheme.healthColor
        : AppTheme.wealthColor;

    if (_showResults) {
      return _buildResultsScreen(primaryColor);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.moduleTitle} Quiz'),
        backgroundColor: primaryColor.withValues(alpha: 0.1),
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(primaryColor),
          _buildQuestionContent(primaryColor),
          _buildAnswerOptions(primaryColor),
          _buildNavigationButton(primaryColor),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Question ${_currentQuestion + 1} of ${_questions.length}'),
              Text('${((_currentQuestion + 1) / _questions.length * 100).round()}%'),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentQuestion + 1) / _questions.length,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent(Color primaryColor) {
    final question = _questions[_currentQuestion];
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(Color primaryColor) {
    final question = _questions[_currentQuestion];
    final options = question['options'] as List<String>;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = _selectedAnswers[_currentQuestion] == index;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _selectAnswer(index),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: BorderSide(
                    color: isSelected ? primaryColor : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  backgroundColor: isSelected ? primaryColor.withValues(alpha: 0.1) : null,
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? primaryColor : null,
                    fontWeight: isSelected ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavigationButton(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _selectedAnswers[_currentQuestion] != null ? _nextQuestion : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            _currentQuestion < _questions.length - 1 ? 'Next Question' : 'Finish Quiz',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen(Color primaryColor) {
    final percentage = (_score / _questions.length * 100).round();
    String message;
    String emoji;
    
    if (percentage >= 80) {
      message = 'Excellent! You\'ve mastered this topic.';
      emoji = '🎉';
    } else if (percentage >= 60) {
      message = 'Good job! You\'re on the right track.';
      emoji = '👍';
    } else {
      message = 'Keep learning! Review the lessons and try again.';
      emoji = '📚';
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: primaryColor.withValues(alpha: 0.1),
        foregroundColor: primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 80)),
              const SizedBox(height: 24),
              Text(
                'Your Score',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '$_score/${_questions.length}',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _finishQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}