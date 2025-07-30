# Supabase Setup Guide for Empower Health & Wealth App

## Prerequisites

1. Create a Supabase account at [supabase.com](https://supabase.com)
2. Create a new project in your Supabase dashboard
3. Note down your project URL and anon key

## Database Schema Setup

### Step 1: Run the Database Schema

Copy and paste the following SQL commands in your Supabase SQL Editor:

```sql
-- Create profiles table (extends auth.users)
CREATE TABLE public.profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    name TEXT NOT NULL,
    age TEXT,
    city TEXT,
    primary_goals TEXT[] DEFAULT '{}',
    health_goal TEXT,
    wealth_goal TEXT,
    current_level TEXT DEFAULT 'Beginner',
    xp INTEGER DEFAULT 0,
    level INTEGER DEFAULT 1,
    streak INTEGER DEFAULT 0,
    badges TEXT[] DEFAULT '{}',
    joined_date TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create health_goals table
CREATE TABLE public.health_goals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    target_value NUMERIC,
    current_value NUMERIC DEFAULT 0,
    unit TEXT,
    category TEXT NOT NULL,
    target_date DATE,
    status TEXT DEFAULT 'active',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create wealth_goals table
CREATE TABLE public.wealth_goals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    target_amount NUMERIC,
    current_amount NUMERIC DEFAULT 0,
    currency TEXT DEFAULT 'INR',
    category TEXT NOT NULL,
    target_date DATE,
    status TEXT DEFAULT 'active',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create daily_tasks table
CREATE TABLE public.daily_tasks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    type TEXT NOT NULL,
    xp_reward INTEGER DEFAULT 10,
    completed BOOLEAN DEFAULT FALSE,
    date DATE NOT NULL,
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create achievements table
CREATE TABLE public.achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    icon TEXT NOT NULL,
    category TEXT NOT NULL,
    points INTEGER DEFAULT 0,
    requirement_type TEXT NOT NULL,
    requirement_value INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create user_achievements table
CREATE TABLE public.user_achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    achievement_id UUID REFERENCES public.achievements(id) ON DELETE CASCADE NOT NULL,
    earned_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, achievement_id)
);

-- Create progress_entries table
CREATE TABLE public.progress_entries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    category TEXT NOT NULL,
    value NUMERIC NOT NULL,
    unit TEXT,
    date DATE NOT NULL,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create learning_modules table
CREATE TABLE public.learning_modules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    difficulty_level TEXT DEFAULT 'beginner',
    estimated_duration INTEGER,
    content JSONB,
    order_index INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create user_module_progress table
CREATE TABLE public.user_module_progress (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    module_id UUID REFERENCES public.learning_modules(id) ON DELETE CASCADE NOT NULL,
    progress_percentage INTEGER DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    UNIQUE(user_id, module_id)
);
```

### Step 2: Enable Row Level Security

```sql
-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.health_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wealth_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.progress_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_module_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.learning_modules ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view own profile" ON public.profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.profiles
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.profiles
    FOR INSERT WITH CHECK (auth.uid() = id);

-- Health goals policies
CREATE POLICY "Users can manage own health goals" ON public.health_goals
    FOR ALL USING (auth.uid() = user_id);

-- Wealth goals policies
CREATE POLICY "Users can manage own wealth goals" ON public.wealth_goals
    FOR ALL USING (auth.uid() = user_id);

-- Daily tasks policies
CREATE POLICY "Users can manage own daily tasks" ON public.daily_tasks
    FOR ALL USING (auth.uid() = user_id);

-- User achievements policies
CREATE POLICY "Users can view own achievements" ON public.user_achievements
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "System can insert achievements" ON public.user_achievements
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Progress entries policies
CREATE POLICY "Users can manage own progress entries" ON public.progress_entries
    FOR ALL USING (auth.uid() = user_id);

-- User module progress policies
CREATE POLICY "Users can manage own module progress" ON public.user_module_progress
    FOR ALL USING (auth.uid() = user_id);

-- Achievements table is read-only for users
CREATE POLICY "Anyone can view achievements" ON public.achievements
    FOR SELECT TO authenticated USING (true);

-- Learning modules table is read-only for users
CREATE POLICY "Anyone can view active learning modules" ON public.learning_modules
    FOR SELECT TO authenticated USING (is_active = true);
```

### Step 3: Create Functions and Triggers

```sql
-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_health_goals_updated_at BEFORE UPDATE ON public.health_goals
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_wealth_goals_updated_at BEFORE UPDATE ON public.wealth_goals
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_learning_modules_updated_at BEFORE UPDATE ON public.learning_modules
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to handle new user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, name, age, city, primary_goals, health_goal, wealth_goal)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'name', 'New User'),
        COALESCE(NEW.raw_user_meta_data->>'age', ''),
        COALESCE(NEW.raw_user_meta_data->>'city', ''),
        COALESCE(ARRAY(SELECT jsonb_array_elements_text(NEW.raw_user_meta_data->'primaryGoals')), '{}'),
        COALESCE(NEW.raw_user_meta_data->>'healthGoal', ''),
        COALESCE(NEW.raw_user_meta_data->>'wealthGoal', '')
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new user signup
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

### Step 4: Insert Sample Data

```sql
-- Insert sample achievements
INSERT INTO public.achievements (title, description, icon, category, points, requirement_type, requirement_value) VALUES
('First Steps', 'Complete your first daily task', '🎯', 'general', 10, 'total_tasks', 1),
('Week Warrior', 'Maintain a 7-day streak', '🔥', 'general', 50, 'streak', 7),
('Health Hero', 'Complete 10 health tasks', '💪', 'health', 100, 'health_tasks', 10),
('Wealth Wizard', 'Complete 10 wealth tasks', '💰', 'wealth', 100, 'wealth_tasks', 10),
('Goal Getter', 'Complete your first goal', '🏆', 'general', 200, 'goal_completion', 1),
('Consistency King', 'Maintain a 30-day streak', '👑', 'general', 500, 'streak', 30);

-- Insert sample learning modules
INSERT INTO public.learning_modules (title, description, category, difficulty_level, estimated_duration, content, order_index) VALUES
('Introduction to Healthy Eating', 'Learn the basics of nutrition and healthy eating habits', 'health', 'beginner', 15, '{"lessons": ["Understanding Macronutrients", "Portion Control", "Meal Planning"]}', 1),
('Basic Exercise Fundamentals', 'Get started with safe and effective exercise routines', 'health', 'beginner', 20, '{"lessons": ["Warm-up and Cool-down", "Bodyweight Exercises", "Creating a Routine"]}', 2),
('Personal Finance Basics', 'Learn fundamental concepts of money management', 'wealth', 'beginner', 25, '{"lessons": ["Budgeting 101", "Understanding Income vs Expenses", "Emergency Fund"]}', 3),
('Investment Fundamentals', 'Introduction to investing for beginners', 'wealth', 'beginner', 30, '{"lessons": ["Types of Investments", "Risk and Return", "Getting Started"]}', 4);
```

## Flutter App Configuration

### Step 1: Update Environment Variables

Create a `.env` file in your project root:

```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### Step 2: Update Supabase Configuration

Update `lib/config/supabase_config.dart` with your actual Supabase credentials:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // ... rest of the configuration
}
```

### Step 3: Test the Setup

1. Run the Flutter app: `flutter run`
2. Try creating a new account
3. Check if the profile is created in Supabase dashboard
4. Test login/logout functionality

## Authentication Flow

1. **Sign Up**: User creates account with email/password
2. **Email Verification**: Supabase sends verification email
3. **Profile Creation**: Automatic profile creation via trigger
4. **Onboarding**: User completes profile setup
5. **Dashboard Access**: User can access main app features

## Security Features

- **Row Level Security (RLS)**: Users can only access their own data
- **Authentication Required**: All operations require valid JWT token
- **Data Validation**: Server-side validation for all inputs
- **Secure Triggers**: Automatic profile creation on signup

## Next Steps

1. Set up your Supabase project
2. Run the SQL commands in order
3. Update the Flutter app configuration
4. Test the authentication flow
5. Customize the database schema as needed

## Troubleshooting

- **Connection Issues**: Check your Supabase URL and keys
- **RLS Errors**: Ensure policies are correctly set up
- **Trigger Issues**: Check if the handle_new_user function is working
- **Authentication Errors**: Verify email settings in Supabase dashboard