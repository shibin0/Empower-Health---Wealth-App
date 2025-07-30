export interface NotificationSettings {
  dailyReminder: boolean;
  goalCheck: boolean;
  streakWarning: boolean;
  learningReminder: boolean;
  time: string; // HH:MM format
}

export class NotificationService {
  private static instance: NotificationService;
  private settings: NotificationSettings;

  private constructor() {
    this.settings = this.loadSettings();
    this.requestPermission();
  }

  static getInstance(): NotificationService {
    if (!NotificationService.instance) {
      NotificationService.instance = new NotificationService();
    }
    return NotificationService.instance;
  }

  private loadSettings(): NotificationSettings {
    const saved = localStorage.getItem('notificationSettings');
    if (saved) {
      return JSON.parse(saved);
    }
    return {
      dailyReminder: true,
      goalCheck: true,
      streakWarning: true,
      learningReminder: true,
      time: '20:00'
    };
  }

  updateSettings(newSettings: Partial<NotificationSettings>) {
    this.settings = { ...this.settings, ...newSettings };
    localStorage.setItem('notificationSettings', JSON.stringify(this.settings));
    this.scheduleNotifications();
  }

  getSettings(): NotificationSettings {
    return this.settings;
  }

  async requestPermission(): Promise<boolean> {
    if (!('Notification' in window)) {
      console.log('This browser does not support notifications');
      return false;
    }

    if (Notification.permission === 'granted') {
      return true;
    }

    if (Notification.permission !== 'denied') {
      const permission = await Notification.requestPermission();
      return permission === 'granted';
    }

    return false;
  }

  async showNotification(title: string, options?: NotificationOptions) {
    const hasPermission = await this.requestPermission();
    if (!hasPermission) return;

    const defaultOptions: NotificationOptions = {
      icon: '/icon-192x192.png',
      badge: '/icon-72x72.png',
      vibrate: [200, 100, 200],
      tag: 'empower-notification',
      ...options
    };

    new Notification(title, defaultOptions);
  }

  scheduleNotifications() {
    this.clearScheduledNotifications();

    if (this.settings.dailyReminder) {
      this.scheduleDailyReminder();
    }

    if (this.settings.learningReminder) {
      this.scheduleLearningReminder();
    }
  }

  private scheduleDailyReminder() {
    const [hours, minutes] = this.settings.time.split(':').map(Number);
    const now = new Date();
    const scheduledTime = new Date();
    scheduledTime.setHours(hours, minutes, 0, 0);

    if (scheduledTime <= now) {
      scheduledTime.setDate(scheduledTime.getDate() + 1);
    }

    const timeUntilNotification = scheduledTime.getTime() - now.getTime();

    setTimeout(() => {
      this.showNotification('🔥 Keep your streak alive!', {
        body: 'Complete your daily tasks and continue your health & wealth journey.',
        actions: [
          { action: 'open', title: 'Open App' },
          { action: 'dismiss', title: 'Later' }
        ]
      });

      // Schedule for next day
      setInterval(() => {
        this.showNotification('🔥 Keep your streak alive!', {
          body: 'Complete your daily tasks and continue your health & wealth journey.'
        });
      }, 24 * 60 * 60 * 1000); // Every 24 hours
    }, timeUntilNotification);
  }

  private scheduleLearningReminder() {
    // Schedule learning reminders every 3 days
    const interval = 3 * 24 * 60 * 60 * 1000; // 3 days in milliseconds
    
    setTimeout(() => {
      setInterval(() => {
        this.showNotification('📚 Time to learn something new!', {
          body: 'Discover new health tips or wealth strategies today.',
          actions: [
            { action: 'health', title: 'Health Lesson' },
            { action: 'wealth', title: 'Wealth Lesson' }
          ]
        });
      }, interval);
    }, interval);
  }

  checkStreakWarning(lastActive: Date, currentStreak: number) {
    const now = new Date();
    const hoursSinceActive = (now.getTime() - lastActive.getTime()) / (1000 * 60 * 60);

    if (this.settings.streakWarning && hoursSinceActive > 20 && currentStreak > 3) {
      this.showNotification('⚠️ Don\'t lose your streak!', {
        body: `You have a ${currentStreak}-day streak. Complete a task today to keep it going!`,
        urgency: 'high'
      });
    }
  }

  goalProgressNotification(goalName: string, progress: number) {
    if (this.settings.goalCheck) {
      if (progress >= 100) {
        this.showNotification('🎉 Goal Achieved!', {
          body: `Congratulations! You've completed your goal: ${goalName}`,
        });
      } else if (progress >= 75) {
        this.showNotification('🎯 Almost there!', {
          body: `You're ${progress}% done with: ${goalName}. Keep pushing!`,
        });
      }
    }
  }

  private clearScheduledNotifications() {
    // In a real implementation, you'd keep track of timeout IDs and clear them
    // For now, this is a placeholder
  }

  // Achievement notifications
  achievementUnlocked(achievement: { title: string; description: string; icon: string }) {
    this.showNotification(`${achievement.icon} Achievement Unlocked!`, {
      body: `${achievement.title}: ${achievement.description}`,
      tag: 'achievement'
    });
  }

  // XP and level up notifications
  levelUp(newLevel: number, xpEarned: number) {
    this.showNotification('🌟 Level Up!', {
      body: `Congratulations! You've reached Level ${newLevel} (+${xpEarned} XP)`,
      tag: 'levelup'
    });
  }
}

export const notificationService = NotificationService.getInstance();