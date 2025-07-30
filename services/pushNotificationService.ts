class PushNotificationService {
  private static instance: PushNotificationService;
  private notificationQueue: any[] = [];
  private permission: NotificationPermission = 'default';

  private constructor() {
    this.initializeService();
  }

  static getInstance(): PushNotificationService {
    if (!PushNotificationService.instance) {
      PushNotificationService.instance = new PushNotificationService();
    }
    return PushNotificationService.instance;
  }

  private async initializeService() {
    try {
      if (this.isSupported()) {
        this.permission = Notification.permission;
        
        // Listen for permission changes
        if ('permissions' in navigator) {
          try {
            const permissionStatus = await navigator.permissions.query({ name: 'notifications' as PermissionName });
            permissionStatus.addEventListener('change', () => {
              this.permission = permissionStatus.state as NotificationPermission;
              console.log('Push Service: Notification permission changed to', this.permission);
            });
          } catch (error) {
            console.log('Push Service: Permission API not available, using Notification.permission');
          }
        }

        // Listen for visibility changes to show queued notifications when app becomes visible
        document.addEventListener('visibilitychange', () => {
          if (!document.hidden && this.notificationQueue.length > 0) {
            console.log('Push Service: App became visible, showing queued notifications');
            this.processQueue();
          }
        });

        console.log('Push Service: Initialized successfully (without service worker)');
      }
    } catch (error) {
      console.error('Push Service: Failed to initialize', error);
    }
  }

  isSupported(): boolean {
    try {
      return 'Notification' in window;
    } catch (error) {
      console.error('Push Service: Error checking support', error);
      return false;
    }
  }

  async requestPermission(): Promise<NotificationPermission> {
    try {
      if (!this.isSupported()) {
        console.log('Push Service: Notifications not supported');
        return 'denied';
      }

      if (this.permission === 'granted') {
        return 'granted';
      }

      // Request permission
      const permission = await Notification.requestPermission();
      this.permission = permission;
      
      console.log('Push Service: Permission request result:', permission);
      
      if (permission === 'granted') {
        console.log('Push Service: Notification permission granted');
      } else {
        console.log('Push Service: Notification permission denied or default');
      }

      return permission;
    } catch (error) {
      console.error('Push Service: Failed to request permission', error);
      return 'denied';
    }
  }

  async showLocalNotification(options: {
    title: string;
    body: string;
    icon?: string;
    badge?: string;
    tag?: string;
    data?: any;
    actions?: Array<{ action: string; title: string; icon?: string }>;
  }): Promise<void> {
    try {
      if (this.permission !== 'granted') {
        console.log('Push Service: Permission not granted, queuing notification');
        this.queueNotification(options);
        return;
      }

      // If document is hidden, queue the notification
      if (document.hidden) {
        console.log('Push Service: Document hidden, queuing notification');
        this.queueNotification(options);
        return;
      }

      const notificationOptions: NotificationOptions = {
        body: options.body,
        icon: options.icon || this.getDefaultIcon(),
        badge: options.badge || this.getDefaultIcon(),
        tag: options.tag,
        data: options.data,
        requireInteraction: false,
        silent: false,
      };

      // Create notification directly (no service worker)
      const notification = new Notification(options.title, notificationOptions);
      
      // Handle notification click
      notification.onclick = (event) => {
        event.preventDefault();
        notification.close();
        
        // Focus the app window
        window.focus();
        
        // Dispatch custom event for notification click
        const customEvent = new CustomEvent('pushNotificationClick', {
          detail: { data: options.data }
        });
        window.dispatchEvent(customEvent);
      };

      // Auto close after 5 seconds for non-persistent notifications
      setTimeout(() => {
        notification.close();
      }, 5000);

      console.log('Push Service: Notification shown successfully');
    } catch (error) {
      console.error('Push Service: Failed to show notification', error);
      // Queue for retry
      this.queueNotification(options);
    }
  }

  private queueNotification(options: any) {
    this.notificationQueue.push({
      ...options,
      timestamp: Date.now()
    });
    
    // Keep only the last 10 notifications
    if (this.notificationQueue.length > 10) {
      this.notificationQueue = this.notificationQueue.slice(-10);
    }
    
    console.log('Push Service: Notification queued', this.notificationQueue.length, 'total');
  }

  private async processQueue() {
    if (this.permission !== 'granted' || this.notificationQueue.length === 0) {
      return;
    }

    console.log('Push Service: Processing notification queue', this.notificationQueue.length, 'notifications');
    
    const notifications = [...this.notificationQueue];
    this.notificationQueue = [];

    for (const notification of notifications) {
      // Only show recent notifications (within last 5 minutes)
      const age = Date.now() - notification.timestamp;
      if (age < 5 * 60 * 1000) {
        await this.showLocalNotification(notification);
        // Small delay between notifications
        await new Promise(resolve => setTimeout(resolve, 500));
      }
    }
  }

  private getDefaultIcon(): string {
    return 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTkyIiBoZWlnaHQ9IjE5MiIgdmlld0JveD0iMCAwIDE5MiAxOTIiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiByeD0iNDgiIGZpbGw9InVybCgjZ3JhZGllbnQwX2xpbmVhcl8xXzEpIi8+CjxwYXRoIGQ9Ik05NiA2NEMxMDQuODM3IDY0IDExMiA3MS4xNjMgMTEyIDgwVjExMkMxMTIgMTIwLjgzNyAxMDQuODM3IDEyOCA5NiAxMjhDODcuMTYzIDEyOCA4MCA1MC44MzcgODAgMTEyVjgwQzgwIDcxLjE2MyA4Ny4xNjMgNjQgOTYgNjRaIiBmaWxsPSJ3aGl0ZSIvPgo8cGF0aCBkPSJNNjQgOTZDNjQgODcuMTYzIDcxLjE2MyA4MCA4MCA4MEgxMTJDMTIwLjgzNyA4MCAxMjggODcuMTYzIDEyOCA5NkMxMjggMTA0LjgzNyAxMjAuODM3IDExMiAxMTIgMTEySDgwQzcxLjE2MyAxMTIgNjQgMTA0LjgzNyA2NCA5NloiIGZpbGw9IndoaXRlIiBmaWxsLW9wYWNpdHk9IjAuOCIvPgo8ZGVmcz4KPGxpbmVhckdyYWRpZW50IGlkPSJncmFkaWVudDBfbGluZWFyXzFfMSIgeDE9IjAiIHkxPSIwIiB4Mj0iMTkyIiB5Mj0iMTkyIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+CjxzdG9wIHN0b3AtY29sb3I9IiMzQjgyRjYiLz4KPHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjOUMzNUY2Ii8+CjwvbGluZWFyR3JhZGllbnQ+CjwvZGVmcz4KPC9zdmc+';
  }

  // Predefined notification types
  async showWelcomeNotification(userName: string) {
    return this.showLocalNotification({
      title: '🎉 Welcome to Empower!',
      body: `Hi ${userName}! Ready to boost your health and wealth knowledge?`,
      tag: 'welcome',
      data: { screen: 'dashboard' }
    });
  }

  async showLevelUpNotification(level: number) {
    return this.showLocalNotification({
      title: '🌟 Level Up!',
      body: `Congratulations! You've reached Level ${level}. Keep up the great work!`,
      tag: 'levelup',
      data: { screen: 'profile' }
    });
  }

  async showStreakNotification(streak: number) {
    return this.showLocalNotification({
      title: '🔥 Streak Master!',
      body: `Amazing! You've maintained your streak for ${streak} days straight!`,
      tag: 'streak',
      data: { screen: 'dashboard' }
    });
  }

  async showAchievementNotification(title: string, body: string, data?: any) {
    return this.showLocalNotification({
      title: `🏆 Achievement: ${title}`,
      body,
      tag: 'achievement',
      data: data || { screen: 'profile' }
    });
  }

  async showDailyReminder() {
    const messages = [
      'Time to boost your health knowledge! 💪',
      'Ready for today\'s wealth wisdom? 💰',
      'Your daily learning awaits! 📚',
      'Keep your streak alive! 🔥',
      'Quick knowledge boost? Let\'s go! 🚀'
    ];

    const randomMessage = messages[Math.floor(Math.random() * messages.length)];

    return this.showLocalNotification({
      title: '📱 Empower Reminder',
      body: randomMessage,
      tag: 'daily-reminder',
      data: { screen: 'dashboard' }
    });
  }

  async showTaskCompletionReminder() {
    return this.showLocalNotification({
      title: '✅ Complete Your Tasks',
      body: 'You have pending daily tasks. Complete them to maintain your streak!',
      tag: 'task-reminder',
      data: { screen: 'dashboard' }
    });
  }

  async showQuizInvitation(category: 'health' | 'wealth') {
    return this.showLocalNotification({
      title: '🧠 Quiz Time!',
      body: `Test your ${category} knowledge and earn XP!`,
      tag: 'quiz-invitation',
      data: { screen: category, action: 'quiz', category }
    });
  }

  // Utility methods
  getQueuedNotificationCount(): number {
    return this.notificationQueue.length;
  }

  clearQueue(): void {
    this.notificationQueue = [];
    console.log('Push Service: Notification queue cleared');
  }

  getPermission(): NotificationPermission {
    return this.permission;
  }

  async scheduleDaily(hour = 9, minute = 0) {
    // Simple daily reminder scheduling (in a real app, you'd use a more sophisticated system)
    const now = new Date();
    const scheduledTime = new Date();
    scheduledTime.setHours(hour, minute, 0, 0);

    // If the time has passed today, schedule for tomorrow
    if (scheduledTime < now) {
      scheduledTime.setDate(scheduledTime.getDate() + 1);
    }

    const timeUntilReminder = scheduledTime.getTime() - now.getTime();
    
    setTimeout(() => {
      this.showDailyReminder();
      // Reschedule for the next day
      this.scheduleDaily(hour, minute);
    }, timeUntilReminder);

    console.log('Push Service: Daily reminder scheduled for', scheduledTime);
  }

  // Check if notifications are currently blocked or denied
  areNotificationsBlocked(): boolean {
    return this.permission === 'denied';
  }

  // Check if we can show notifications right now
  canShowNotifications(): boolean {
    return this.permission === 'granted' && this.isSupported();
  }
}

// Export singleton instance
export const pushNotificationService = PushNotificationService.getInstance();