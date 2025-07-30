import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data models for community features
class CommunityUser {
  final String id;
  final String name;
  final String avatar;
  final int level;
  final int xp;
  final String status; // 'online', 'offline', 'away'
  final List<String> interests;
  final Map<String, dynamic> stats;
  final DateTime lastActive;

  const CommunityUser({
    required this.id,
    required this.name,
    required this.avatar,
    required this.level,
    required this.xp,
    required this.status,
    required this.interests,
    required this.stats,
    required this.lastActive,
  });
}

class CommunityGroup {
  final String id;
  final String name;
  final String description;
  final String category; // 'health', 'wealth', 'mixed'
  final String type; // 'goal_based', 'interest_based', 'challenge'
  final String privacy; // 'public', 'private', 'invite_only'
  final List<String> memberIds;
  final String creatorId;
  final DateTime createdAt;
  final Map<String, dynamic> groupGoal;
  final List<String> tags;
  final String coverImage;
  final bool isActive;

  const CommunityGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.type,
    required this.privacy,
    required this.memberIds,
    required this.creatorId,
    required this.createdAt,
    required this.groupGoal,
    required this.tags,
    required this.coverImage,
    required this.isActive,
  });
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final String category;
  final String type; // 'individual', 'group', 'global'
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, dynamic> goal;
  final List<String> participantIds;
  final Map<String, dynamic> rewards;
  final String difficulty; // 'easy', 'medium', 'hard'
  final bool isActive;
  final String creatorId;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.goal,
    required this.participantIds,
    required this.rewards,
    required this.difficulty,
    required this.isActive,
    required this.creatorId,
  });
}

class SocialPost {
  final String id;
  final String authorId;
  final String content;
  final String type; // 'achievement', 'progress', 'tip', 'question'
  final Map<String, dynamic> attachments;
  final List<String> likes;
  final List<SocialComment> comments;
  final List<String> tags;
  final DateTime createdAt;
  final bool isPublic;
  final String? groupId;

  const SocialPost({
    required this.id,
    required this.authorId,
    required this.content,
    required this.type,
    required this.attachments,
    required this.likes,
    required this.comments,
    required this.tags,
    required this.createdAt,
    required this.isPublic,
    this.groupId,
  });
}

class SocialComment {
  final String id;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final List<String> likes;

  const SocialComment({
    required this.id,
    required this.authorId,
    required this.content,
    required this.createdAt,
    required this.likes,
  });
}

class Leaderboard {
  final String id;
  final String title;
  final String category;
  final String timeframe; // 'daily', 'weekly', 'monthly', 'all_time'
  final List<LeaderboardEntry> entries;
  final DateTime lastUpdated;

  const Leaderboard({
    required this.id,
    required this.title,
    required this.category,
    required this.timeframe,
    required this.entries,
    required this.lastUpdated,
  });
}

class LeaderboardEntry {
  final String userId;
  final String userName;
  final String avatar;
  final int rank;
  final double score;
  final Map<String, dynamic> stats;

  const LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.rank,
    required this.score,
    required this.stats,
  });
}

