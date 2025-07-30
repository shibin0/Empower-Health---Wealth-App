import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _sendEmail() async {
    const email = 'support@empowerapp.com';
    const subject = 'Support Request - Empower Health & Wealth App';
    const body = 'Please describe your issue or question here...';
    
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      // Fallback: copy email to clipboard
      await Clipboard.setData(const ClipboardData(text: email));
    }
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Support'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get in touch with our support team:'),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.email, color: AppTheme.primaryColor),
                  SizedBox(width: 8),
                  Text('support@empowerapp.com'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, color: AppTheme.primaryColor),
                  SizedBox(width: 8),
                  Text('+1 (555) 123-4567'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.schedule, color: AppTheme.primaryColor),
                  SizedBox(width: 8),
                  Text('Mon-Fri, 9AM-6PM EST'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sendEmail();
              },
              child: const Text('Send Email'),
            ),
          ],
        );
      },
    );
  }

  void _showAppInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('App Information'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Empower Health & Wealth App'),
              SizedBox(height: 8),
              Text('Version: 1.0.0'),
              SizedBox(height: 8),
              Text('Build: 2024.03.001'),
              SizedBox(height: 8),
              Text('Platform: Flutter'),
              SizedBox(height: 16),
              Text(
                'Your comprehensive companion for health and wealth management.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Help Section
            _buildSectionHeader('Quick Help'),
            Card(
              child: Column(
                children: [
                  _buildHelpTile(
                    'Getting Started',
                    'Learn the basics of using the app',
                    Icons.play_circle_outline,
                    () => _showGettingStartedDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Frequently Asked Questions',
                    'Find answers to common questions',
                    Icons.help_outline,
                    () => _showFAQDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'User Guide',
                    'Comprehensive guide to all features',
                    Icons.menu_book,
                    () => _showUserGuideDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),

            // Support Section
            _buildSectionHeader('Support'),
            Card(
              child: Column(
                children: [
                  _buildHelpTile(
                    'Contact Support',
                    'Get help from our support team',
                    Icons.support_agent,
                    () => _showContactDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Report a Bug',
                    'Help us improve the app',
                    Icons.bug_report,
                    () => _showBugReportDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Feature Request',
                    'Suggest new features',
                    Icons.lightbulb_outline,
                    () => _showFeatureRequestDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),

            // Resources Section
            _buildSectionHeader('Resources'),
            Card(
              child: Column(
                children: [
                  _buildHelpTile(
                    'Privacy Policy',
                    'Learn how we protect your data',
                    Icons.privacy_tip,
                    () => _launchUrl('https://empowerapp.com/privacy'),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Terms of Service',
                    'Read our terms and conditions',
                    Icons.description,
                    () => _launchUrl('https://empowerapp.com/terms'),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Community Forum',
                    'Connect with other users',
                    Icons.forum,
                    () => _launchUrl('https://community.empowerapp.com'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),

            // About Section
            _buildSectionHeader('About'),
            Card(
              child: Column(
                children: [
                  _buildHelpTile(
                    'App Information',
                    'Version and build details',
                    Icons.info,
                    () => _showAppInfoDialog(context),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Rate the App',
                    'Share your feedback on the app store',
                    Icons.star_rate,
                    () => _launchUrl('https://apps.apple.com/app/empower-health-wealth'),
                  ),
                  const Divider(height: 1),
                  _buildHelpTile(
                    'Follow Us',
                    'Stay updated on social media',
                    Icons.share,
                    () => _showSocialLinksDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),

            // Emergency Contact Info
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing4),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(
                  color: AppTheme.errorColor.withValues(alpha: 0.3),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: AppTheme.errorColor,
                        size: AppTheme.spacing5,
                      ),
                      SizedBox(width: AppTheme.spacing2),
                      Text(
                        'Emergency Notice',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.errorColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacing2),
                  Text(
                    'This app provides educational content only. For medical or financial emergencies, contact appropriate emergency services or professionals immediately.',
                    style: TextStyle(
                      color: AppTheme.errorColor,
                      fontSize: 14,
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

  Widget _buildHelpTile(
    String title,
    String subtitle,
    IconData icon,
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
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing4,
        vertical: AppTheme.spacing2,
      ),
    );
  }

  void _showGettingStartedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Getting Started'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome to Empower Health & Wealth!'),
                SizedBox(height: 16),
                Text('1. Complete your profile setup'),
                SizedBox(height: 8),
                Text('2. Set your health and wealth goals'),
                SizedBox(height: 8),
                Text('3. Start with the Quick Start lessons'),
                SizedBox(height: 8),
                Text('4. Take quizzes to test your knowledge'),
                SizedBox(height: 8),
                Text('5. Track your progress and earn achievements'),
                SizedBox(height: 16),
                Text(
                  'Tip: Use the Quick Start section on the home screen to begin your learning journey!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }

  void _showFAQDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Frequently Asked Questions'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Q: How do I reset my progress?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Go to Settings > App Settings > Reset Progress'),
                SizedBox(height: 16),
                Text(
                  'Q: Can I use the app offline?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Yes, enable Offline Mode in App Settings'),
                SizedBox(height: 16),
                Text(
                  'Q: How are achievements earned?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Complete lessons and pass quizzes to earn achievements'),
                SizedBox(height: 16),
                Text(
                  'Q: Is my data secure?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('A: Yes, we use industry-standard encryption and security measures'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showUserGuideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Guide'),
          content: const Text(
            'The comprehensive user guide is available on our website. Would you like to open it in your browser?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _launchUrl('https://empowerapp.com/guide');
              },
              child: const Text('Open Guide'),
            ),
          ],
        );
      },
    );
  }

  void _showBugReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report a Bug'),
          content: const Text(
            'Help us improve the app by reporting bugs. Please include:\n\n• What you were doing when the bug occurred\n• What you expected to happen\n• What actually happened\n• Your device model and OS version',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sendEmail();
              },
              child: const Text('Send Report'),
            ),
          ],
        );
      },
    );
  }

  void _showFeatureRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feature Request'),
          content: const Text(
            'We love hearing your ideas! Please describe the feature you\'d like to see:\n\n• What problem would it solve?\n• How would it work?\n• Why would it be useful?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sendEmail();
              },
              child: const Text('Send Request'),
            ),
          ],
        );
      },
    );
  }

  void _showSocialLinksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Follow Us'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.facebook, color: Colors.blue),
                title: const Text('Facebook'),
                onTap: () => _launchUrl('https://facebook.com/empowerapp'),
              ),
              ListTile(
                leading: const Icon(Icons.alternate_email, color: Colors.lightBlue),
                title: const Text('Twitter'),
                onTap: () => _launchUrl('https://twitter.com/empowerapp'),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.purple),
                title: const Text('Instagram'),
                onTap: () => _launchUrl('https://instagram.com/empowerapp'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}