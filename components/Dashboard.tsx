import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Progress } from './ui/progress';
import { Badge } from './ui/badge';
import { 
  Heart, 
  DollarSign, 
  Trophy, 
  Flame, 
  Target, 
  BookOpen,
  TrendingUp,
  Calendar,
  Star,
  Brain,
  CheckCircle,
  Play
} from 'lucide-react';

interface DailyTask {
  id: string;
  title: string;
  type: 'health' | 'wealth';
  completed: boolean;
  xpReward: number;
  date: string;
}

interface DashboardProps {
  userProfile: any;
  dailyTasks?: DailyTask[];
  onCompleteTask?: (taskId: string) => void;
  onStartQuiz?: (category: 'health' | 'wealth') => void;
}

export function Dashboard({ userProfile, dailyTasks = [], onCompleteTask, onStartQuiz }: DashboardProps) {
  const completedTasks = dailyTasks.filter(task => task.completed).length;
  const weeklyProgress = dailyTasks.length > 0 ? (completedTasks / dailyTasks.length) * 100 : 0;

  const mockAchievements = [
    { title: 'Week Warrior', icon: '🔥', earned: (userProfile?.streak || 0) >= 7 },
    { title: 'Budget Beginner', icon: '💰', earned: true },
    { title: 'Fitness First', icon: '💪', earned: false }
  ];

  return (
    <div className="p-4 space-y-6">
      {/* Welcome Header */}
      <div className="text-center space-y-2">
        <h1>Hey {userProfile?.name || 'Champion'}! 👋</h1>
        <p className="text-muted-foreground">Ready to level up today?</p>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-3 gap-3">
        <Card className="text-center">
          <CardContent className="p-3">
            <div className="flex flex-col items-center space-y-1">
              <Flame className="h-5 w-5 text-orange-500" />
              <span className="text-xs text-muted-foreground">Streak</span>
              <span className="text-lg font-semibold">{userProfile?.streak || 0}</span>
            </div>
          </CardContent>
        </Card>
        
        <Card className="text-center">
          <CardContent className="p-3">
            <div className="flex flex-col items-center space-y-1">
              <Star className="h-5 w-5 text-yellow-500" />
              <span className="text-xs text-muted-foreground">Level</span>
              <span className="text-lg font-semibold">{userProfile?.level || 1}</span>
            </div>
          </CardContent>
        </Card>
        
        <Card className="text-center">
          <CardContent className="p-3">
            <div className="flex flex-col items-center space-y-1">
              <Trophy className="h-5 w-5 text-purple-500" />
              <span className="text-xs text-muted-foreground">XP</span>
              <span className="text-lg font-semibold">{userProfile?.xp || 0}</span>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Daily Progress */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <TrendingUp className="h-4 w-4" />
            Today's Progress
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span>Tasks Completed</span>
              <span>{completedTasks}/{dailyTasks.length}</span>
            </div>
            <Progress value={weeklyProgress} className="h-2" />
            <p className="text-xs text-muted-foreground">
              {weeklyProgress === 100 
                ? "Amazing! All tasks completed! 🎉" 
                : `${dailyTasks.length - completedTasks} tasks remaining`
              }
            </p>
          </div>
        </CardContent>
      </Card>

      {/* Today's Tasks */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Calendar className="h-4 w-4" />
            Today's Tasks
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {dailyTasks.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-4">
              No tasks available. Check back tomorrow! 😊
            </p>
          ) : (
            dailyTasks.map((task) => (
              <div key={task.id} className="flex items-center space-x-3">
                <button
                  onClick={() => onCompleteTask?.(task.id)}
                  disabled={task.completed}
                  className={`w-4 h-4 rounded-full border-2 flex items-center justify-center transition-colors ${
                    task.completed 
                      ? 'bg-green-500 border-green-500' 
                      : 'border-muted-foreground hover:border-primary'
                  }`}
                >
                  {task.completed && <CheckCircle className="w-3 h-3 text-white" />}
                </button>
                <div className="flex-1">
                  <span className={`text-sm ${task.completed ? 'line-through text-muted-foreground' : ''}`}>
                    {task.title}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <Badge variant={task.type === 'health' ? 'default' : 'secondary'} className="text-xs">
                    {task.type === 'health' ? (
                      <Heart className="h-3 w-3 mr-1" />
                    ) : (
                      <DollarSign className="h-3 w-3 mr-1" />
                    )}
                    {task.type}
                  </Badge>
                  <span className="text-xs text-muted-foreground">+{task.xpReward} XP</span>
                </div>
              </div>
            ))
          )}
        </CardContent>
      </Card>

      {/* Quick Actions */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Quick Start</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="grid grid-cols-2 gap-3">
            <Button variant="outline" className="h-auto p-4 flex flex-col items-center space-y-2">
              <Heart className="h-6 w-6 text-red-500" />
              <span className="text-xs">Health Lesson</span>
            </Button>
            
            <Button variant="outline" className="h-auto p-4 flex flex-col items-center space-y-2">
              <DollarSign className="h-6 w-6 text-green-500" />
              <span className="text-xs">Wealth Lesson</span>
            </Button>
            
            <Button 
              variant="outline" 
              className="h-auto p-4 flex flex-col items-center space-y-2"
              onClick={() => onStartQuiz?.('health')}
            >
              <Brain className="h-6 w-6 text-blue-500" />
              <span className="text-xs">Health Quiz</span>
            </Button>
            
            <Button 
              variant="outline" 
              className="h-auto p-4 flex flex-col items-center space-y-2"
              onClick={() => onStartQuiz?.('wealth')}
            >
              <Brain className="h-6 w-6 text-purple-500" />
              <span className="text-xs">Wealth Quiz</span>
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Achievements */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Trophy className="h-4 w-4" />
            Recent Achievements
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex space-x-4">
            {mockAchievements.map((achievement, index) => (
              <div key={index} className={`text-center ${!achievement.earned ? 'opacity-50' : ''}`}>
                <div className="text-2xl mb-1">{achievement.icon}</div>
                <span className="text-xs">{achievement.title}</span>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Goals Progress */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Your Goals</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div>
            <div className="flex justify-between items-center mb-2">
              <span className="text-sm flex items-center gap-2">
                <Heart className="h-4 w-4 text-red-500" />
                {userProfile?.healthGoal || 'Health Goal'}
              </span>
              <span className="text-xs text-muted-foreground">40%</span>
            </div>
            <Progress value={40} className="h-2" />
          </div>
          
          <div>
            <div className="flex justify-between items-center mb-2">
              <span className="text-sm flex items-center gap-2">
                <DollarSign className="h-4 w-4 text-green-500" />
                {userProfile?.wealthGoal || 'Wealth Goal'}
              </span>
              <span className="text-xs text-muted-foreground">60%</span>
            </div>
            <Progress value={60} className="h-2" />
          </div>
        </CardContent>
      </Card>

      {/* Level Progress */}
      {userProfile && (
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-base">Level Progress</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              <div className="flex justify-between text-sm">
                <span>Level {userProfile.level}</span>
                <span>Level {userProfile.level + 1}</span>
              </div>
              <Progress 
                value={((userProfile.xp % 500) / 500) * 100} 
                className="h-2" 
              />
              <div className="text-xs text-muted-foreground text-center">
                {userProfile.xp} / {(userProfile.level + 1) * 500} XP
              </div>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}