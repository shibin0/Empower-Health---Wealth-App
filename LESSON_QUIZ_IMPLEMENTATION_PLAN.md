# Lesson and Quiz Flow Implementation Plan

## Overview
This document outlines the complete implementation plan for building functional lesson and quiz flows in the Empower Health & Wealth App. The goal is to make the "Continue Learning" buttons in health and wealth screens fully functional with a complete learning experience.

## Current State Analysis

### ✅ What's Working
- **LessonScreen Class**: Complete implementation with:
  - Page-based lesson navigation
  - Progress tracking
  - Rich content display with key points
  - Proper theming for health/wealth categories
  - Lesson content for: nutrition, fitness, budgeting, investing

### ❌ What's Broken/Missing
- **QuizScreen Class**: Incomplete build method (cuts off at line 473)
- **Health Screen**: "Continue Learning" buttons have empty `onPressed: () {}` handlers
- **Wealth Screen**: "Continue Learning" buttons have empty `onPressed: () {}` handlers
- **Module Mapping**: No connection between screen modules and lesson moduleIds
- **Missing Content**: No lessons for Sleep & Recovery, Mental Wellness, Credit & Loans, Insurance Planning

## Implementation Strategy

### Phase 1: Complete QuizScreen Implementation
**Priority: Critical**

#### Current QuizScreen State
```dart
// Lines 350-473 in lesson_screen.dart
class QuizScreen extends StatefulWidget {
  // Constructor and state variables are complete
  // _loadQuestions() method is complete
  // Helper methods (_selectAnswer, _nextQuestion, _finishQuiz) are complete
  // build() method is INCOMPLETE - cuts off at line 473
}
```

#### Required QuizScreen Build Method Implementation
```dart
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
```

#### Required Helper Methods
- `_buildResultsScreen()`: Display final score and feedback
- `_buildProgressIndicator()`: Show question progress
- `_buildQuestionContent()`: Display current question
- `_buildAnswerOptions()`: Show selectable answers
- `_buildNavigationButton()`: Next/Submit button

### Phase 2: Module ID Mapping System
**Priority: High**

#### Health Screen Module Mapping
```dart
// In health_screen.dart _buildLearnTab()
final moduleMapping = {
  'Nutrition Basics': {
    'moduleId': 'nutrition',
    'hasContent': true,
  },
  'Home Workouts': {
    'moduleId': 'fitness', 
    'hasContent': true,
  },
  'Sleep & Recovery': {
    'moduleId': 'sleep',
    'hasContent': false, // Coming soon
  },
  'Mental Wellness': {
    'moduleId': 'mental',
    'hasContent': false, // Coming soon
  },
};
```

#### Wealth Screen Module Mapping
```dart
// In wealth_screen.dart _buildLearnTab()
final moduleMapping = {
  'Smart Budgeting': {
    'moduleId': 'budgeting',
    'hasContent': true,
  },
  'Investment Basics': {
    'moduleId': 'investing',
    'hasContent': true,
  },
  'Credit & Loans': {
    'moduleId': 'credit',
    'hasContent': false, // Coming soon
  },
  'Insurance Planning': {
    'moduleId': 'insurance',
    'hasContent': false, // Coming soon
  },
};
```

### Phase 3: Navigation Implementation
**Priority: High**

#### Update Health Screen Navigation
```dart
// Replace empty onPressed: () {} with:
onPressed: () {
  final mapping = moduleMapping[module['title']];
  if (mapping['hasContent']) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonScreen(
          moduleId: mapping['moduleId'],
          moduleTitle: module['title'],
          category: 'health',
        ),
      ),
    );
  } else {
    _showComingSoonDialog();
  }
},
```

#### Update Wealth Screen Navigation
```dart
// Similar implementation for wealth screen with category: 'wealth'
```

### Phase 4: Enhanced Content Creation
**Priority: Medium**

#### Add Missing Lesson Content
Create lesson content for modules without current implementation:

**Sleep & Recovery Module**
```dart
case 'sleep':
  _lessons = [
    {
      'title': 'Sleep Science Basics',
      'content': 'Understanding sleep cycles and why quality sleep matters...',
      'image': '😴',
      'keyPoints': [
        'Adults need 7-9 hours of sleep nightly',
        'Sleep has 4 stages including REM',
        'Consistent sleep schedule improves quality',
        'Blue light affects melatonin production'
      ]
    },
    // Additional lessons...
  ];
```

**Mental Wellness Module**
```dart
case 'mental':
  _lessons = [
    {
      'title': 'Stress Management Fundamentals',
      'content': 'Learn practical techniques to manage daily stress...',
      'image': '🧘',
      'keyPoints': [
        'Identify your stress triggers',
        'Practice deep breathing exercises',
        'Regular exercise reduces stress hormones',
        'Mindfulness improves emotional regulation'
      ]
    },
    // Additional lessons...
  ];
```

