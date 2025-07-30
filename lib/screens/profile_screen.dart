import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/app_providers.dart';
import '../core/models/achievement.dart';
import '../core/storage/enhanced_storage_service.dart';
import '../services/auth_service.dart';
import '../services/progress_tracking_service.dart';
import '../screens/settings/notifications_settings_screen.dart';
import '../screens/settings/app_settings_screen.dart';
import '../screens/settings/help_support_screen.dart';
import '../utils/app_theme.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<void> _signOut() async {
    try {
      await AuthService().signOut();
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileSimpleProvider);
    final progressService = ref.watch(progressTrackingServiceProvider);
    final userId = AuthService().currentUser?.id ?? 'guest';
    final overallStats = ref.watch(overallStatsProvider(userId));
    
    // For now, use placeholder achievements - will be loaded from storage in a future update
    final achievements = <Achievement>[];
    
    return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Header
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: AppTheme.primaryColor,
                            child: Text(
                              userProfile?.name.substring(0, 1).toUpperCase() ?? 'U',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userProfile?.name ?? 'User',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                Text(
                                  '${userProfile?.city ?? 'City'} • Joined March 2024',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Level ${userProfile?.level ?? 3}',
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${userProfile?.streak ?? 12} day streak',
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Level Progress
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.trending_up, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Level Progress',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Level ${userProfile?.level ?? 3}'),
                              Text('Level ${(userProfile?.level ?? 3) + 1}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.6,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${userProfile?.xp ?? 2450} / ${((userProfile?.level ?? 3) + 1) * 500} XP',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard(Icons.emoji_events, 'Total XP', '${userProfile?.xp ?? 2450}', Colors.yellow),
                      _buildStatCard(
                        Icons.track_changes,
                        'Lessons Done',
                        overallStats.when(
                          data: (stats) => '${stats['completedLessons'] ?? 0}',
                          loading: () => '0',
                          error: (_, __) => '0',
                        ),
                        Colors.blue
                      ),
                      _buildStatCard(
                        Icons.quiz,
                        'Quizzes Passed',
                        overallStats.when(
                          data: (stats) => '${stats['passedQuizzes'] ?? 0}',
                          loading: () => '0',
                          error: (_, __) => '0',
                        ),
                        AppTheme.purpleColor
                      ),
                      _buildStatCard(
                        Icons.local_fire_department,
                        'Current Streak',
                        '0', // Will be implemented with streak tracking
                        Colors.orange
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Achievements
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.emoji_events, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Achievements',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: achievements.length,
                            itemBuilder: (context, index) {
                              final achievement = achievements[index];
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: achievement.earned 
                                    ? AppTheme.accentColor 
                                    : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: achievement.earned 
                                    ? Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2))
                                    : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      achievement.icon,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: achievement.earned ? null : Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      achievement.title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: achievement.earned ? null : Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (achievement.earned && achievement.earnedDate != null)
                                      Text(
                                        '${achievement.earnedDate!.day}/${achievement.earnedDate!.month}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Current Goals
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Goals',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          
                          // Health Goal
                          Row(
                            children: [
                              const Icon(Icons.favorite, color: AppTheme.healthColor, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  userProfile?.healthGoal ?? 'Set a health goal',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                overallStats.when(
                                  data: (stats) => '${((stats['healthProgress'] ?? 0.0) * 100).round()}%',
                                  loading: () => '0%',
                                  error: (_, __) => '0%',
                                ),
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: overallStats.when(
                              data: (stats) => (stats['healthProgress'] ?? 0.0) as double,
                              loading: () => 0.0,
                              error: (_, __) => 0.0,
                            ),
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          
                          // Wealth Goal
                          Row(
                            children: [
                              const Icon(Icons.attach_money, color: AppTheme.wealthColor, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  userProfile?.wealthGoal ?? 'Set a wealth goal',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                overallStats.when(
                                  data: (stats) => '${((stats['wealthProgress'] ?? 0.0) * 100).round()}%',
                                  loading: () => '0%',
                                  error: (_, __) => '0%',
                                ),
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: overallStats.when(
                              data: (stats) => (stats['wealthProgress'] ?? 0.0) as double,
                              loading: () => 0.0,
                              error: (_, __) => 0.0,
                            ),
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                              label: const Text('Update Goals'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Settings
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          _buildSettingsItem(Icons.notifications, 'Notifications', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NotificationsSettingsScreen(),
                              ),
                            );
                          }),
                          _buildSettingsItem(Icons.settings, 'App Settings', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppSettingsScreen(),
                              ),
                            );
                          }),
                          _buildSettingsItem(Icons.help, 'Help & Support', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpSupportScreen(),
                              ),
                            );
                          }),
                          _buildSettingsItem(Icons.logout, 'Sign Out', _signOut, isDestructive: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  Widget _buildStatCard(IconData icon, String label, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}