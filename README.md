# Empower Health & Wealth App

A comprehensive Flutter application designed to help users track and improve their health and wealth goals through gamification, education, and community support.

## 🚀 Features

### ✨ Core Features
- **Dual Focus**: Health and wealth goal tracking in one unified platform
- **Gamification**: XP system, achievements, streaks, and level progression
- **Modern UI**: shadcn/ui inspired design with WCAG 2.1 AA accessibility compliance
- **Authentication**: Secure user registration and login with Supabase
- **Real-time Data**: Live progress tracking and updates
- **Educational Content**: Learning modules for health and wealth topics

### 🎨 Design System
- **Typography**: Satoshi font family for modern, clean aesthetics
- **Color Palette**: Carefully crafted color system with proper contrast ratios
- **Accessibility**: WCAG 2.1 AA compliant with semantic colors and proper spacing
- **Responsive**: Optimized for various screen sizes and orientations
- **Dark/Light Mode**: Full theme support (ready for implementation)

### 🔐 Authentication & Security
- **Supabase Integration**: Secure backend with Row Level Security (RLS)
- **Email Verification**: Account verification via email
- **Password Security**: Strong password requirements and validation
- **Profile Management**: Comprehensive user profile system
- **Data Privacy**: User data isolation and protection

## 📱 Screenshots

### Onboarding Flow
- Welcome screen with goal selection
- User profile setup
- Health and wealth goal configuration

### Main Dashboard
- Progress overview cards
- Daily task management
- Achievement showcase
- Quick action buttons

### Authentication
- Modern login screen
- Comprehensive signup flow
- Password reset functionality

## 🛠 Technical Stack

### Frontend
- **Flutter**: Cross-platform mobile development
- **Material 3**: Modern design system implementation
- **Provider**: State management
- **Custom Widgets**: Reusable UI components

### Backend
- **Supabase**: Backend-as-a-Service
- **PostgreSQL**: Relational database
- **Row Level Security**: Data protection
- **Real-time Subscriptions**: Live data updates

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^2.5.6
  crypto: ^3.0.3
  shared_preferences: ^2.2.3
  provider: ^6.1.2
