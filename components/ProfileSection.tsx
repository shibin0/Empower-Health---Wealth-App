import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Badge } from './ui/badge';
import { Progress } from './ui/progress';
import { 
  User, 
  Trophy, 
  Target, 
  Calendar, 
  Bell, 
  Settings, 
  LogOut,
  Star,
  Flame,
  Brain,
  TrendingUp,
  Award,
  Edit
} from 'lucide-react';
import { UserProfile } from '../services/authService';

interface ProfileSectionProps {
  userProfile: UserProfile | null;
  setUserProfile: (profile: UserProfile | null) => void;
  achievements: any[];
  quizHistory: any[];
  onOpenNotifications: () => void;
  onSignOut: () => void;
}

export function ProfileSection({ 
  userProfile, 
  setUserProfile, 
  achievements, 
  quizHistory, 
  onOpenNotifications,
  onSignOut 
}: ProfileSectionProps) {
  if (!userProfile) {
    return (
      <div className="p-4 text-center">
        <p className="text-muted-foreground">Loading profile...</p>
      </div>
    );
  }

  const nextLevelXP = (userProfile.level + 1) * 500;
  const currentLevelXP = userProfile.level * 500;
  const progressToNextLevel = ((userProfile.xp - currentLevelXP) / (nextLevelXP - currentLevelXP)) * 100;

  const joinedDate = new Date(userProfile.joinedDate);
  const daysSinceJoined = Math.floor((Date.now() - joinedDate.getTime()) / (1000 * 60 * 60 * 24));

  const mockAchievements = [
    { id: '1', title: 'First Steps', icon: '👶', earned: true },
    { id: '2', title: 'Week Warrior', icon: '🔥', earned: userProfile.streak >= 7 },
    { id: '3', title: 'Quiz Master', icon: '🧠', earned: userProfile.totalQuizzesTaken >= 10 },
    { id: '4', title: 'Learning Streak', icon: '📚', earned: userProfile.totalLessonsCompleted >= 20 },
    { id: '5', title: 'Level 5', icon: '🌟', earned: userProfile.level >= 5 },
    { id: '6', title: 'Month Master', icon: '👑', earned: userProfile.streak >= 30 },
  ];

  const earnedAchievements = mockAchievements.filter(a => a.earned);

  return (
    <div className="p-4 space-y-6">
      {/* Profile Header */}
      <Card>
        <CardHeader className="text-center">
          <div className="w-20 h-20 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4">
            <User className="h-10 w-10 text-white" />
          </div>
          <CardTitle className="text-xl">{userProfile.name}</CardTitle>
          <p className="text-muted-foreground">{userProfile.email}</p>
          <div className="flex items-center justify-center gap-4 mt-4">
            <Badge variant="secondary" className="flex items-center gap-1">
              <Star className="h-3 w-3" />
              Level {userProfile.level}
            </Badge>
            <Badge variant="outline" className="flex items-center gap-1">
              <Flame className="h-3 w-3" />
              {userProfile.streak} day streak
            </Badge>
          </div>
        </CardHeader>
      </Card>

      {/* Stats */}
      <div className="grid grid-cols-2 gap-4">
        <Card>
          <CardContent className="p-4 text-center">
            <div className="text-2xl font-bold text-blue-600">{userProfile.xp}</div>
            <div className="text-sm text-muted-foreground">Total XP</div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4 text-center">
            <div className="text-2xl font-bold text-green-600">{earnedAchievements.length}</div>
            <div className="text-sm text-muted-foreground">Achievements</div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4 text-center">
            <div className="text-2xl font-bold text-purple-600">{userProfile.totalQuizzesTaken || 0}</div>
            <div className="text-sm text-muted-foreground">Quizzes Taken</div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4 text-center">
            <div className="text-2xl font-bold text-orange-600">{daysSinceJoined}</div>
            <div className="text-sm text-muted-foreground">Days Active</div>
          </CardContent>
        </Card>
      </div>

      {/* Level Progress */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <TrendingUp className="h-4 w-4" />
            Level Progress
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span>Level {userProfile.level}</span>
              <span>Level {userProfile.level + 1}</span>
            </div>
            <Progress value={progressToNextLevel} className="h-2" />
            <div className="text-xs text-muted-foreground text-center">
              {userProfile.xp - currentLevelXP} / {nextLevelXP - currentLevelXP} XP to next level
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Goals */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Target className="h-4 w-4" />
            Your Goals
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="flex items-center justify-between">
            <div>
              <div className="font-medium">Health Goal</div>
              <div className="text-sm text-muted-foreground">
                {userProfile.healthGoal || 'Not set'}
              </div>
            </div>
            <Button variant="ghost" size="sm">
              <Edit className="h-4 w-4" />
            </Button>
          </div>
          <div className="flex items-center justify-between">
            <div>
              <div className="font-medium">Wealth Goal</div>
              <div className="text-sm text-muted-foreground">
                {userProfile.wealthGoal || 'Not set'}
              </div>
            </div>
            <Button variant="ghost" size="sm">
              <Edit className="h-4 w-4" />
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Achievements */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Trophy className="h-4 w-4" />
            Achievements ({earnedAchievements.length}/{mockAchievements.length})
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-3 gap-4">
            {mockAchievements.map((achievement) => (
              <div
                key={achievement.id}
                className={`text-center p-3 rounded-lg border ${
                  achievement.earned 
                    ? 'bg-accent border-primary' 
                    : 'bg-muted/50 border-muted opacity-50'
                }`}
              >
                <div className="text-2xl mb-1">{achievement.icon}</div>
                <div className="text-xs font-medium">{achievement.title}</div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Recent Activity */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Calendar className="h-4 w-4" />
            Recent Activity
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 bg-green-100 rounded-full flex items-center justify-center">
                <Brain className="h-4 w-4 text-green-600" />
              </div>
              <div className="flex-1">
                <div className="text-sm font-medium">Quiz completed</div>
                <div className="text-xs text-muted-foreground">2 hours ago</div>
              </div>
              <div className="text-sm text-green-600">+25 XP</div>
            </div>
            
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                <Target className="h-4 w-4 text-blue-600" />
              </div>
              <div className="flex-1">
                <div className="text-sm font-medium">Daily task completed</div>
                <div className="text-xs text-muted-foreground">5 hours ago</div>
              </div>
              <div className="text-sm text-blue-600">+15 XP</div>
            </div>
            
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 bg-purple-100 rounded-full flex items-center justify-center">
                <Award className="h-4 w-4 text-purple-600" />
              </div>
              <div className="flex-1">
                <div className="text-sm font-medium">Achievement unlocked</div>
                <div className="text-xs text-muted-foreground">1 day ago</div>
              </div>
              <div className="text-sm text-purple-600">Week Warrior</div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Settings */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Settings className="h-4 w-4" />
            Settings
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <Button 
            variant="outline" 
            className="w-full justify-start"
            onClick={onOpenNotifications}
          >
            <Bell className="h-4 w-4 mr-2" />
            Notifications
          </Button>
          
          <Button 
            variant="outline" 
            className="w-full justify-start"
            onClick={onSignOut}
          >
            <LogOut className="h-4 w-4 mr-2" />
            Sign Out
          </Button>
        </CardContent>
      </Card>

      {/* Account Info */}
      <Card>
        <CardContent className="pt-6">
          <div className="text-center space-y-2">
            <div className="text-sm text-muted-foreground">
              Member since {joinedDate.toLocaleDateString()}
            </div>
            <div className="text-xs text-muted-foreground">
              Your data is secure and stays private
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}