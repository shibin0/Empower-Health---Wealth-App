import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../services/auth_service.dart';
import '../providers/app_state_provider.dart';
import '../models/user_profile.dart';
import './main_navigation.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  bool _hasProfile = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    _authService.authStateChanges.listen((AuthState data) {
      if (mounted) {
        _checkAuthState();
      }
    });
  }

  Future<void> _checkAuthState() async {
    setState(() => _isLoading = true);
    
    try {
      final user = _authService.currentUser;
      if (user != null) {
        // Check if user has completed profile setup
        final profileData = await _authService.getUserProfile();
        if (profileData != null) {
          // Load profile into app state
          final userProfile = UserProfile.fromJson(profileData);
          ref.read(appStateProvider.notifier).updateUserProfile(userProfile);
          setState(() {
            _hasProfile = true;
            _isLoading = false;
          });
        } else {
          setState(() {
            _hasProfile = false;
            _isLoading = false;
          });
        }
      } else {
        // User not authenticated, clear profile from app state
        ref.read(appStateProvider.notifier).updateUserProfile(null);
        setState(() {
          _hasProfile = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasProfile = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final user = _authService.currentUser;
    
    if (user == null) {
      // User not authenticated, show login screen
      return const LoginScreen();
    } else if (!_hasProfile) {
      // User authenticated but no profile, show onboarding
      return const OnboardingScreen();
    } else {
      // User authenticated and has profile, show main app
      return const MainNavigation();
    }
  }
}