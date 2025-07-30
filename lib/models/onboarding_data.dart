class OnboardingData {
  final String name;
  final int age;
  final String city;
  final List<String> primaryGoals;
  final String healthGoal;
  final String wealthGoal;
  final String experienceLevel;
  final List<String> interests;
  final Map<String, bool> preferences;

  OnboardingData({
    required this.name,
    required this.age,
    required this.city,
    required this.primaryGoals,
    required this.healthGoal,
    required this.wealthGoal,
    required this.experienceLevel,
    required this.interests,
    required this.preferences,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'city': city,
    'primaryGoals': primaryGoals,
    'healthGoal': healthGoal,
    'wealthGoal': wealthGoal,
    'experienceLevel': experienceLevel,
    'interests': interests,
    'preferences': preferences,
  };

  factory OnboardingData.fromJson(Map<String, dynamic> json) => OnboardingData(
    name: json['name'] ?? '',
    age: json['age'] ?? 25,
    city: json['city'] ?? '',
    primaryGoals: List<String>.from(json['primaryGoals'] ?? []),
    healthGoal: json['healthGoal'] ?? '',
    wealthGoal: json['wealthGoal'] ?? '',
    experienceLevel: json['experienceLevel'] ?? 'Beginner',
    interests: List<String>.from(json['interests'] ?? []),
    preferences: Map<String, bool>.from(json['preferences'] ?? {}),
  );

  OnboardingData copyWith({
    String? name,
    int? age,
    String? city,
    List<String>? primaryGoals,
    String? healthGoal,
    String? wealthGoal,
    String? experienceLevel,
    List<String>? interests,
    Map<String, bool>? preferences,
  }) {
    return OnboardingData(
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      primaryGoals: primaryGoals ?? this.primaryGoals,
      healthGoal: healthGoal ?? this.healthGoal,
      wealthGoal: wealthGoal ?? this.wealthGoal,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      interests: interests ?? this.interests,
      preferences: preferences ?? this.preferences,
    );
  }
}

class OnboardingStep {
  final String title;
  final String subtitle;
  final String description;
  final String iconPath;
  final List<String> benefits;

  OnboardingStep({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.iconPath,
    required this.benefits,
  });
}