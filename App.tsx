import { useState, useEffect } from 'react';
import { AuthScreen } from './components/AuthScreen';
import { Onboarding } from './components/Onboarding';
import { Dashboard } from './components/Dashboard';
import { HealthSection } from './components/HealthSection';
import { WealthSection } from './components/WealthSection';
import { ProfileSection } from './components/ProfileSection';
import { CommunitySection } from './components/CommunitySection';
import { ContentManagement } from './components/ContentManagement';
import { AnalyticsDashboard } from './components/AnalyticsDashboard';
import { QuizSystem, QuizResults } from './components/QuizSystem';
import { NotificationSettings } from './components/NotificationSettings';
import { PWAInstaller } from './components/PWAInstaller';
import { Home, Heart, DollarSign, User, Users, Bell, LogOut, BookOpen, BarChart3 } from 'lucide-react';
import { Button } from './components/ui/button';
import { authService, UserProfile } from './services/authService';
import { notificationService } from './services/notificationService';
import { pushNotificationService } from './services/pushNotificationService';
import { toast } from 'sonner@2.0.3';

interface DailyTask {
  id: string;
  title: string;
  type: 'health' | 'wealth';
  completed: boolean;
  xpReward: number;
  date: string;
  completedAt?: string;
}

interface QuizSession {
  id: string;
  category: 'health' | 'wealth';
  score: number;
  questions: any[];
  results: any[];
  startTime: Date;
  endTime?: Date;
}

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<'auth' | 'onboarding' | 'dashboard' | 'health' | 'wealth' | 'profile' | 'community' | 'content' | 'analytics' | 'quiz' | 'notifications'>('auth');
  const [user, setUser] = useState<any>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [dailyTasks, setDailyTasks] = useState<DailyTask[]>([]);
  const [quizHistory, setQuizHistory] = useState<QuizSession[]>([]);
  const [currentQuiz, setCurrentQuiz] = useState<string | null>(null);
  const [quizResults, setQuizResults] = useState<QuizSession | null>(null);
  const [loading, setLoading] = useState(true);
  const [pushNotificationsEnabled, setPushNotificationsEnabled] = useState(false);

  useEffect(() => {
    initializeApp();
    setupNotificationListeners();
    
    // Handle URL shortcuts from PWA
    const urlParams = new URLSearchParams(window.location.search);
    const shortcut = urlParams.get('shortcut');
    if (shortcut === 'tasks') {
      setCurrentScreen('dashboard');
    } else if (shortcut === 'quiz') {
      setCurrentScreen('health'); // Will show quiz options
    }
  }, []);

  const initializeApp = async () => {
    try {
      // Check if user is already authenticated
      const currentUser = authService.getCurrentUser();
      const currentProfile = authService.getCurrentProfile();
      
      if (currentUser && currentProfile) {
        setUser(currentUser);
        setUserProfile(currentProfile);
        
        // Check if profile is complete (has gone through onboarding)
        if (currentProfile.healthGoal || currentProfile.wealthGoal) {
          setCurrentScreen('dashboard');
        } else {
          setCurrentScreen('onboarding');
        }
        
        // Load user data and setup notifications
        await loadUserData();
        setupPushNotifications();
      } else {
        setCurrentScreen('auth');
      }
    } catch (error) {
      console.error('App initialization error:', error);
      setCurrentScreen('auth');
    } finally {
      setLoading(false);
    }
  };

  const setupPushNotifications = () => {
    if (!pushNotificationService.isSupported()) {
      console.log('Push notifications not supported in this browser');
      return;
    }

    try {
      // Only request permission if user is authenticated
      if (authService.isAuthenticated()) {
        pushNotificationService.requestPermission()
          .then(permission => {
            if (permission === 'granted') {
              setPushNotificationsEnabled(true);
              console.log('Push notifications enabled');
              
              // Show a welcome notification after a delay
              setTimeout(() => {
                if (userProfile) {
                  pushNotificationService.showLocalNotification({
                    title: '🎉 Notifications Enabled!',
                    body: `Hi ${userProfile.name}! You'll now get helpful reminders and achievement updates.`,
                    data: { screen: 'dashboard' }
                  });
                }
              }, 2000);
            } else {
              console.log('Push notification permission denied');
            }
          })
          .catch(error => {
            console.error('Failed to request notification permission:', error);
          });
      }
    } catch (error) {
      console.error('Failed to setup push notifications:', error);
    }
  };

  const setupNotificationListeners = () => {
    // Listen for push notification interactions
    window.addEventListener('pushNotificationClick', (event: any) => {
      const { data } = event.detail;
      handleNotificationAction(data);
    });

    // Listen for PWA shortcuts
    window.addEventListener('pwaShortcut', (event: any) => {
      const { shortcut } = event.detail;
      handlePWAShortcut(shortcut);
    });

    // Setup daily reminder notifications (demo: every 60 seconds for testing)
    if (pushNotificationService.isSupported()) {
      const reminderInterval = setInterval(() => {
        if (pushNotificationsEnabled && authService.isAuthenticated()) {
          // Only show reminders occasionally to avoid spam
          if (Math.random() < 0.1) { // 10% chance every minute
            pushNotificationService.showDailyReminder();
          }
        }
      }, 60000); // 1 minute for demo

      // Cleanup on unmount
      return () => clearInterval(reminderInterval);
    }
  };

  const handlePWAShortcut = (shortcut: string) => {
    console.log('Handling PWA shortcut:', shortcut);
    if (shortcut === 'tasks') {
      setCurrentScreen('dashboard');
    } else if (shortcut === 'quiz') {
      setCurrentScreen('health');
    }
  };

  const handleNotificationAction = (data: any, action?: string) => {
    // Handle notification clicks and actions
    if (data?.screen) {
      setCurrentScreen(data.screen);
    }
    
    if (action === 'quiz') {
      startQuiz(data?.category || 'health');
    } else if (action === 'challenge') {
      setCurrentScreen('community');
    }
  };

  const loadUserData = async () => {
    try {
      const [tasks, history] = await Promise.all([
        authService.getDailyTasks(),
        authService.getQuizHistory()
      ]);
      
      setDailyTasks(tasks);
      setQuizHistory(history);
    } catch (error) {
      console.error('Failed to load user data:', error);
      toast.error('Failed to sync data');
    }
  };

  const handleAuthSuccess = async (authUser: any, profile: UserProfile) => {
    setUser(authUser);
    setUserProfile(profile);
    
    // Check if profile is complete (has gone through onboarding)
    if (profile.healthGoal || profile.wealthGoal) {
      setCurrentScreen('dashboard');
      await loadUserData();
    } else {
      setCurrentScreen('onboarding');
    }
    
    // Setup notifications
    try {
      notificationService.scheduleNotifications();
      setupPushNotifications();
    } catch (error) {
      console.error('Failed to setup notifications after auth:', error);
    }
  };

  const handleOnboardingComplete = async (onboardingData: any) => {
    try {
      const updatedProfile = await authService.updateProfile({
        ...onboardingData,
        lastActiveDate: new Date().toISOString()
      });
      
      setUserProfile(updatedProfile);
      setCurrentScreen('dashboard');
      await loadUserData();
      
      // Send welcome notification if enabled
      if (pushNotificationsEnabled && pushNotificationService.isSupported()) {
        setTimeout(() => {
          pushNotificationService.showLocalNotification({
            title: '🎉 Welcome to Empower!',
            body: `Hi ${updatedProfile.name}! Your health & wealth journey starts now. Complete your first task to earn XP!`,
            data: { screen: 'dashboard' },
          }).catch(error => {
            console.error('Failed to show welcome notification:', error);
          });
        }, 3000);
      }
      
      toast.success(`Welcome to Empower, ${updatedProfile.name}! 🎉`);
    } catch (error) {
      console.error('Onboarding completion error:', error);
      toast.error('Failed to complete onboarding');
    }
  };

  const completeTask = async (taskId: string) => {
    try {
      const result = await authService.completeTask(taskId);
      
      // Update local state
      setDailyTasks(prev => prev.map(task => 
        task.id === taskId ? { ...task, completed: true, completedAt: result.task.completedAt } : task
      ));
      
      // Update user profile
      if (result.profile) {
        setUserProfile(result.profile);
      }
      
      // Show success message
      toast.success(`+${result.task.xpReward} XP! Task completed! 🎉`);
      
      // Check for level up
      if (result.levelUp) {
        notificationService.levelUp(result.profile.level, result.task.xpReward);
        toast.success(`🌟 Level Up! You're now Level ${result.profile.level}!`);
        
        // Send push notification for level up if enabled
        if (pushNotificationsEnabled && pushNotificationService.isSupported()) {
          pushNotificationService.showLevelUpNotification(result.profile.level);
        }
      }
      
      // Check if all daily tasks are completed
      const updatedTasks = dailyTasks.map(task => 
        task.id === taskId ? { ...task, completed: true } : task
      );
      const allCompleted = updatedTasks.every(task => task.completed);
      
      if (allCompleted && pushNotificationsEnabled && pushNotificationService.isSupported()) {
        // Send congratulatory push notification
        pushNotificationService.showLocalNotification({
          title: '🎯 Daily Goals Complete!',
          body: 'Amazing! You\'ve completed all your daily tasks. Your streak is growing strong!',
          data: { screen: 'dashboard' },
          tag: 'daily-complete'
        }).catch(error => {
          console.error('Failed to show completion notification:', error);
        });
      }

      // Check for streak milestones
      if (result.profile && result.profile.streak > 0) {
        const streak = result.profile.streak;
        if (streak % 7 === 0 && pushNotificationsEnabled && pushNotificationService.isSupported()) {
          pushNotificationService.showStreakNotification(streak);
        }
      }
    } catch (error) {
      console.error('Task completion error:', error);
      toast.error('Failed to complete task');
    }
  };

  const startQuiz = (category: 'health' | 'wealth') => {
    setCurrentQuiz(category);
    setQuizResults(null);
    setCurrentScreen('quiz');
  };

  const handleQuizComplete = async (session: QuizSession) => {
    try {
      const result = await authService.submitQuiz(session);
      
      // Update local state
      setQuizHistory(prev => [...prev, session]);
      setQuizResults(session);
      
      // Update user profile
      if (result.profile) {
        setUserProfile(result.profile);
      }
      
      // Show success message
      toast.success(`Quiz completed! You earned ${result.xpEarned} XP! 🧠`);
      
      // Check for level up
      if (result.levelUp) {
        notificationService.levelUp(result.profile.level, result.xpEarned);
        toast.success(`🌟 Level Up! You're now Level ${result.profile.level}!`);
        
        if (pushNotificationsEnabled && pushNotificationService.isSupported()) {
          pushNotificationService.showLevelUpNotification(result.profile.level);
        }
      }
      
      // Send push notification for high quiz scores
      const score = session.score / session.questions.length;
      if (pushNotificationsEnabled && pushNotificationService.isSupported() && score >= 0.8) {
        pushNotificationService.showAchievementNotification(
          'Quiz Master!',
          `Great job! You scored ${Math.round(score * 100)}% on your ${session.category} quiz!`,
          { screen: 'profile' }
        ).catch(error => {
          console.error('Failed to show quiz completion notification:', error);
        });
      }
    } catch (error) {
      console.error('Quiz submission error:', error);
      toast.error('Failed to submit quiz');
    }
  };

  const handleSignOut = async () => {
    try {
      // Clear push notifications
      if (pushNotificationsEnabled && pushNotificationService.isSupported()) {
        pushNotificationService.clearQueue();
        setPushNotificationsEnabled(false);
      }
      
      await authService.signOut();
      setUser(null);
      setUserProfile(null);
      setDailyTasks([]);
      setQuizHistory([]);
      setCurrentScreen('auth');
      toast.success('Signed out successfully');
    } catch (error) {
      console.error('Sign out error:', error);
      toast.error('Failed to sign out');
    }
  };

  const renderScreen = () => {
    switch (currentScreen) {
      case 'auth':
        return <AuthScreen onAuthSuccess={handleAuthSuccess} />;
      case 'onboarding':
        return <Onboarding onComplete={handleOnboardingComplete} />;
      case 'dashboard':
        return (
          <Dashboard 
            userProfile={userProfile} 
            dailyTasks={dailyTasks}
            onCompleteTask={completeTask}
            onStartQuiz={startQuiz}
          />
        );
      case 'health':
        return (
          <HealthSection 
            userProfile={userProfile} 
            onStartQuiz={() => startQuiz('health')}
            onXPEarned={(xp) => {
              if (userProfile) {
                setUserProfile({ ...userProfile, xp: userProfile.xp + xp });
              }
            }}
          />
        );
      case 'wealth':
        return (
          <WealthSection 
            userProfile={userProfile}
            onStartQuiz={() => startQuiz('wealth')}
            onXPEarned={(xp) => {
              if (userProfile) {
                setUserProfile({ ...userProfile, xp: userProfile.xp + xp });
              }
            }}
          />
        );
      case 'community':
        return <CommunitySection />;
      case 'content':
        return <ContentManagement userProfile={userProfile} />;
      case 'analytics':
        return <AnalyticsDashboard />;
      case 'profile':
        return (
          <ProfileSection 
            userProfile={userProfile} 
            setUserProfile={setUserProfile}
            achievements={[]} // Will be loaded from server
            quizHistory={quizHistory}
            onOpenNotifications={() => setCurrentScreen('notifications')}
            onSignOut={handleSignOut}
          />
        );
      case 'quiz':
        if (quizResults) {
          return (
            <div className="p-4">
              <QuizResults session={quizResults} />
              <div className="mt-4 text-center">
                <Button
                  onClick={() => {
                    setCurrentScreen('dashboard');
                    setCurrentQuiz(null);
                    setQuizResults(null);
                  }}
                >
                  Back to Dashboard
                </Button>
              </div>
            </div>
          );
        }
        return currentQuiz ? (
          <div className="p-4">
            <QuizSystem
              category={currentQuiz as 'health' | 'wealth'}
              userLevel={userProfile?.currentLevel || 'beginner'}
              onComplete={handleQuizComplete}
              onXPEarned={(xp) => {
                if (userProfile) {
                  setUserProfile({ ...userProfile, xp: userProfile.xp + xp });
                }
              }}
            />
          </div>
        ) : null;
      case 'notifications':
        return (
          <NotificationSettings
            onBack={() => setCurrentScreen('profile')}
          />
        );
      default:
        return <Dashboard userProfile={userProfile} />;
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center space-y-4">
          <div className="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-2xl flex items-center justify-center mx-auto">
            <div className="w-8 h-8 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
          </div>
          <p className="text-muted-foreground">Loading your health & wealth journey...</p>
        </div>
      </div>
    );
  }

  if (currentScreen === 'auth') {
    return (
      <div className="min-h-screen bg-background">
        {renderScreen()}
        <PWAInstaller />
      </div>
    );
  }

  if (currentScreen === 'onboarding') {
    return (
      <div className="min-h-screen bg-background">
        {renderScreen()}
        <PWAInstaller />
      </div>
    );
  }

  // Show full-screen components without navigation
  if (['content', 'analytics'].includes(currentScreen)) {
    return (
      <div className="min-h-screen bg-background">
        {/* Top Header for Content/Analytics */}
        <div className="bg-card border-b border-border p-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
              <span className="text-white text-xs font-bold">E</span>
            </div>
            <div>
              <h1 className="font-semibold">Empower</h1>
              <p className="text-xs text-muted-foreground">
                {currentScreen === 'content' ? 'Content Management' : 'Analytics Dashboard'}
              </p>
            </div>
          </div>
          
          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={() => setCurrentScreen('dashboard')}
            >
              Back to App
            </Button>
            <Button
              variant="ghost"
              size="sm"
              onClick={handleSignOut}
            >
              <LogOut className="h-4 w-4" />
            </Button>
          </div>
        </div>
        
        {renderScreen()}
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background max-w-md mx-auto flex flex-col relative">
      {/* Header */}
      <div className="bg-card border-b border-border p-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
            <span className="text-white text-xs font-bold">E</span>
          </div>
          <div>
            <h1 className="font-semibold">Empower</h1>
            <p className="text-xs text-muted-foreground">
              Level {userProfile?.level || 1} • {userProfile?.xp || 0} XP
              {pushNotificationsEnabled && (
                <span className="ml-2 text-green-500">🔔</span>
              )}
            </p>
          </div>
        </div>
        
        <div className="flex items-center gap-2">
          <Button
            variant="ghost"
            size="sm"
            onClick={() => setCurrentScreen('notifications')}
            className="relative"
          >
            <Bell className="h-4 w-4" />
            {pushNotificationService.getQueuedNotificationCount() > 0 && (
              <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">
                {pushNotificationService.getQueuedNotificationCount()}
              </span>
            )}
          </Button>
          <Button
            variant="ghost"
            size="sm"
            onClick={() => setCurrentScreen('content')}
          >
            <BookOpen className="h-4 w-4" />
          </Button>
          <Button
            variant="ghost"
            size="sm"
            onClick={() => setCurrentScreen('analytics')}
          >
            <BarChart3 className="h-4 w-4" />
          </Button>
          <Button
            variant="ghost"
            size="sm"
            onClick={handleSignOut}
          >
            <LogOut className="h-4 w-4" />
          </Button>
        </div>
      </div>

      {/* Main Content */}
      <div className="flex-1 overflow-y-auto pb-20">
        {renderScreen()}
      </div>

      {/* PWA Install Prompt */}
      <PWAInstaller />

      {/* Bottom Navigation */}
      <div className="fixed bottom-0 left-1/2 transform -translate-x-1/2 w-full max-w-md bg-card border-t border-border">
        <div className="flex items-center justify-around py-2 px-4">
          <button
            onClick={() => setCurrentScreen('dashboard')}
            className={`flex flex-col items-center py-2 px-3 rounded-lg ${
              currentScreen === 'dashboard' ? 'text-primary bg-accent' : 'text-muted-foreground'
            }`}
          >
            <Home className="h-5 w-5 mb-1" />
            <span className="text-xs">Home</span>
          </button>
          <button
            onClick={() => setCurrentScreen('health')}
            className={`flex flex-col items-center py-2 px-3 rounded-lg ${
              currentScreen === 'health' ? 'text-primary bg-accent' : 'text-muted-foreground'
            }`}
          >
            <Heart className="h-5 w-5 mb-1" />
            <span className="text-xs">Health</span>
          </button>
          <button
            onClick={() => setCurrentScreen('wealth')}
            className={`flex flex-col items-center py-2 px-3 rounded-lg ${
              currentScreen === 'wealth' ? 'text-primary bg-accent' : 'text-muted-foreground'
            }`}
          >
            <DollarSign className="h-5 w-5 mb-1" />
            <span className="text-xs">Wealth</span>
          </button>
          <button
            onClick={() => setCurrentScreen('community')}
            className={`flex flex-col items-center py-2 px-3 rounded-lg ${
              currentScreen === 'community' ? 'text-primary bg-accent' : 'text-muted-foreground'
            }`}
          >
            <Users className="h-5 w-5 mb-1" />
            <span className="text-xs">Community</span>
          </button>
          <button
            onClick={() => setCurrentScreen('profile')}
            className={`flex flex-col items-center py-2 px-3 rounded-lg ${
              currentScreen === 'profile' ? 'text-primary bg-accent' : 'text-muted-foreground'
            }`}
          >
            <User className="h-5 w-5 mb-1" />
            <span className="text-xs">Profile</span>
          </button>
        </div>
      </div>
    </div>
  );
}