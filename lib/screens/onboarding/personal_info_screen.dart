import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../services/simple_onboarding_service.dart';
import 'goals_selection_screen.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  
  String _selectedExperienceLevel = 'Beginner';
  
  final List<String> _experienceLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  void _loadExistingData() {
    final onboardingData = ref.read(onboardingDataProvider);
    if (onboardingData != null) {
      _nameController.text = onboardingData.name;
      _ageController.text = onboardingData.age.toString();
      _cityController.text = onboardingData.city;
      _selectedExperienceLevel = onboardingData.experienceLevel;
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
          'Personal Information',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tell us about yourself',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightForeground,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Text(
                        'This helps us personalize your experience and provide better recommendations.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.lightForeground.withOpacity(0.6),
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Name field
                      const Text(
                        'What\'s your name?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Age field
                      const Text(
                        'How old are you?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter your age',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your age';
                          }
                          final age = int.tryParse(value);
                          if (age == null || age < 13 || age > 120) {
                            return 'Please enter a valid age (13-120)';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // City field
                      const Text(
                        'Where are you located?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your city',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Experience level
                      const Text(
                        'What\'s your experience level with health and wealth topics?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightForeground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Column(
                        children: _experienceLevels.map((level) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedExperienceLevel = level;
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _selectedExperienceLevel == level
                                        ? AppTheme.primaryColor
                                        : AppTheme.lightBorder,
                                    width: _selectedExperienceLevel == level ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: _selectedExperienceLevel == level
                                      ? AppTheme.primaryColor.withOpacity(0.05)
                                      : AppTheme.lightCard,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _selectedExperienceLevel == level
                                              ? AppTheme.primaryColor
                                              : AppTheme.lightBorder,
                                          width: 2,
                                        ),
                                        color: _selectedExperienceLevel == level
                                            ? AppTheme.primaryColor
                                            : Colors.transparent,
                                      ),
                                      child: _selectedExperienceLevel == level
                                          ? const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            level,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.lightForeground,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _getExperienceDescription(level),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.lightForeground.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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

  String _getExperienceDescription(String level) {
    switch (level) {
      case 'Beginner':
        return 'Just starting out, looking for basic guidance';
      case 'Intermediate':
        return 'Some knowledge, ready for more advanced topics';
      case 'Advanced':
        return 'Experienced, seeking cutting-edge strategies';
      default:
        return '';
    }
  }

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      final currentData = ref.read(onboardingDataProvider);
      if (currentData != null) {
        final updatedData = currentData.copyWith(
          name: _nameController.text.trim(),
          age: int.parse(_ageController.text.trim()),
          city: _cityController.text.trim(),
          experienceLevel: _selectedExperienceLevel,
        );
        
        ref.read(onboardingDataProvider.notifier).updateData(updatedData);
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GoalsSelectionScreen(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}