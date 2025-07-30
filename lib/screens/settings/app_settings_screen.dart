import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../services/settings_service.dart';

class AppSettingsScreen extends ConsumerStatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen> {
  AppSettings? _settings;
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
      final settings = await service.getAppSettings();
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
      await service.saveAppSettings(_settings!);
      
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

  void _updateSettings(AppSettings newSettings) {
    setState(() {
      _settings = newSettings;
    });
    _saveSettings();
  }

  Future<void> _showThemeDialog() async {
    if (_settings == null) return;

    final String? selectedTheme = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Light'),
                value: 'light',
                groupValue: _settings!.theme,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
              RadioListTile<String>(
                title: const Text('Dark'),
                value: 'dark',
                groupValue: _settings!.theme,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
              RadioListTile<String>(
                title: const Text('System'),
                value: 'system',
                groupValue: _settings!.theme,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
            ],
          ),
        );
      },
    );

    if (selectedTheme != null) {
      _updateSettings(_settings!.copyWith(theme: selectedTheme));
    }
  }

  Future<void> _showLanguageDialog() async {
    if (_settings == null) return;

    final Map<String, String> languages = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'it': 'Italian',
      'pt': 'Portuguese',
      'hi': 'Hindi',
      'zh': 'Chinese',
    };

    final String? selectedLanguage = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Language'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final entry = languages.entries.elementAt(index);
                return RadioListTile<String>(
                  title: Text(entry.value),
                  value: entry.key,
                  groupValue: _settings!.language,
                  onChanged: (value) => Navigator.of(context).pop(value),
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedLanguage != null) {
      _updateSettings(_settings!.copyWith(language: selectedLanguage));
    }
  }

  Future<void> _showFontSizeDialog() async {
    if (_settings == null) return;

    final double? selectedSize = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Font Size'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<double>(
                title: const Text('Small'),
                value: 14.0,
                groupValue: _settings!.fontSize,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
              RadioListTile<double>(
                title: const Text('Medium'),
                value: 16.0,
                groupValue: _settings!.fontSize,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
              RadioListTile<double>(
                title: const Text('Large'),
                value: 18.0,
                groupValue: _settings!.fontSize,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
              RadioListTile<double>(
                title: const Text('Extra Large'),
                value: 20.0,
                groupValue: _settings!.fontSize,
                onChanged: (value) => Navigator.of(context).pop(value),
              ),
            ],
          ),
        );
      },
    );

    if (selectedSize != null) {
      _updateSettings(_settings!.copyWith(fontSize: selectedSize));
    }
  }

  String _getThemeDisplayName(String theme) {
    switch (theme) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      case 'system':
        return 'System';
      default:
        return 'System';
    }
  }

  String _getLanguageDisplayName(String language) {
    const Map<String, String> languages = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'it': 'Italian',
      'pt': 'Portuguese',
      'hi': 'Hindi',
      'zh': 'Chinese',
    };
    return languages[language] ?? 'English';
  }

  String _getFontSizeDisplayName(double fontSize) {
    if (fontSize <= 14.0) return 'Small';
    if (fontSize <= 16.0) return 'Medium';
    if (fontSize <= 18.0) return 'Large';
    return 'Extra Large';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
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
                      // Appearance Section
                      _buildSectionHeader('Appearance'),
                      Card(
                        child: Column(
                          children: [
                            _buildSelectTile(
                              'Theme',
                              'Choose your preferred theme',
                              Icons.palette,
                              _getThemeDisplayName(_settings!.theme),
                              _showThemeDialog,
                            ),
                            const Divider(height: 1),
                            _buildSelectTile(
                              'Font Size',
                              'Adjust text size for better readability',
                              Icons.text_fields,
                              _getFontSizeDisplayName(_settings!.fontSize),
                              _showFontSizeDialog,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Language & Region Section
                      _buildSectionHeader('Language & Region'),
                      Card(
                        child: Column(
                          children: [
                            _buildSelectTile(
                              'Language',
                              'Choose your preferred language',
                              Icons.language,
                              _getLanguageDisplayName(_settings!.language),
                              _showLanguageDialog,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Data & Sync Section
                      _buildSectionHeader('Data & Sync'),
                      Card(
                        child: Column(
                          children: [
                            _buildSwitchTile(
                              'Offline Mode',
                              'Download content for offline access',
                              Icons.offline_pin,
                              _settings!.offlineMode,
                              (value) => _updateSettings(_settings!.copyWith(offlineMode: value)),
                            ),
                            const Divider(height: 1),
                            _buildSwitchTile(
                              'Auto Sync',
                              'Automatically sync your progress',
                              Icons.sync,
                              _settings!.autoSync,
                              (value) => _updateSettings(_settings!.copyWith(autoSync: value)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Feedback Section
                      _buildSectionHeader('Feedback'),
                      Card(
                        child: Column(
                          children: [
                            _buildSwitchTile(
                              'Haptic Feedback',
                              'Feel vibrations for interactions',
                              Icons.vibration,
                              _settings!.hapticFeedback,
                              (value) => _updateSettings(_settings!.copyWith(hapticFeedback: value)),
                            ),
                            const Divider(height: 1),
                            _buildSwitchTile(
                              'Sound Effects',
                              'Play sounds for interactions',
                              Icons.volume_up,
                              _settings!.soundEffects,
                              (value) => _updateSettings(_settings!.copyWith(soundEffects: value)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),

                      // Info Card
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacing4),
                        decoration: BoxDecoration(
                          color: AppTheme.warningColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          border: Border.all(
                            color: AppTheme.warningColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppTheme.warningColor,
                              size: AppTheme.spacing5,
                            ),
                            SizedBox(width: AppTheme.spacing3),
                            Expanded(
                              child: Text(
                                'Some settings may require app restart to take effect. Your preferences are automatically saved.',
                                style: TextStyle(
                                  color: AppTheme.warningColor,
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

  Widget _buildSelectTile(
    String title,
    String subtitle,
    IconData icon,
    String value,
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
            value,
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