```

## 🏗 Architecture

### Project Structure
```
lib/
├── config/
│   └── supabase_config.dart      # Supabase configuration
├── models/
│   ├── user_profile.dart         # User profile data model
│   ├── achievement.dart          # Achievement data model
│   ├── learning_module.dart      # Learning content model
│   └── daily_task.dart          # Task data model
├── services/
│   ├── auth_service.dart         # Authentication service
│   └── database_service.dart     # Database operations
├── screens/
│   ├── onboarding_screen.dart    # User onboarding
│   ├── dashboard_screen.dart     # Main dashboard
│   └── auth/
│       ├── login_screen.dart     # Login interface
│       └── signup_screen.dart    # Registration interface
├── widgets/
│   ├── auth_wrapper.dart         # Authentication routing
│   ├── stat_card.dart           # Statistics display
│   ├── progress_card.dart       # Progress visualization
│   ├── daily_tasks_card.dart    # Task management
│   ├── achievements_card.dart   # Achievement display
│   ├── goals_progress_card.dart # Goal tracking
│   └── quick_actions_card.dart  # Action buttons
├── utils/
│   └── app_theme.dart           # Theme configuration
└── main.dart                    # App entry point
```

### Database Schema
```sql
-- Core Tables
- profiles: User profile information
- health_goals: Health-related objectives
- wealth_goals: Financial objectives
- daily_tasks: Daily actionable items
- achievements: Predefined achievements
- user_achievements: Earned achievements
- progress_entries: Progress tracking
- learning_modules: Educational content
- user_module_progress: Learning progress
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- iOS Simulator / Android Emulator
- Supabase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd empower-health-wealth-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
   - Create a new project at [supabase.com](https://supabase.com)
   - Copy your project URL and anon key
   - Update `lib/config/supabase_config.dart` with your credentials

4. **Configure database**
   - Run the SQL commands from `supabase_setup.md`
   - Set up Row Level Security policies
   - Insert sample data

5. **Run the app**
   ```bash
   flutter run
   ```

### Environment Setup

Create a `.env` file in the project root:
```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 📊 Database Setup

### Quick Setup
1. Open your Supabase SQL Editor
2. Copy and paste the SQL commands from `supabase_setup.md`
3. Run each section in order:
   - Create tables
   - Enable Row Level Security
   - Create functions and triggers
   - Insert sample data

### Key Features
- **Automatic Profile Creation**: New users get profiles via database triggers
- **Data Isolation**: RLS ensures users only access their own data
- **Real-time Updates**: Live data synchronization
- **Comprehensive Tracking**: Health, wealth, tasks, and progress

## 🎯 Usage

### User Journey
1. **Registration**: Create account with email verification
2. **Onboarding**: Set up profile and select goals
3. **Dashboard**: View progress and daily tasks
4. **Goal Setting**: Create health and wealth objectives
5. **Daily Tasks**: Complete tasks to earn XP and maintain streaks
6. **Learning**: Access educational modules
7. **Achievements**: Unlock badges and rewards

### Key Interactions
- **Goal Creation**: Set specific, measurable objectives
- **Task Completion**: Mark daily tasks as complete
- **Progress Tracking**: Log measurements and milestones
- **Learning**: Complete educational modules
- **Social Features**: Share achievements (future feature)

## 🔧 Configuration

### Theme Customization
The app uses a comprehensive theme system based on shadcn/ui principles:

```dart
// Primary colors
static const Color lightPrimary = Color(0xFF0F172A);
static const Color lightBackground = Color(0xFFFFFFFF);

// Semantic colors
static const Color healthColor = Color(0xFF10B981);
static const Color wealthColor = Color(0xFF3B82F6);
```

### Typography
Satoshi font family with multiple weights:
- Regular (400)
- Medium (500)
- Bold (700)

## 🧪 Testing

### Running Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Widget tests
flutter test test/widget_test.dart
```

### Test Coverage
- Authentication flow
- Database operations
- UI components
- User interactions

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web (Future)
```bash
flutter build web
```

## 🤝 Contributing

### Development Guidelines
1. Follow Flutter best practices
2. Maintain WCAG 2.1 AA compliance
3. Write comprehensive tests
4. Document new features
5. Use semantic commit messages

### Code Style
- Use `dart format` for formatting
- Follow Flutter naming conventions
- Add documentation comments
- Maintain consistent file structure

## 📝 Changelog

### Version 1.0.0 (Current)
- ✅ Complete UI overhaul with shadcn/ui design system
- ✅ Supabase backend integration
- ✅ Authentication system
- ✅ Database schema and RLS
- ✅ Satoshi font integration
- ✅ WCAG 2.1 AA compliance
- ✅ Comprehensive documentation

### Upcoming Features
- 🔄 Real-time notifications
- 🔄 Social features and community
- 🔄 Advanced analytics
- 🔄 Offline support
- 🔄 Dark mode implementation
- 🔄 Multi-language support

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

### Documentation
- `supabase_setup.md`: Database setup guide
- `database_schema.sql`: Complete database schema
- Inline code documentation

### Common Issues
1. **Supabase Connection**: Verify URL and keys
2. **Database Errors**: Check RLS policies
3. **Authentication Issues**: Verify email settings
4. **Build Errors**: Run `flutter clean && flutter pub get`

### Getting Help
- Check the documentation
- Review error logs
- Verify Supabase configuration
- Ensure all dependencies are installed

## 🎉 Acknowledgments

- **shadcn/ui**: Design system inspiration
- **Supabase**: Backend infrastructure
- **Flutter Team**: Amazing framework
- **Satoshi Font**: Beautiful typography
- **Community**: Feedback and support

---

**Built with ❤️ using Flutter and Supabase**
