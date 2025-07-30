import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

// App State Model
class AppState {
  final int currentTabIndex;
  final UserProfile? userProfile;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> preferences;

  const AppState({
    this.currentTabIndex = 0,
    this.userProfile,
    this.isLoading = false,
    this.error,
    this.preferences = const {},
  });

  AppState copyWith({
    int? currentTabIndex,
    UserProfile? userProfile,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? preferences,
  }) {
    return AppState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      userProfile: userProfile ?? this.userProfile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      preferences: preferences ?? this.preferences,
    );
  }
}

// App State Notifier
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void setCurrentTab(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  void updateUserProfile(UserProfile? profile) {
    state = state.copyWith(userProfile: profile);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void updatePreferences(Map<String, dynamic> preferences) {
    state = state.copyWith(preferences: preferences);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void reset() {
    state = const AppState();
  }
}

// Provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

// Convenience providers for specific parts of the state
final currentTabProvider = Provider<int>((ref) {
  return ref.watch(appStateProvider).currentTabIndex;
});

final userProfileProvider = Provider<UserProfile?>((ref) {
  return ref.watch(appStateProvider).userProfile;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isLoading;
});

final errorProvider = Provider<String?>((ref) {
  return ref.watch(appStateProvider).error;
});

final preferencesProvider = Provider<Map<String, dynamic>>((ref) {
  return ref.watch(appStateProvider).preferences;
});