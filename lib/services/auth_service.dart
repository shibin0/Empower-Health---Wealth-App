import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final SupabaseClient _supabase = SupabaseConfig.client;

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  // Get current session
  Session? get currentSession => _supabase.auth.currentSession;

  // Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  // Update user metadata
  Future<UserResponse> updateUser({
    Map<String, dynamic>? data,
    String? email,
    String? password,
  }) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(
          data: data,
          email: email,
          password: password,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Get user profile data
  Future<Map<String, dynamic>?> getUserProfile() async {
    if (!isAuthenticated) return null;
    
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', currentUser!.id)
          .single();
      return response;
    } catch (e) {
      // If profile doesn't exist, create a basic one
      try {
        await createUserProfile();
        // Try to fetch again
        final response = await _supabase
            .from('profiles')
            .select()
            .eq('id', currentUser!.id)
            .single();
        return response;
      } catch (createError) {
        print('Error creating/fetching profile: $createError');
        return null;
      }
    }
  }

  // Create a basic user profile
  Future<void> createUserProfile() async {
    if (!isAuthenticated) throw Exception('User not authenticated');
    
    try {
      await _supabase
          .from('profiles')
          .insert({
            'id': currentUser!.id,
            'name': currentUser!.email?.split('@')[0] ?? 'User',
            'age': '',
            'city': '',
            'primary_goals': [],
            'health_goal': '',
            'wealth_goal': '',
            'current_level': 'Beginner',
            'xp': 0,
            'level': 1,
            'streak': 0,
            'badges': [],
            'joined_date': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      print('Error creating profile: $e');
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateUserProfile(Map<String, dynamic> profileData) async {
    if (!isAuthenticated) throw Exception('User not authenticated');
    
    try {
      await _supabase
          .from('profiles')
          .upsert({
            'id': currentUser!.id,
            ...profileData,
            'updated_at': DateTime.now().toIso8601String(),
          });
    } catch (e) {
      rethrow;
    }
  }
}