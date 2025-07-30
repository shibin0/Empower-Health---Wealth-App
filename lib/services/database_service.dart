import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/user_profile.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final SupabaseClient _supabase = SupabaseConfig.client;

  // User Profile Operations
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return UserProfile.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> createUserProfile(UserProfile profile) async {
    try {
      await _supabase.from('profiles').insert(profile.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    if (profile.id == null) throw Exception('Profile ID cannot be null');
    try {
      await _supabase
          .from('profiles')
          .update(profile.toJson())
          .eq('id', profile.id!);
    } catch (e) {
      rethrow;
    }
  }

  // Health Goals Operations
  Future<List<Map<String, dynamic>>> getHealthGoals(String userId) async {
    try {
      final response = await _supabase
          .from('health_goals')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> createHealthGoal(Map<String, dynamic> goal) async {
    try {
      await _supabase.from('health_goals').insert(goal);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateHealthGoal(String goalId, Map<String, dynamic> updates) async {
    try {
      await _supabase
          .from('health_goals')
          .update(updates)
          .eq('id', goalId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteHealthGoal(String goalId) async {
    try {
      await _supabase.from('health_goals').delete().eq('id', goalId);
    } catch (e) {
      rethrow;
    }
  }

  // Wealth Goals Operations
  Future<List<Map<String, dynamic>>> getWealthGoals(String userId) async {
    try {
      final response = await _supabase
          .from('wealth_goals')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> createWealthGoal(Map<String, dynamic> goal) async {
    try {
      await _supabase.from('wealth_goals').insert(goal);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWealthGoal(String goalId, Map<String, dynamic> updates) async {
    try {
      await _supabase
          .from('wealth_goals')
          .update(updates)
          .eq('id', goalId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWealthGoal(String goalId) async {
    try {
      await _supabase.from('wealth_goals').delete().eq('id', goalId);
    } catch (e) {
      rethrow;
    }
  }

  // Daily Tasks Operations
  Future<List<Map<String, dynamic>>> getDailyTasks(String userId, DateTime date) async {
    try {
      final dateStr = date.toIso8601String().split('T')[0];
      final response = await _supabase
          .from('daily_tasks')
          .select()
          .eq('user_id', userId)
          .eq('date', dateStr)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> createDailyTask(Map<String, dynamic> task) async {
    try {
      await _supabase.from('daily_tasks').insert(task);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDailyTask(String taskId, Map<String, dynamic> updates) async {
    try {
      await _supabase
          .from('daily_tasks')
          .update(updates)
          .eq('id', taskId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markTaskCompleted(String taskId, bool completed) async {
    try {
      await _supabase
          .from('daily_tasks')
          .update({
            'completed': completed,
            'completed_at': completed ? DateTime.now().toIso8601String() : null,
          })
          .eq('id', taskId);
    } catch (e) {
      rethrow;
    }
  }

  // Achievements Operations
  Future<List<Map<String, dynamic>>> getUserAchievements(String userId) async {
    try {
      final response = await _supabase
          .from('user_achievements')
          .select('''
            *,
            achievements (
              id,
              title,
              description,
              icon,
              category,
              points
            )
          ''')
          .eq('user_id', userId)
          .order('earned_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> awardAchievement(String userId, String achievementId) async {
    try {
      await _supabase.from('user_achievements').insert({
        'user_id': userId,
        'achievement_id': achievementId,
        'earned_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Progress Tracking Operations
  Future<List<Map<String, dynamic>>> getProgressEntries(
    String userId,
    String category,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    try {
      var query = _supabase
          .from('progress_entries')
          .select()
          .eq('user_id', userId)
          .eq('category', category);

      if (startDate != null) {
        query = query.gte('date', startDate.toIso8601String().split('T')[0]);
      }
      if (endDate != null) {
        query = query.lte('date', endDate.toIso8601String().split('T')[0]);
      }

      final response = await query.order('date', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> createProgressEntry(Map<String, dynamic> entry) async {
    try {
      await _supabase.from('progress_entries').insert(entry);
    } catch (e) {
      rethrow;
    }
  }

  // Statistics Operations
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      // Get completion rates, streaks, and other statistics
      final healthGoalsResponse = await _supabase
          .from('health_goals')
          .select('*')
          .eq('user_id', userId);

      final wealthGoalsResponse = await _supabase
          .from('wealth_goals')
          .select('*')
          .eq('user_id', userId);

      final completedTasksResponse = await _supabase
          .from('daily_tasks')
          .select('*')
          .eq('user_id', userId)
          .eq('completed', true);

      final totalTasksResponse = await _supabase
          .from('daily_tasks')
          .select('*')
          .eq('user_id', userId);

      final achievementsResponse = await _supabase
          .from('user_achievements')
          .select('*')
          .eq('user_id', userId);

      final healthGoalsCount = healthGoalsResponse.length;
      final wealthGoalsCount = wealthGoalsResponse.length;
      final completedTasksCount = completedTasksResponse.length;
      final totalTasksCount = totalTasksResponse.length;
      final achievementsCount = achievementsResponse.length;

      return {
        'health_goals_count': healthGoalsCount,
        'wealth_goals_count': wealthGoalsCount,
        'completed_tasks_count': completedTasksCount,
        'total_tasks_count': totalTasksCount,
        'achievements_count': achievementsCount,
        'completion_rate': totalTasksCount > 0
            ? (completedTasksCount / totalTasksCount) * 100
            : 0.0,
      };
    } catch (e) {
      return {};
    }
  }
}