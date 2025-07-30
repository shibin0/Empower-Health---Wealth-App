import { supabase } from '../utils/supabase/client'
import { projectId, publicAnonKey } from '../utils/supabase/info'

export interface UserProfile {
  id: string;
  name: string;
  email: string;
  xp: number;
  level: number;
  streak: number;
  joinedDate: string;
  healthGoal?: string;
  wealthGoal?: string;
  currentLevel: 'beginner' | 'intermediate' | 'advanced';
  totalLessonsCompleted: number;
  totalQuizzesTaken: number;
  achievements: any[];
  lastActiveDate: string;
}

export interface AuthResponse {
  user: any;
  profile: UserProfile;
  accessToken: string;
}

// Demo account data
const DEMO_PROFILE: UserProfile = {
  id: 'demo-user-123',
  name: 'Demo User',
  email: 'demo@empower.app',
  xp: 1250,
  level: 5,
  streak: 12,
  joinedDate: '2024-01-01T00:00:00Z',
  healthGoal: 'Improve overall fitness and mental wellness',
  wealthGoal: 'Build emergency fund and start investing',
  currentLevel: 'intermediate',
  totalLessonsCompleted: 25,
  totalQuizzesTaken: 18,
  achievements: [
    { id: 'first-lesson', name: 'First Steps', description: 'Completed your first lesson', unlockedAt: '2024-01-02T00:00:00Z' },
    { id: 'week-streak', name: 'Week Warrior', description: 'Maintained a 7-day streak', unlockedAt: '2024-01-08T00:00:00Z' },
    { id: 'quiz-master', name: 'Quiz Master', description: 'Scored 90%+ on 5 quizzes', unlockedAt: '2024-01-15T00:00:00Z' }
  ],
  lastActiveDate: new Date().toISOString()
};

class AuthService {
  private static instance: AuthService;
  private currentUser: any = null;
  private currentProfile: UserProfile | null = null;
  private accessToken: string | null = null;

  private constructor() {
    this.initializeAuth();
  }

  static getInstance(): AuthService {
    if (!AuthService.instance) {
      AuthService.instance = new AuthService();
    }
    return AuthService.instance;
  }