class CommunityService {
  // Mock data for community features
  static const List<CommunityUser> _mockUsers = [
    CommunityUser(
      id: 'user1',
      name: 'Sarah Johnson',
      avatar: '👩‍💼',
      level: 15,
      xp: 2450,
      status: 'online',
      interests: ['fitness', 'investing', 'nutrition'],
      stats: {
        'completedGoals': 12,
        'streakDays': 45,
        'totalXP': 2450,
        'helpfulPosts': 23,
      },
      lastActive: DateTime.now(),
    ),
    CommunityUser(
      id: 'user2',
      name: 'Mike Chen',
      avatar: '👨‍💻',
      level: 12,
      xp: 1890,
      status: 'online',
      interests: ['budgeting', 'mental_health', 'sleep'],
      stats: {
        'completedGoals': 8,
        'streakDays': 32,
        'totalXP': 1890,
        'helpfulPosts': 15,
      },
      lastActive: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    CommunityUser(
      id: 'user3',
      name: 'Emma Davis',
      avatar: '👩‍🎓',
      level: 18,
      xp: 3200,
      status: 'away',
      interests: ['nutrition', 'investing', 'fitness'],
      stats: {
        'completedGoals': 20,
        'streakDays': 67,
        'totalXP': 3200,
        'helpfulPosts': 41,
      },
      lastActive: DateTime.now().subtract(Duration(hours: 2)),
    ),
    CommunityUser(
      id: 'user4',
      name: 'Alex Rodriguez',
      avatar: '👨‍⚕️',
      level: 10,
      xp: 1520,
      status: 'offline',
      interests: ['mental_health', 'budgeting', 'sleep'],
      stats: {
        'completedGoals': 6,
        'streakDays': 28,
        'totalXP': 1520,
        'helpfulPosts': 9,
      },
      lastActive: DateTime.now().subtract(Duration(hours: 8)),
    ),
  ];

  static const List<CommunityGroup> _mockGroups = [
    CommunityGroup(
      id: 'group1',
      name: 'Fitness Warriors',
      description: 'A community dedicated to achieving fitness goals together',
      category: 'health',
      type: 'goal_based',
      privacy: 'public',
      memberIds: ['user1', 'user2', 'user3'],
      creatorId: 'user1',
      createdAt: DateTime(2024, 1, 15),
      groupGoal: {
        'type': 'fitness',
        'target': 'Complete 30 workouts in 30 days',
        'progress': 0.75,
      },
      tags: ['fitness', 'workout', 'health'],
      coverImage: '🏋️‍♀️',
      isActive: true,
    ),
    CommunityGroup(
      id: 'group2',
      name: 'Investment Club',
      description: 'Learn and grow wealth together through smart investing',
      category: 'wealth',
      type: 'interest_based',
      privacy: 'public',
      memberIds: ['user1', 'user3', 'user4'],
      creatorId: 'user3',
      createdAt: DateTime(2024, 1, 20),
      groupGoal: {
        'type': 'investment',
        'target': 'Learn 5 investment strategies',
        'progress': 0.6,
      },
      tags: ['investing', 'wealth', 'finance'],
      coverImage: '📈',
      isActive: true,
    ),
    CommunityGroup(
      id: 'group3',
      name: 'Mindful Living',
      description: 'Focus on mental health and mindful practices',
      category: 'health',
      type: 'interest_based',
      privacy: 'public',
      memberIds: ['user2', 'user4'],
      creatorId: 'user2',
      createdAt: DateTime(2024, 1, 25),
      groupGoal: {
        'type': 'mindfulness',
        'target': 'Practice meditation daily for 21 days',
        'progress': 0.4,
      },
      tags: ['mental_health', 'meditation', 'wellness'],
      coverImage: '🧘‍♀️',
      isActive: true,
    ),
  ];

  static const List<Challenge> _mockChallenges = [
    Challenge(
      id: 'challenge1',
      title: '30-Day Fitness Challenge',
      description: 'Complete 30 workouts in 30 days',
      category: 'health',
      type: 'global',
      startDate: DateTime(2024, 2, 1),
      endDate: DateTime(2024, 3, 2),
      goal: {
        'type': 'workout_count',
        'target': 30,
        'unit': 'workouts',
      },
      participantIds: ['user1', 'user2', 'user3'],
      rewards: {
        'xp': 500,
        'badge': 'Fitness Champion',
        'title': 'Workout Warrior',
      },
      difficulty: 'medium',
      isActive: true,
      creatorId: 'admin',
    ),
    Challenge(
      id: 'challenge2',
      title: 'Save $1000 Challenge',
      description: 'Save $1000 in 3 months through smart budgeting',
      category: 'wealth',
      type: 'global',
      startDate: DateTime(2024, 2, 1),
      endDate: DateTime(2024, 5, 1),
      goal: {
        'type': 'savings',
        'target': 1000,
        'unit': 'dollars',
      },
      participantIds: ['user1', 'user3', 'user4'],
      rewards: {
        'xp': 750,
        'badge': 'Savings Master',
        'title': 'Budget Boss',
      },
      difficulty: 'hard',
      isActive: true,
      creatorId: 'admin',
    ),
    Challenge(
      id: 'challenge3',
      title: 'Mindful February',
      description: 'Practice mindfulness every day in February',
      category: 'health',
      type: 'group',
      startDate: DateTime(2024, 2, 1),
      endDate: DateTime(2024, 2, 29),
      goal: {
        'type': 'mindfulness',
        'target': 28,
        'unit': 'days',
      },
      participantIds: ['user2', 'user4'],
      rewards: {
        'xp': 300,
        'badge': 'Mindful Soul',
        'title': 'Zen Master',
      },
      difficulty: 'easy',
      isActive: true,
      creatorId: 'user2',
    ),
  ];

  static const List<SocialPost> _mockPosts = [
    SocialPost(
      id: 'post1',
      authorId: 'user1',
      content: 'Just completed my 45th day streak! 🔥 The key is consistency, not perfection. Small daily actions lead to big results!',
      type: 'achievement',
      attachments: {
        'image': '🏆',
        'achievement': 'Streak Master',
      },
      likes: ['user2', 'user3', 'user4'],
      comments: [
        SocialComment(
          id: 'comment1',
          authorId: 'user2',
          content: 'Amazing! What\'s your secret?',
          createdAt: DateTime.now().subtract(Duration(hours: 2)),
          likes: ['user1'],
        ),
        SocialComment(
          id: 'comment2',
          authorId: 'user3',
          content: 'So inspiring! Keep it up! 💪',
          createdAt: DateTime.now().subtract(Duration(hours: 1)),
          likes: ['user1', 'user2'],
        ),
      ],
      tags: ['streak', 'motivation', 'achievement'],
      createdAt: DateTime.now().subtract(Duration(hours: 3)),
      isPublic: true,
    ),
    SocialPost(
      id: 'post2',
      authorId: 'user3',
      content: 'Pro tip: Start your investment journey with index funds. They\'re diversified, low-cost, and perfect for beginners! 📊',
      type: 'tip',
      attachments: {
        'tip_category': 'investing',
        'difficulty': 'beginner',
      },
      likes: ['user1', 'user4'],
      comments: [
        SocialComment(
          id: 'comment3',
          authorId: 'user4',
          content: 'Thanks for the tip! Any specific funds you recommend?',
          createdAt: DateTime.now().subtract(Duration(minutes: 30)),
          likes: ['user3'],
        ),
      ],
      tags: ['investing', 'tips', 'beginner'],
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
      isPublic: true,
    ),
    SocialPost(
      id: 'post3',
      authorId: 'user2',
      content: 'Week 2 of meditation complete! 🧘‍♂️ My stress levels have noticeably decreased. Highly recommend the Mindful Living group!',
      type: 'progress',
      attachments: {
        'progress_type': 'meditation',
        'week': 2,
      },
      likes: ['user1', 'user3'],
      comments: [],
      tags: ['meditation', 'progress', 'mental_health'],
      createdAt: DateTime.now().subtract(Duration(hours: 8)),
      isPublic: true,
      groupId: 'group3',
    ),
  ];

  // Get community groups
  static Future<List<CommunityGroup>> getCommunityGroups({
    String? category,
    String? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var groups = _mockGroups.where((group) => group.isActive).toList();

    if (category != null) {
      groups = groups.where((group) => group.category == category).toList();
    }

    if (type != null) {
      groups = groups.where((group) => group.type == type).toList();
    }

    return groups;
  }

  // Get user's groups
  static Future<List<CommunityGroup>> getUserGroups(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _mockGroups.where((group) =>
      group.memberIds.contains(userId) && group.isActive).toList();
  }

  // Get active challenges
  static Future<List<Challenge>> getActiveChallenges({
    String? category,
    String? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    var challenges = _mockChallenges.where((challenge) => challenge.isActive).toList();

    if (category != null) {
      challenges = challenges.where((challenge) => challenge.category == category).toList();
    }

    if (type != null) {
      challenges = challenges.where((challenge) => challenge.type == type).toList();
    }

    return challenges;
  }

  // Get user's challenges
  static Future<List<Challenge>> getUserChallenges(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _mockChallenges.where((challenge) =>
      challenge.participantIds.contains(userId) && challenge.isActive).toList();
  }

  // Get social feed
  static Future<List<SocialPost>> getSocialFeed({
    String? userId,
    String? groupId,
    String? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    var posts = _mockPosts.where((post) => post.isPublic).toList();

    if (groupId != null) {
      posts = posts.where((post) => post.groupId == groupId).toList();
    }

    if (type != null) {
      posts = posts.where((post) => post.type == type).toList();
    }

    // Sort by creation date (newest first)
    posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return posts;
  }

  // Get leaderboards
  static Future<List<Leaderboard>> getLeaderboards({
    String? category,
    String? timeframe,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate mock leaderboards
    final leaderboards = <Leaderboard>[];

    // XP Leaderboard
    final xpEntries = _mockUsers.map((user) => LeaderboardEntry(
      userId: user.id,
      userName: user.name,
      avatar: user.avatar,
      rank: 0, // Will be set after sorting
      score: user.xp.toDouble(),
      stats: user.stats,
    )).toList();

    xpEntries.sort((a, b) => b.score.compareTo(a.score));
    for (int i = 0; i < xpEntries.length; i++) {
      xpEntries[i] = LeaderboardEntry(
        userId: xpEntries[i].userId,
        userName: xpEntries[i].userName,
        avatar: xpEntries[i].avatar,
        rank: i + 1,
        score: xpEntries[i].score,
        stats: xpEntries[i].stats,
      );
    }

    leaderboards.add(Leaderboard(
      id: 'xp_weekly',
      title: 'Weekly XP Leaders',
      category: 'overall',
      timeframe: 'weekly',
      entries: xpEntries,
      lastUpdated: DateTime.now(),
    ));

    // Streak Leaderboard
    final streakEntries = _mockUsers.map((user) => LeaderboardEntry(
      userId: user.id,
      userName: user.name,
      avatar: user.avatar,
      rank: 0,
      score: (user.stats['streakDays'] as int).toDouble(),
      stats: user.stats,
    )).toList();

    streakEntries.sort((a, b) => b.score.compareTo(a.score));
    for (int i = 0; i < streakEntries.length; i++) {
      streakEntries[i] = LeaderboardEntry(
        userId: streakEntries[i].userId,
        userName: streakEntries[i].userName,
        avatar: streakEntries[i].avatar,
        rank: i + 1,
        score: streakEntries[i].score,
        stats: streakEntries[i].stats,
      );
    }

    leaderboards.add(Leaderboard(
      id: 'streak_monthly',
      title: 'Monthly Streak Champions',
      category: 'overall',
      timeframe: 'monthly',
      entries: streakEntries,
      lastUpdated: DateTime.now(),
    ));

    return leaderboards;
  }

  // Get community users
  static Future<List<CommunityUser>> getCommunityUsers({
    String? status,
    List<String>? interests,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    var users = _mockUsers.toList();

    if (status != null) {
      users = users.where((user) => user.status == status).toList();
    }

    if (interests != null && interests.isNotEmpty) {
      users = users.where((user) =>
        user.interests.any((interest) => interests.contains(interest))).toList();
    }

    return users;
  }

  // Join group
  static Future<bool> joinGroup(String userId, String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would update the database
    return true;
  }

  // Leave group
  static Future<bool> leaveGroup(String userId, String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would update the database
    return true;
  }

  // Join challenge
  static Future<bool> joinChallenge(String userId, String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would update the database
    return true;
  }

  // Create post
  static Future<bool> createPost({
    required String authorId,
    required String content,
    required String type,
    Map<String, dynamic>? attachments,
    List<String>? tags,
    String? groupId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would create a new post in the database
    return true;
  }

  // Like post
  static Future<bool> likePost(String userId, String postId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // In a real app, this would update the post's likes
    return true;
  }

  // Add comment
  static Future<bool> addComment({
    required String authorId,
    required String postId,
    required String content,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would add a comment to the database
    return true;
  }

  // Get group details
  static Future<CommunityGroup?> getGroupDetails(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return _mockGroups.firstWhere((group) => group.id == groupId);
    } catch (e) {
      return null;
    }
  }

  // Get challenge details
  static Future<Challenge?> getChallengeDetails(String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return _mockChallenges.firstWhere((challenge) => challenge.id == challengeId);
    } catch (e) {
      return null;
    }
  }

  // Get user details
  static Future<CommunityUser?> getUserDetails(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _mockUsers.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Search groups
  static Future<List<CommunityGroup>> searchGroups(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final lowercaseQuery = query.toLowerCase();
    return _mockGroups.where((group) =>
      group.name.toLowerCase().contains(lowercaseQuery) ||
      group.description.toLowerCase().contains(lowercaseQuery) ||
      group.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery))
    ).toList();
  }

  // Get trending topics
  static Future<List<String>> getTrendingTopics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      'fitness',
      'investing',
      'meditation',
      'budgeting',
      'nutrition',
      'mental_health',
      'savings',
      'workout',
    ];
  }

  // Get community stats
  static Future<Map<String, dynamic>> getCommunityStats() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return {
      'totalUsers': _mockUsers.length,
      'activeGroups': _mockGroups.where((g) => g.isActive).length,
      'activeChallenges': _mockChallenges.where((c) => c.isActive).length,
      'totalPosts': _mockPosts.length,
      'onlineUsers': _mockUsers.where((u) => u.status == 'online').length,
    };
  }
}

// Riverpod providers for community features
final communityGroupsProvider = FutureProvider.family<List<CommunityGroup>, ({String? category, String? type})>((ref, params) async {
  return CommunityService.getCommunityGroups(
    category: params.category,
    type: params.type,
  );
});

final userGroupsProvider = FutureProvider.family<List<CommunityGroup>, String>((ref, userId) async {
  return CommunityService.getUserGroups(userId);
});

final activeChallengesProvider = FutureProvider.family<List<Challenge>, ({String? category, String? type})>((ref, params) async {
  return CommunityService.getActiveChallenges(
    category: params.category,
    type: params.type,
  );
});

final userChallengesProvider = FutureProvider.family<List<Challenge>, String>((ref, userId) async {
  return CommunityService.getUserChallenges(userId);
});

final socialFeedProvider = FutureProvider.family<List<SocialPost>, ({String? userId, String? groupId, String? type})>((ref, params) async {
  return CommunityService.getSocialFeed(
    userId: params.userId,
    groupId: params.groupId,
    type: params.type,
  );
});

final leaderboardsProvider = FutureProvider.family<List<Leaderboard>, ({String? category, String? timeframe})>((ref, params) async {
  return CommunityService.getLeaderboards(
    category: params.category,
    timeframe: params.timeframe,
  );
});

final communityUsersProvider = FutureProvider.family<List<CommunityUser>, ({String? status, List<String>? interests})>((ref, params) async {
  return CommunityService.getCommunityUsers(
    status: params.status,
    interests: params.interests,
  );
});

final communityStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return CommunityService.getCommunityStats();
});

final trendingTopicsProvider = FutureProvider<List<String>>((ref) async {
  return CommunityService.getTrendingTopics();
});