**Credit & Loans Module**
```dart
case 'credit':
  _lessons = [
    {
      'title': 'Understanding Credit Scores',
      'content': 'Your credit score affects loan approvals and interest rates...',
      'image': '📊',
      'keyPoints': [
        'Credit scores range from 300-850',
        'Payment history is 35% of your score',
        'Keep credit utilization below 30%',
        'Check your credit report annually'
      ]
    },
    // Additional lessons...
  ];
```

**Insurance Planning Module**
```dart
case 'insurance':
  _lessons = [
    {
      'title': 'Insurance Basics',
      'content': 'Protect your wealth with the right insurance coverage...',
      'image': '🛡️',
      'keyPoints': [
        'Life insurance replaces lost income',
        'Health insurance covers medical expenses',
        'Term insurance is cheaper than whole life',
        'Review coverage annually'
      ]
    },
    // Additional lessons...
  ];
```

### Phase 5: Progress Tracking & Persistence
**Priority: Medium**

#### Add Progress Tracking
```dart
// In lesson completion
void _completeLesson() {
  // Save lesson completion to local storage
  _saveProgress(widget.moduleId, 'lesson_completed');
  
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
```

#### Add Quiz Result Persistence
```dart
// In quiz completion
void _finishQuiz() {
  final percentage = (_score / _questions.length * 100).round();
  
  // Save quiz results
  _saveProgress(widget.moduleId, 'quiz_completed', {
    'score': _score,
    'total': _questions.length,
    'percentage': percentage,
    'completedAt': DateTime.now().toIso8601String(),
  });
  
  // Update module progress in health/wealth screens
  _updateModuleProgress(widget.moduleId, percentage);
  
  Navigator.of(context).pop();
  _showCompletionSnackBar();
}
```

### Phase 6: Enhanced User Experience
**Priority: Low**

#### Add Achievement System
```dart
// Unlock achievements based on quiz performance
if (percentage >= 80) {
  _unlockAchievement('${widget.moduleId}_master');
} else if (percentage >= 60) {
  _unlockAchievement('${widget.moduleId}_learner');
}
```

#### Add Coming Soon Dialog
```dart
void _showComingSoonDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Coming Soon'),
      content: const Text('This module is under development. Stay tuned for updates!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
```

## Implementation Timeline

### Immediate (Phase 1)
1. **Complete QuizScreen build method** - Fix the incomplete implementation
2. **Test basic quiz functionality** - Ensure questions display and answers work

### Short Term (Phase 2-3)
3. **Add module mapping** - Connect screen modules to lesson moduleIds
4. **Update navigation handlers** - Make "Continue Learning" buttons functional
5. **Test complete flow** - Health → Lesson → Quiz → Return

### Medium Term (Phase 4-5)
6. **Add missing lesson content** - Create content for all 8 modules
7. **Implement progress tracking** - Save completion status locally
8. **Add quiz result persistence** - Track scores and progress

### Long Term (Phase 6)
9. **Enhanced UX features** - Achievements, better feedback, animations
10. **Integration with backend** - Sync progress to Supabase
11. **Social features** - Share achievements, compare progress

## Technical Considerations

### Navigation Flow
```
Health/Wealth Screen → LessonScreen → QuizScreen → Results → Back to Main
```

### State Management
- Use local state for lesson/quiz progress within sessions
- Persist completion data using SharedPreferences or Hive
- Update main screen progress indicators

### Error Handling
- Handle missing lesson content gracefully
- Provide fallback for network issues
- Validate quiz answers before submission

### Performance
- Lazy load lesson content
- Cache quiz questions
- Optimize image/emoji rendering

## Testing Strategy

### Unit Tests
- Test lesson content loading
- Test quiz scoring logic
- Test progress calculation

### Integration Tests
- Test complete learning flow
- Test navigation between screens
- Test progress persistence

### User Acceptance Tests
- Verify all "Continue Learning" buttons work
- Confirm quiz results are accurate
- Validate progress tracking updates

## Success Criteria

### Functional Requirements
- ✅ All "Continue Learning" buttons navigate to lessons
- ✅ Lessons display properly with navigation
- ✅ Quizzes show questions and accept answers
- ✅ Quiz results display with scores
- ✅ Progress tracking works correctly

### User Experience Requirements
- ✅ Smooth navigation between screens
- ✅ Clear progress indicators
- ✅ Appropriate feedback for quiz completion
- ✅ Consistent theming (health = green, wealth = blue)

### Technical Requirements
- ✅ No runtime errors or crashes
- ✅ Proper state management
- ✅ Efficient memory usage
- ✅ Clean, maintainable code

## Next Steps

1. **Switch to Code mode** to begin implementation
2. **Start with Phase 1** - Complete QuizScreen build method
3. **Test incrementally** - Verify each phase before proceeding
4. **Document changes** - Update implementation summary as we progress

This plan provides a comprehensive roadmap for implementing fully functional lesson and quiz flows that will make the learning modules in the Empower Health & Wealth App truly interactive and engaging.