  private async initializeAuth() {
    // Check for existing session
    const { data: { session } } = await supabase.auth.getSession();
    if (session) {
      this.currentUser = session.user;
      this.accessToken = session.access_token;
      await this.fetchProfile();
    }

    // Listen for auth changes
    supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'SIGNED_IN' && session) {
        this.currentUser = session.user;
        this.accessToken = session.access_token;
        await this.fetchProfile();
      } else if (event === 'SIGNED_OUT') {
        this.currentUser = null;
        this.currentProfile = null;
        this.accessToken = null;
      }
    });
  }

  async signUp(email: string, password: string, name: string): Promise<AuthResponse> {
    try {
      // Check if this is the demo account
      if (email === 'demo@empower.app') {
        // Simulate demo account creation/login
        this.currentUser = { id: 'demo-user-123', email };
        this.currentProfile = DEMO_PROFILE;
        this.accessToken = 'demo-token-123';
        
        return {
          user: this.currentUser,
          profile: this.currentProfile,
          accessToken: this.accessToken,
        };
      }

      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/auth/signup`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${publicAnonKey}`,
          },
          body: JSON.stringify({ email, password, name }),
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Signup failed');
      }

      const data = await response.json();
      
      // Now sign in with the created account
      const { data: authData, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (signInError) {
        throw signInError;
      }

      this.currentUser = authData.user;
      this.accessToken = authData.session.access_token;
      this.currentProfile = data.profile;

      return {
        user: authData.user,
        profile: data.profile,
        accessToken: authData.session.access_token,
      };
    } catch (error) {
      console.error('Signup error:', error);
      throw error;
    }
  }

  async signIn(email: string, password: string): Promise<AuthResponse> {
    try {
      // Check if this is the demo account
      if (email === 'demo@empower.app' && password === 'demo123') {
        // Simulate demo account login
        this.currentUser = { id: 'demo-user-123', email };
        this.currentProfile = DEMO_PROFILE;
        this.accessToken = 'demo-token-123';
        
        return {
          user: this.currentUser,
          profile: this.currentProfile,
          accessToken: this.accessToken,
        };
      }

      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        throw error;
      }

      this.currentUser = data.user;
      this.accessToken = data.session.access_token;
      
      await this.fetchProfile();

      return {
        user: data.user,
        profile: this.currentProfile!,
        accessToken: data.session.access_token,
      };
    } catch (error) {
      console.error('Sign in error:', error);
      throw error;
    }
  }

  async signOut(): Promise<void> {
    try {
      // Handle demo account logout
      if (this.currentUser?.id === 'demo-user-123') {
        this.currentUser = null;
        this.currentProfile = null;
        this.accessToken = null;
        return;
      }

      await supabase.auth.signOut();
      this.currentUser = null;
      this.currentProfile = null;
      this.accessToken = null;
    } catch (error) {
      console.error('Sign out error:', error);
      throw error;
    }
  }

  async fetchProfile(): Promise<UserProfile | null> {
    if (!this.accessToken) return null;

    // Handle demo account
    if (this.currentUser?.id === 'demo-user-123') {
      this.currentProfile = DEMO_PROFILE;
      return DEMO_PROFILE;
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/profile`,
        {
          headers: {
            'Authorization': `Bearer ${this.accessToken}`,
          },
        }
      );

      if (!response.ok) {
        throw new Error('Failed to fetch profile');
      }

      const profile = await response.json();
      this.currentProfile = profile;
      return profile;
    } catch (error) {
      console.error('Profile fetch error:', error);
      return null;
    }
  }

  async updateProfile(updates: Partial<UserProfile>): Promise<UserProfile> {
    if (!this.accessToken) {
      throw new Error('Not authenticated');
    }

    // Handle demo account
    if (this.currentUser?.id === 'demo-user-123') {
      this.currentProfile = { ...DEMO_PROFILE, ...updates };
      return this.currentProfile;
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/profile`,
        {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.accessToken}`,
          },
          body: JSON.stringify(updates),
        }
      );

      if (!response.ok) {
        throw new Error('Failed to update profile');
      }

      const updatedProfile = await response.json();
      this.currentProfile = updatedProfile;
      return updatedProfile;
    } catch (error) {
      console.error('Profile update error:', error);
      throw error;
    }
  }

  async getDailyTasks(): Promise<any[]> {
    // Return demo tasks for demo account or when server is unavailable
    const demoTasks = [
      {
        id: '1',
        title: 'Read a health article',
        type: 'health',
        completed: false,
        xpReward: 25,
        date: new Date().toISOString().split('T')[0]
      },
      {
        id: '2',
        title: 'Complete a budgeting exercise',
        type: 'wealth',
        completed: false,
        xpReward: 30,
        date: new Date().toISOString().split('T')[0]
      },
      {
        id: '3',
        title: 'Take a quick quiz',
        type: 'health',
        completed: false,
        xpReward: 20,
        date: new Date().toISOString().split('T')[0]
      }
    ];

    if (this.currentUser?.id === 'demo-user-123' || !this.accessToken) {
      return demoTasks;
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/daily-tasks`,
        {
          headers: {
            'Authorization': `Bearer ${this.accessToken}`,
          },
        }
      );

      if (!response.ok) {
        return demoTasks; // Fallback to demo tasks
      }

      return await response.json();
    } catch (error) {
      console.error('Daily tasks error:', error);
      return demoTasks; // Fallback to demo tasks
    }
  }

  async completeTask(taskId: string): Promise<any> {
    // Handle demo account
    if (this.currentUser?.id === 'demo-user-123') {
      const task = { id: taskId, xpReward: 25, completedAt: new Date().toISOString() };
      const updatedProfile = { ...this.currentProfile!, xp: this.currentProfile!.xp + 25 };
      this.currentProfile = updatedProfile;
      
      return {
        task,
        profile: updatedProfile,
        levelUp: false
      };
    }

    if (!this.accessToken) {
      throw new Error('Not authenticated');
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/complete-task`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.accessToken}`,
          },
          body: JSON.stringify({ taskId }),
        }
      );

      if (!response.ok) {
        throw new Error('Failed to complete task');
      }

      const result = await response.json();
      
      // Update local profile
      if (result.profile) {
        this.currentProfile = result.profile;
      }

      return result;
    } catch (error) {
      console.error('Complete task error:', error);
      throw error;
    }
  }

  async submitQuiz(quizSession: any): Promise<any> {
    // Handle demo account
    if (this.currentUser?.id === 'demo-user-123') {
      const xpEarned = Math.floor(quizSession.score * 10);
      const updatedProfile = { ...this.currentProfile!, xp: this.currentProfile!.xp + xpEarned };
      this.currentProfile = updatedProfile;
      
      return {
        xpEarned,
        profile: updatedProfile,
        levelUp: false
      };
    }

    if (!this.accessToken) {
      throw new Error('Not authenticated');
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/quiz/submit`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.accessToken}`,
          },
          body: JSON.stringify(quizSession),
        }
      );

      if (!response.ok) {
        throw new Error('Failed to submit quiz');
      }

      const result = await response.json();
      
      // Update local profile
      if (result.profile) {
        this.currentProfile = result.profile;
      }

      return result;
    } catch (error) {
      console.error('Quiz submit error:', error);
      throw error;
    }
  }

  async getQuizHistory(): Promise<any[]> {
    // Return demo history for demo account
    const demoHistory = [
      {
        id: '1',
        category: 'health',
        score: 8,
        questions: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
        results: [],
        startTime: new Date(Date.now() - 86400000), // 1 day ago
        endTime: new Date(Date.now() - 86400000 + 300000) // 5 minutes later
      },
      {
        id: '2',
        category: 'wealth',
        score: 9,
        questions: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}],
        results: [],
        startTime: new Date(Date.now() - 172800000), // 2 days ago
        endTime: new Date(Date.now() - 172800000 + 480000) // 8 minutes later
      }
    ];

    if (this.currentUser?.id === 'demo-user-123' || !this.accessToken) {
      return demoHistory;
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/quiz/history`,
        {
          headers: {
            'Authorization': `Bearer ${this.accessToken}`,
          },
        }
      );

      if (!response.ok) {
        return demoHistory; // Fallback to demo history
      }

      return await response.json();
    } catch (error) {
      console.error('Quiz history error:', error);
      return demoHistory; // Fallback to demo history
    }
  }

  async getLeaderboard(type: 'xp' | 'streak' | 'level' = 'xp', limit: number = 10): Promise<any[]> {
    // Return demo leaderboard
    const demoLeaderboard = [
      { id: '1', name: 'Priya S.', xp: 2340, level: 12, streak: 28 },
      { id: '2', name: 'Rahul K.', xp: 2100, level: 11, streak: 21 },
      { id: 'demo-user-123', name: 'Demo User', xp: 1250, level: 5, streak: 12 },
      { id: '3', name: 'Sneha M.', xp: 1890, level: 9, streak: 15 },
      { id: '4', name: 'Arjun P.', xp: 1670, level: 8, streak: 9 }
    ].sort((a, b) => b[type] - a[type]).slice(0, limit);

    if (this.currentUser?.id === 'demo-user-123' || !this.accessToken) {
      return demoLeaderboard;
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/leaderboard?type=${type}&limit=${limit}`,
        {
          headers: {
            'Authorization': `Bearer ${this.accessToken}`,
          },
        }
      );

      if (!response.ok) {
        return demoLeaderboard; // Fallback to demo leaderboard
      }

      return await response.json();
    } catch (error) {
      console.error('Leaderboard error:', error);
      return demoLeaderboard; // Fallback to demo leaderboard
    }
  }

  async getChallenges(): Promise<any[]> {
    // Return demo challenges
    const demoChallenges = [
      {
        id: '1',
        title: '7-Day Wellness Challenge',
        description: 'Complete a health lesson every day for a week',
        type: 'health',
        participants: 234,
        endDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(),
        reward: 100
      },
      {
        id: '2',
        title: 'Budget Master Challenge',
        description: 'Create and stick to a budget for 30 days',
        type: 'wealth',
        participants: 156,
        endDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
        reward: 250
      }
    ];

    if (this.currentUser?.id === 'demo-user-123' || !this.accessToken) {
      return demoChallenges;
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/challenges`,
        {
          headers: {
            'Authorization': `Bearer ${this.accessToken}`,
          },
        }
      );

      if (!response.ok) {
        return demoChallenges; // Fallback to demo challenges
      }

      return await response.json();
    } catch (error) {
      console.error('Challenges error:', error);
      return demoChallenges; // Fallback to demo challenges
    }
  }

  async joinChallenge(challengeId: string): Promise<any> {
    // Handle demo account
    if (this.currentUser?.id === 'demo-user-123') {
      return { success: true, message: 'Joined challenge successfully!' };
    }

    if (!this.accessToken) {
      throw new Error('Not authenticated');
    }

    try {
      const response = await fetch(
        `https://${projectId}.supabase.co/functions/v1/make-server-b724bdf3/challenges/join`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.accessToken}`,
          },
          body: JSON.stringify({ challengeId }),
        }
      );

      if (!response.ok) {
        throw new Error('Failed to join challenge');
      }

      return await response.json();
    } catch (error) {
      console.error('Join challenge error:', error);
      throw error;
    }
  }

  // Getters
  getCurrentUser() {
    return this.currentUser;
  }

  getCurrentProfile() {
    return this.currentProfile;
  }

  getAccessToken() {
    return this.accessToken;
  }

  isAuthenticated() {
    return !!this.currentUser && !!this.accessToken;
  }
}

export const authService = AuthService.getInstance();