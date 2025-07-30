import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../services/settings_service.dart';

class NotificationsSettingsScreen extends ConsumerStatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  ConsumerState<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends ConsumerState<NotificationsSettingsScreen> {
  NotificationSettings? _settings;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final service = ref.read(settingsServiceProvider);
      final settings = await service.getNotificationSettings();
      setState(() {
        _settings = settings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading settings: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  Future<void> _saveSettings() async {
    if (_settings == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final service = ref.read(settingsServiceProvider);
      await service.saveNotificationSettings(_settings!);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings saved successfully'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving settings: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  void _updateSettings(NotificationSettings newSettings) {
    setState(() {
      _settings = newSettings;
    });
    _saveSettings();
  }

  Future<void> _selectReminderTime() async {
    if (_settings == null) return;

    final currentTime = TimeOfDay(
      hour: int.parse(_settings!.reminderTime.split(':')[0]),
      minute: int.parse(_settings!.reminderTime.split(':')[1]),
    );

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (picked != null) {
      final timeString = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      _updateSettings(_settings!.copyWith(reminderTime: timeString));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _settings == null
              ? const Center(child: Text('Error loading settings'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(AppTheme.spacing4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // General Notifications Section
                      _buildSectionHeader('General Notifications'),
                      Card(
                        child: Column(
                          children: [
                            _buildSwitchTile(
                              'Push Notifications',
                              'Receive notifications on your device',
                              Icons.notifications,
                              _settings!.pushNotifications,
                              (value) => _updateSettings(_settings!.copyWith(pushNotifications: value)),
                            ),
                            const Divider(height: 1),
                            _buildSwitchTile(
                              'Email Notifications',
                              'Receive notifications via email',
                              Icons.email,
                              _settings!.emailNotifications,
                              (value) => _updateSettings(_settings!.copyWith(emailNotifications: value)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Learning Reminders Section
                      _buildSectionHeader('Learning Reminders'),
                      Card(
                        child: Column(
                          children: [
                            _buildSwitchTile(
                              'Lesson Reminders',
                              'Get reminded to continue your lessons',
                              Icons.school,
                              _settings!.lessonReminders,
                              (value) => _updateSettings(_settings!.copyWith(lessonReminders: value)),
                            ),
                            const Divider(height: 1),
                            _buildSwitchTile(
                              'Quiz Reminders',
                              'Get reminded to take quizzes',
                              Icons.quiz,
                              _settings!.quizReminders,
                              (value) => _updateSettings(_settings!.copyWith(quizReminders: value)),
                            ),
                            const Divider(height: 1),
                            _buildTimeTile(
                              'Reminder Time',
                              'Set your preferred reminder time',
                              Icons.access_time,
                              _settings!.reminderTime,
                              _selectReminderTime,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Progress & Achievements Section
                      _buildSectionHeader('Progress & Achievements'),
                      Card(
                        child: Column(
                          children: [
                            _buildSwitchTile(
                              'Achievement Notifications',
                              'Get notified when you earn achievements',
                              Icons.emoji_events,
                              _settings!.achievementNotifications,
                              (value) => _updateSettings(_settings!.copyWith(achievementNotifications: value)),
                            ),
                            const Divider(height: 1),
                            _buildSwitchTile(
                              'Weekly Progress',
                              'Receive weekly progress summaries',
                              Icons.analytics,
                              _settings!.weeklyProgress,
                              (value) => _updateSettings(_settings!.copyWith(weeklyProgress: value)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Info Card
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacing4),
                        decoration: BoxDecoration(
                          color: AppTheme.infoColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          border: Border.all(
                            color: AppTheme.infoColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppTheme.infoColor,
                              size: AppTheme.spacing5,
                            ),
                            SizedBox(width: AppTheme.spacing3),
                            Expanded(
                              child: Text(
                                'You can change these settings anytime. Some notifications may be required for core app functionality.',
                                style: TextStyle(
                                  color: AppTheme.infoColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing3),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppTheme.spacing2),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing4,
        vertical: AppTheme.spacing2,
      ),
    );
  }

  Widget _buildTimeTile(
    String title,
    String subtitle,
    IconData icon,
    String time,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppTheme.spacing2),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: AppTheme.spacing2),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing4,
        vertical: AppTheme.spacing2,
      ),
    );
  }
}