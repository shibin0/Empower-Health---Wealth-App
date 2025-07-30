import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Progress } from './ui/progress';
import { Badge } from './ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';
import { Input } from './ui/input';
import { Label } from './ui/label';
import { 
  Heart, 
  Brain, 
  Utensils, 
  Moon, 
  Activity,
  Play,
  CheckCircle,
  Plus,
  TrendingUp,
  Calendar
} from 'lucide-react';

interface HealthSectionProps {
  userProfile: any;
}

export function HealthSection({ userProfile }: HealthSectionProps) {
  const [activeTracker, setActiveTracker] = useState<string | null>(null);
  const [trackerData, setTrackerData] = useState({
    water: 6,
    steps: 8500,
    sleep: 7.5,
    mood: 4
  });

  const healthModules = [
    {
      id: 'nutrition',
      title: 'Nutrition Basics',
      icon: Utensils,
      color: 'text-green-500',
      progress: 75,
      lessons: 12,
      description: 'Learn about balanced eating and meal planning',
      topics: ['Macronutrients', 'Portion Control', 'Meal Prep', 'Indian Diet']
    },
    {
      id: 'fitness',
      title: 'Home Workouts',
      icon: Activity,
      color: 'text-orange-500',
      progress: 40,
      lessons: 15,
      description: 'Exercise routines you can do anywhere',
      topics: ['Bodyweight Exercises', 'HIIT', 'Yoga', 'Strength Training']
    },
    {
      id: 'sleep',
      title: 'Sleep & Recovery',
      icon: Moon,
      color: 'text-blue-500',
      progress: 60,
      lessons: 8,
      description: 'Master the science of quality sleep',
      topics: ['Sleep Hygiene', 'Recovery', 'Stress Management', 'Circadian Rhythm']
    },
    {
      id: 'mental',
      title: 'Mental Wellness',
      icon: Brain,
      color: 'text-purple-500',
      progress: 30,
      lessons: 10,
      description: 'Build resilience and emotional intelligence',
      topics: ['Mindfulness', 'Stress Relief', 'Self-Care', 'Productivity']
    }
  ];

  const dailyTips = [
    "💡 Drink a glass of water first thing in the morning to kickstart your metabolism",
    "🥗 Try to fill half your plate with vegetables at lunch and dinner",
    "🚶 Take a 10-minute walk after meals to improve digestion",
    "😴 Keep your bedroom cool (65-68°F) for better sleep quality"
  ];

  const updateTracker = (type: string, value: number) => {
    setTrackerData(prev => ({ ...prev, [type]: value }));
  };

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="text-center space-y-2">
        <h1 className="flex items-center justify-center gap-2">
          <Heart className="h-6 w-6 text-red-500" />
          Health Journey
        </h1>
        <p className="text-muted-foreground text-sm">Your path to better wellness</p>
      </div>

      <Tabs defaultValue="learn" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="learn">Learn</TabsTrigger>
          <TabsTrigger value="track">Track</TabsTrigger>
          <TabsTrigger value="tips">Tips</TabsTrigger>
        </TabsList>

        <TabsContent value="learn" className="space-y-4 mt-6">
          {/* Learning Modules */}
          {healthModules.map((module) => {
            const IconComponent = module.icon;
            return (
              <Card key={module.id}>
                <CardHeader className="pb-3">
                  <div className="flex items-center justify-between">
                    <CardTitle className="text-base flex items-center gap-2">
                      <IconComponent className={`h-5 w-5 ${module.color}`} />
                      {module.title}
                    </CardTitle>
                    <Badge variant="secondary" className="text-xs">
                      {module.lessons} lessons
                    </Badge>
                  </div>
                  <p className="text-sm text-muted-foreground">{module.description}</p>
                </CardHeader>
                
                <CardContent className="space-y-4">
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span>Progress</span>
                      <span>{module.progress}%</span>
                    </div>
                    <Progress value={module.progress} className="h-2" />
                  </div>
                  
                  <div className="flex flex-wrap gap-2">
                    {module.topics.map((topic, index) => (
                      <Badge key={index} variant="outline" className="text-xs">
                        {topic}
                      </Badge>
                    ))}
                  </div>
                  
                  <Button className="w-full" size="sm">
                    <Play className="h-4 w-4 mr-2" />
                    Continue Learning
                  </Button>
                </CardContent>
              </Card>
            );
          })}
        </TabsContent>

        <TabsContent value="track" className="space-y-4 mt-6">
          {/* Daily Trackers */}
          <div className="grid grid-cols-2 gap-4">
            {/* Water Intake */}
            <Card>
              <CardContent className="p-4 text-center">
                <div className="text-2xl mb-2">💧</div>
                <div className="space-y-2">
                  <Label className="text-sm">Water (glasses)</Label>
                  <div className="flex items-center justify-center space-x-2">
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => updateTracker('water', Math.max(0, trackerData.water - 1))}
                    >
                      -
                    </Button>
                    <span className="text-lg font-semibold w-8">{trackerData.water}</span>
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => updateTracker('water', trackerData.water + 1)}
                    >
                      +
                    </Button>
                  </div>
                  <div className="text-xs text-muted-foreground">Goal: 8 glasses</div>
                </div>
              </CardContent>
            </Card>

            {/* Steps */}
            <Card>
              <CardContent className="p-4 text-center">
                <div className="text-2xl mb-2">👟</div>
                <div className="space-y-2">
                  <Label className="text-sm">Steps Today</Label>
                  <div className="text-lg font-semibold">{trackerData.steps.toLocaleString()}</div>
                  <div className="text-xs text-muted-foreground">Goal: 10,000</div>
                  <Progress value={(trackerData.steps / 10000) * 100} className="h-1" />
                </div>
              </CardContent>
            </Card>

            {/* Sleep */}
            <Card>
              <CardContent className="p-4 text-center">
                <div className="text-2xl mb-2">😴</div>
                <div className="space-y-2">
                  <Label className="text-sm">Sleep (hours)</Label>
                  <div className="text-lg font-semibold">{trackerData.sleep}h</div>
                  <div className="text-xs text-muted-foreground">Goal: 7-8 hours</div>
                  <Button size="sm" variant="outline" className="text-xs">
                    Log Sleep
                  </Button>
                </div>
              </CardContent>
            </Card>

            {/* Mood */}
            <Card>
              <CardContent className="p-4 text-center">
                <div className="text-2xl mb-2">😊</div>
                <div className="space-y-2">
                  <Label className="text-sm">Mood (1-5)</Label>
                  <div className="flex justify-center space-x-1">
                    {[1, 2, 3, 4, 5].map((rating) => (
                      <button
                        key={rating}
                        onClick={() => updateTracker('mood', rating)}
                        className={`w-6 h-6 rounded-full text-xs ${
                          rating <= trackerData.mood
                            ? 'bg-yellow-400 text-white'
                            : 'bg-muted'
                        }`}
                      >
                        {rating}
                      </button>
                    ))}
                  </div>
                  <div className="text-xs text-muted-foreground">How are you feeling?</div>
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Quick Add Food */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Food Journal</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <div className="flex space-x-2">
                <Input placeholder="What did you eat?" className="flex-1" />
                <Button size="sm">
                  <Plus className="h-4 w-4" />
                </Button>
              </div>
              <div className="space-y-2">
                <div className="flex justify-between items-center text-sm">
                  <span>🍳 Breakfast: Oats with fruits</span>
                  <span className="text-muted-foreground">350 cal</span>
                </div>
                <div className="flex justify-between items-center text-sm">
                  <span>🥗 Lunch: Chicken salad</span>
                  <span className="text-muted-foreground">420 cal</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="tips" className="space-y-4 mt-6">
          {/* Daily Tips */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base flex items-center gap-2">
                <TrendingUp className="h-4 w-4" />
                Today's Health Tips
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {dailyTips.map((tip, index) => (
                <div key={index} className="p-3 bg-accent/50 rounded-lg">
                  <p className="text-sm">{tip}</p>
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Quick Challenges */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Weekly Challenges</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <div className="flex items-center justify-between p-3 border rounded-lg">
                <div className="flex items-center space-x-3">
                  <div className="text-lg">🥛</div>
                  <div>
                    <div className="text-sm font-medium">Hydration Hero</div>
                    <div className="text-xs text-muted-foreground">Drink 8 glasses daily for 7 days</div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="text-xs text-muted-foreground">4/7 days</div>
                  <Progress value={57} className="w-16 h-1 mt-1" />
                </div>
              </div>
              
              <div className="flex items-center justify-between p-3 border rounded-lg">
                <div className="flex items-center space-x-3">
                  <div className="text-lg">🚶</div>
                  <div>
                    <div className="text-sm font-medium">Step Master</div>
                    <div className="text-xs text-muted-foreground">10,000 steps for 5 days</div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="text-xs text-muted-foreground">2/5 days</div>
                  <Progress value={40} className="w-16 h-1 mt-1" />
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}