import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Switch } from './ui/switch';
import { Label } from './ui/label';
import { Input } from './ui/input';
import { ArrowLeft, Bell, Clock, Target, Brain } from 'lucide-react';
import { notificationService, NotificationSettings as INotificationSettings } from '../services/notificationService';
import { toast } from 'sonner@2.0.3';

interface NotificationSettingsProps {
  onBack: () => void;
}

export function NotificationSettings({ onBack }: NotificationSettingsProps) {
  const [settings, setSettings] = useState<INotificationSettings>(notificationService.getSettings());
  const [hasPermission, setHasPermission] = useState(false);

  useEffect(() => {
    checkPermission();
  }, []);

  const checkPermission = async () => {
    const permission = await notificationService.requestPermission();
    setHasPermission(permission);
  };

  const updateSetting = (key: keyof INotificationSettings, value: boolean | string) => {
    const newSettings = { ...settings, [key]: value };
    setSettings(newSettings);
    notificationService.updateSettings(newSettings);
    toast.success('Notification settings updated!');
  };

  const testNotification = () => {
    notificationService.showNotification('🔔 Test Notification', {
      body: 'Your notifications are working perfectly!',
    });
  };

  const requestPermission = async () => {
    const granted = await notificationService.requestPermission();
    setHasPermission(granted);
    if (granted) {
      toast.success('Notifications enabled! 🎉');
    } else {
      toast.error('Notifications blocked. Please enable in browser settings.');
    }
  };

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-2 hover:bg-accent rounded-lg">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <h1 className="text-xl font-semibold flex items-center gap-2">
          <Bell className="h-5 w-5" />
          Notifications
        </h1>
      </div>

      {/* Permission Status */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Permission Status</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex items-center justify-between">
            <div>
              <div className="font-medium">Browser Notifications</div>
              <div className="text-sm text-muted-foreground">
                {hasPermission ? 'Enabled' : 'Disabled'}
              </div>
            </div>
            <div className="flex items-center gap-2">
              <div className={`w-3 h-3 rounded-full ${hasPermission ? 'bg-green-500' : 'bg-red-500'}`} />
              {!hasPermission && (
                <Button onClick={requestPermission} size="sm">
                  Enable
                </Button>
              )}
            </div>
          </div>
          
          {hasPermission && (
            <Button onClick={testNotification} variant="outline" size="sm">
              Test Notification
            </Button>
          )}
        </CardContent>
      </Card>

      {/* Notification Types */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Notification Types</CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          {/* Daily Reminder */}
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Clock className="h-5 w-5 text-blue-500" />
              <div>
                <Label htmlFor="daily-reminder" className="cursor-pointer">
                  Daily Reminders
                </Label>
                <div className="text-sm text-muted-foreground">
                  Get reminded to complete your daily tasks
                </div>
              </div>
            </div>
            <Switch
              id="daily-reminder"
              checked={settings.dailyReminder}
              onCheckedChange={(checked) => updateSetting('dailyReminder', checked)}
            />
          </div>

          {/* Goal Check */}
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Target className="h-5 w-5 text-green-500" />
              <div>
                <Label htmlFor="goal-check" className="cursor-pointer">
                  Goal Progress
                </Label>
                <div className="text-sm text-muted-foreground">
                  Celebrate when you reach goal milestones
                </div>
              </div>
            </div>
            <Switch
              id="goal-check"
              checked={settings.goalCheck}
              onCheckedChange={(checked) => updateSetting('goalCheck', checked)}
            />
          </div>

          {/* Streak Warning */}
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="text-lg">🔥</div>
              <div>
                <Label htmlFor="streak-warning" className="cursor-pointer">
                  Streak Warnings
                </Label>
                <div className="text-sm text-muted-foreground">
                  Get warned before losing your streak
                </div>
              </div>
            </div>
            <Switch
              id="streak-warning"
              checked={settings.streakWarning}
              onCheckedChange={(checked) => updateSetting('streakWarning', checked)}
            />
          </div>

          {/* Learning Reminder */}
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Brain className="h-5 w-5 text-purple-500" />
              <div>
                <Label htmlFor="learning-reminder" className="cursor-pointer">
                  Learning Reminders
                </Label>
                <div className="text-sm text-muted-foreground">
                  Periodic reminders to learn something new
                </div>
              </div>
            </div>
            <Switch
              id="learning-reminder"
              checked={settings.learningReminder}
              onCheckedChange={(checked) => updateSetting('learningReminder', checked)}
            />
          </div>
        </CardContent>
      </Card>

      {/* Timing */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Timing</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <Label htmlFor="notification-time">Preferred notification time</Label>
            <Input
              id="notification-time"
              type="time"
              value={settings.time}
              onChange={(e) => updateSetting('time', e.target.value)}
              className="w-full"
            />
            <div className="text-sm text-muted-foreground">
              Daily reminders will be sent at this time
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Info */}
      <Card>
        <CardContent className="pt-6">
          <div className="space-y-2">
            <h4 className="font-medium">About Notifications</h4>
            <ul className="text-sm text-muted-foreground space-y-1">
              <li>• Notifications help you maintain consistency</li>
              <li>• You can disable them anytime</li>
              <li>• Data stays private on your device</li>
              <li>• Turn off specific types as needed</li>
            </ul>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}