import { useState } from 'react';
import { Button } from './ui/button';
import { Card, CardContent } from './ui/card';
import { Input } from './ui/input';
import { Label } from './ui/label';
import { RadioGroup, RadioGroupItem } from './ui/radio-group';
import { Checkbox } from './ui/checkbox';
import { ArrowRight, Target, Heart, DollarSign } from 'lucide-react';

interface OnboardingProps {
  onComplete: (profile: any) => void;
}

export function Onboarding({ onComplete }: OnboardingProps) {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    name: '',
    age: '',
    city: '',
    primaryGoals: [] as string[],
    healthGoal: '',
    wealthGoal: '',
    currentLevel: 'beginner'
  });

  const handleGoalToggle = (goal: string) => {
    setFormData(prev => ({
      ...prev,
      primaryGoals: prev.primaryGoals.includes(goal)
        ? prev.primaryGoals.filter(g => g !== goal)
        : [...prev.primaryGoals, goal]
    }));
  };

  const handleNext = () => {
    if (step < 4) {
      setStep(step + 1);
    } else {
      // Complete onboarding
      const profile = {
        ...formData,
        xp: 0,
        level: 1,
        streak: 0,
        badges: []
      };
      onComplete(profile);
    }
  };

  const canProceed = () => {
    switch (step) {
      case 1:
        return formData.name && formData.age && formData.city;
      case 2:
        return formData.primaryGoals.length > 0;
      case 3:
        return formData.healthGoal && formData.wealthGoal;
      case 4:
        return formData.currentLevel;
      default:
        return false;
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-50 to-blue-50 p-4 flex flex-col">
      {/* Progress Bar */}
      <div className="w-full bg-muted rounded-full h-2 mb-8 mt-4">
        <div 
          className="bg-primary h-2 rounded-full transition-all duration-300"
          style={{ width: `${(step / 4) * 100}%` }}
        />
      </div>

      <div className="flex-1 flex flex-col justify-center">
        {step === 1 && (
          <Card className="mx-auto w-full max-w-sm">
            <CardContent className="p-6 space-y-6">
              <div className="text-center space-y-2">
                <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto">
                  <Target className="h-8 w-8 text-primary" />
                </div>
                <h2>Welcome to Empower!</h2>
                <p className="text-muted-foreground text-sm">Let's start your journey to better health and wealth</p>
              </div>
              
              <div className="space-y-4">
                <div>
                  <Label htmlFor="name">Your Name</Label>
                  <Input
                    id="name"
                    placeholder="Enter your name"
                    value={formData.name}
                    onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                  />
                </div>
                
                <div>
                  <Label htmlFor="age">Age</Label>
                  <Input
                    id="age"
                    type="number"
                    placeholder="22-28"
                    value={formData.age}
                    onChange={(e) => setFormData(prev => ({ ...prev, age: e.target.value }))}
                  />
                </div>
                
                <div>
                  <Label htmlFor="city">City</Label>
                  <Input
                    id="city"
                    placeholder="Bangalore, Mumbai, Delhi..."
                    value={formData.city}
                    onChange={(e) => setFormData(prev => ({ ...prev, city: e.target.value }))}
                  />
                </div>
              </div>
            </CardContent>
          </Card>
        )}

        {step === 2 && (
          <Card className="mx-auto w-full max-w-sm">
            <CardContent className="p-6 space-y-6">
              <div className="text-center space-y-2">
                <h2>What matters most to you?</h2>
                <p className="text-muted-foreground text-sm">Choose 1-2 areas you want to focus on</p>
              </div>
              
              <div className="space-y-3">
                {[
                  { id: 'fitness', label: 'Get Fit & Healthy', icon: '💪' },
                  { id: 'nutrition', label: 'Eat Better', icon: '🥗' },
                  { id: 'mental', label: 'Mental Wellbeing', icon: '🧘' },
                  { id: 'budget', label: 'Budget & Save Money', icon: '💰' },
                  { id: 'invest', label: 'Learn Investing', icon: '📈' },
                  { id: 'debt', label: 'Manage Debt', icon: '💳' }
                ].map((goal) => (
                  <div
                    key={goal.id}
                    onClick={() => handleGoalToggle(goal.id)}
                    className={`flex items-center p-4 border rounded-lg cursor-pointer transition-colors ${
                      formData.primaryGoals.includes(goal.id)
                        ? 'border-primary bg-primary/5'
                        : 'border-border hover:bg-accent'
                    }`}
                  >
                    <span className="text-xl mr-3">{goal.icon}</span>
                    <span className="flex-1">{goal.label}</span>
                    <Checkbox checked={formData.primaryGoals.includes(goal.id)} />
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        )}

        {step === 3 && (
          <Card className="mx-auto w-full max-w-sm">
            <CardContent className="p-6 space-y-6">
              <div className="text-center space-y-2">
                <h2>Set Your Goals</h2>
                <p className="text-muted-foreground text-sm">What specific goals would you like to achieve?</p>
              </div>
              
              <div className="space-y-4">
                <div>
                  <Label htmlFor="health-goal" className="flex items-center gap-2">
                    <Heart className="h-4 w-4 text-red-500" />
                    Health Goal
                  </Label>
                  <Input
                    id="health-goal"
                    placeholder="e.g., Lose 5kg in 3 months"
                    value={formData.healthGoal}
                    onChange={(e) => setFormData(prev => ({ ...prev, healthGoal: e.target.value }))}
                  />
                </div>
                
                <div>
                  <Label htmlFor="wealth-goal" className="flex items-center gap-2">
                    <DollarSign className="h-4 w-4 text-green-500" />
                    Wealth Goal
                  </Label>
                  <Input
                    id="wealth-goal"
                    placeholder="e.g., Save ₹50,000 by December"
                    value={formData.wealthGoal}
                    onChange={(e) => setFormData(prev => ({ ...prev, wealthGoal: e.target.value }))}
                  />
                </div>
              </div>
            </CardContent>
          </Card>
        )}

        {step === 4 && (
          <Card className="mx-auto w-full max-w-sm">
            <CardContent className="p-6 space-y-6">
              <div className="text-center space-y-2">
                <h2>How would you rate yourself?</h2>
                <p className="text-muted-foreground text-sm">This helps us personalize your learning journey</p>
              </div>
              
              <RadioGroup
                value={formData.currentLevel}
                onValueChange={(value) => setFormData(prev => ({ ...prev, currentLevel: value }))}
              >
                <div className="flex items-center space-x-2 p-3 border rounded-lg">
                  <RadioGroupItem value="beginner" id="beginner" />
                  <Label htmlFor="beginner" className="flex-1">
                    <div>
                      <div>🌱 Complete Beginner</div>
                      <div className="text-xs text-muted-foreground">Just starting my health & wealth journey</div>
                    </div>
                  </Label>
                </div>
                
                <div className="flex items-center space-x-2 p-3 border rounded-lg">
                  <RadioGroupItem value="intermediate" id="intermediate" />
                  <Label htmlFor="intermediate" className="flex-1">
                    <div>
                      <div>🚀 Some Knowledge</div>
                      <div className="text-xs text-muted-foreground">I know basics but want to learn more</div>
                    </div>
                  </Label>
                </div>
                
                <div className="flex items-center space-x-2 p-3 border rounded-lg">
                  <RadioGroupItem value="advanced" id="advanced" />
                  <Label htmlFor="advanced" className="flex-1">
                    <div>
                      <div>⭐ Pretty Good</div>
                      <div className="text-xs text-muted-foreground">I have good habits but want to optimize</div>
                    </div>
                  </Label>
                </div>
              </RadioGroup>
            </CardContent>
          </Card>
        )}
      </div>

      <div className="mt-8">
        <Button 
          onClick={handleNext}
          disabled={!canProceed()}
          className="w-full"
          size="lg"
        >
          {step === 4 ? 'Start My Journey' : 'Continue'}
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </div>
    </div>
  );
}