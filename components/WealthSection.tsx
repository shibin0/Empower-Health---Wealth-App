import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Progress } from './ui/progress';
import { Badge } from './ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';
import { Input } from './ui/input';
import { Label } from './ui/label';
import { 
  DollarSign, 
  PiggyBank, 
  TrendingUp, 
  CreditCard,
  Shield,
  Play,
  Plus,
  Minus,
  Calculator,
  Target,
  BookOpen
} from 'lucide-react';

interface WealthSectionProps {
  userProfile: any;
}

export function WealthSection({ userProfile }: WealthSectionProps) {
  const [expenses, setExpenses] = useState([
    { id: 1, category: 'Food', amount: 150, date: 'Today' },
    { id: 2, category: 'Transport', amount: 80, date: 'Today' },
    { id: 3, category: 'Entertainment', amount: 200, date: 'Yesterday' }
  ]);
  const [newExpense, setNewExpense] = useState({ category: '', amount: '' });

  const wealthModules = [
    {
      id: 'budgeting',
      title: 'Smart Budgeting',
      icon: Calculator,
      color: 'text-green-500',
      progress: 80,
      lessons: 8,
      description: 'Master the 50-30-20 rule and track expenses',
      topics: ['Monthly Budget', 'Expense Tracking', 'Savings Goals', 'Emergency Fund']
    },
    {
      id: 'investing',
      title: 'Investment Basics',
      icon: TrendingUp,
      color: 'text-blue-500',
      progress: 45,
      lessons: 12,
      description: 'SIPs, mutual funds, and stock basics',
      topics: ['SIP', 'Mutual Funds', 'Stock Market', 'Risk Management']
    },
    {
      id: 'credit',
      title: 'Credit & Loans',
      icon: CreditCard,
      color: 'text-red-500',
      progress: 20,
      lessons: 10,
      description: 'Understand credit scores and avoid debt traps',
      topics: ['Credit Score', 'Credit Cards', 'EMI Planning', 'Debt Management']
    },
    {
      id: 'insurance',
      title: 'Insurance Planning',
      icon: Shield,
      color: 'text-purple-500',
      progress: 15,
      lessons: 6,
      description: 'Protect your wealth with smart insurance',
      topics: ['Health Insurance', 'Term Insurance', 'Motor Insurance', 'Tax Benefits']
    }
  ];

  const financialTips = [
    "💰 Save at least 20% of your income every month",
    "📊 Review your expenses weekly to identify spending patterns",
    "🎯 Set up automatic transfers to your savings account",
    "💳 Pay your credit card bills in full to avoid interest charges"
  ];

  const monthlyBudget = {
    income: 45000,
    expenses: 32000,
    savings: 13000,
    categories: [
      { name: 'Rent', budgeted: 18000, spent: 18000, color: 'bg-red-500' },
      { name: 'Food', budgeted: 8000, spent: 6500, color: 'bg-green-500' },
      { name: 'Transport', budgeted: 3000, spent: 2800, color: 'bg-blue-500' },
      { name: 'Entertainment', budgeted: 3000, spent: 3200, color: 'bg-purple-500' },
      { name: 'Shopping', budgeted: 2000, spent: 1500, color: 'bg-yellow-500' }
    ]
  };

  const addExpense = () => {
    if (newExpense.category && newExpense.amount) {
      setExpenses(prev => [
        { 
          id: Date.now(), 
          category: newExpense.category, 
          amount: parseFloat(newExpense.amount), 
          date: 'Today' 
        },
        ...prev
      ]);
      setNewExpense({ category: '', amount: '' });
    }
  };

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="text-center space-y-2">
        <h1 className="flex items-center justify-center gap-2">
          <DollarSign className="h-6 w-6 text-green-500" />
          Wealth Journey
        </h1>
        <p className="text-muted-foreground text-sm">Build your financial future</p>
      </div>

      <Tabs defaultValue="learn" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="learn">Learn</TabsTrigger>
          <TabsTrigger value="budget">Budget</TabsTrigger>
          <TabsTrigger value="tips">Tips</TabsTrigger>
        </TabsList>

        <TabsContent value="learn" className="space-y-4 mt-6">
          {/* Learning Modules */}
          {wealthModules.map((module) => {
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

        <TabsContent value="budget" className="space-y-4 mt-6">
          {/* Monthly Overview */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Monthly Overview</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-3 gap-4 text-center">
                <div>
                  <div className="text-xs text-muted-foreground">Income</div>
                  <div className="text-lg font-semibold text-green-600">₹{monthlyBudget.income.toLocaleString()}</div>
                </div>
                <div>
                  <div className="text-xs text-muted-foreground">Expenses</div>
                  <div className="text-lg font-semibold text-red-600">₹{monthlyBudget.expenses.toLocaleString()}</div>
                </div>
                <div>
                  <div className="text-xs text-muted-foreground">Savings</div>
                  <div className="text-lg font-semibold text-blue-600">₹{monthlyBudget.savings.toLocaleString()}</div>
                </div>
              </div>
              
              <div className="space-y-2">
                <div className="text-sm font-medium">Savings Rate</div>
                <Progress value={(monthlyBudget.savings / monthlyBudget.income) * 100} className="h-3" />
                <div className="text-xs text-muted-foreground text-right">
                  {Math.round((monthlyBudget.savings / monthlyBudget.income) * 100)}% (Goal: 20%)
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Budget Categories */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Budget vs Actual</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              {monthlyBudget.categories.map((category, index) => (
                <div key={index} className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span className="flex items-center gap-2">
                      <div className={`w-3 h-3 rounded-full ${category.color}`}></div>
                      {category.name}
                    </span>
                    <span>₹{category.spent} / ₹{category.budgeted}</span>
                  </div>
                  <Progress 
                    value={(category.spent / category.budgeted) * 100} 
                    className={`h-2 ${category.spent > category.budgeted ? '[&>div]:bg-red-500' : ''}`}
                  />
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Expense Tracker */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Add Expense</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex space-x-2">
                <Input
                  placeholder="Category"
                  value={newExpense.category}
                  onChange={(e) => setNewExpense(prev => ({ ...prev, category: e.target.value }))}
                  className="flex-1"
                />
                <Input
                  type="number"
                  placeholder="Amount"
                  value={newExpense.amount}
                  onChange={(e) => setNewExpense(prev => ({ ...prev, amount: e.target.value }))}
                  className="w-24"
                />
                <Button onClick={addExpense} size="sm">
                  <Plus className="h-4 w-4" />
                </Button>
              </div>

              <div className="space-y-2">
                <h4 className="text-sm font-medium">Recent Expenses</h4>
                {expenses.slice(0, 5).map((expense) => (
                  <div key={expense.id} className="flex justify-between items-center text-sm">
                    <span>{expense.category}</span>
                    <div className="text-right">
                      <div>₹{expense.amount}</div>
                      <div className="text-xs text-muted-foreground">{expense.date}</div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Investment Portfolio Simulator */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base flex items-center gap-2">
                <TrendingUp className="h-4 w-4" />
                Investment Simulator
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-2 gap-4 text-center">
                <div className="p-3 bg-green-50 rounded-lg">
                  <div className="text-xs text-muted-foreground">Portfolio Value</div>
                  <div className="text-lg font-semibold text-green-600">₹25,400</div>
                  <div className="text-xs text-green-600">+12.5% ↗</div>
                </div>
                <div className="p-3 bg-blue-50 rounded-lg">
                  <div className="text-xs text-muted-foreground">Monthly SIP</div>
                  <div className="text-lg font-semibold text-blue-600">₹5,000</div>
                  <div className="text-xs text-muted-foreground">3 funds</div>
                </div>
              </div>
              
              <Button variant="outline" className="w-full">
                <BookOpen className="h-4 w-4 mr-2" />
                Learn About SIPs
              </Button>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="tips" className="space-y-4 mt-6">
          {/* Financial Tips */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base flex items-center gap-2">
                <Target className="h-4 w-4" />
                Today's Wealth Tips
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {financialTips.map((tip, index) => (
                <div key={index} className="p-3 bg-accent/50 rounded-lg">
                  <p className="text-sm">{tip}</p>
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Financial Challenges */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Monthly Challenges</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <div className="flex items-center justify-between p-3 border rounded-lg">
                <div className="flex items-center space-x-3">
                  <div className="text-lg">💰</div>
                  <div>
                    <div className="text-sm font-medium">Save ₹100 Daily</div>
                    <div className="text-xs text-muted-foreground">Save small amounts consistently</div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="text-xs text-muted-foreground">15/30 days</div>
                  <Progress value={50} className="w-16 h-1 mt-1" />
                </div>
              </div>
              
              <div className="flex items-center justify-between p-3 border rounded-lg">
                <div className="flex items-center space-x-3">
                  <div className="text-lg">📊</div>
                  <div>
                    <div className="text-sm font-medium">Track Every Expense</div>
                    <div className="text-xs text-muted-foreground">Log all expenses for 30 days</div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="text-xs text-muted-foreground">22/30 days</div>
                  <Progress value={73} className="w-16 h-1 mt-1" />
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Quick Calculators */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Quick Calculators</CardTitle>
            </CardHeader>
            <CardContent className="grid grid-cols-2 gap-3">
              <Button variant="outline" className="h-auto p-4 flex flex-col items-center space-y-2">
                <Calculator className="h-5 w-5" />
                <span className="text-xs">SIP Calculator</span>
              </Button>
              
              <Button variant="outline" className="h-auto p-4 flex flex-col items-center space-y-2">
                <PiggyBank className="h-5 w-5" />
                <span className="text-xs">Goal Planner</span>
              </Button>
              
              <Button variant="outline" className="h-auto p-4 flex flex-col items-center space-y-2">
                <CreditCard className="h-5 w-5" />
                <span className="text-xs">EMI Calculator</span>
              </Button>
              
              <Button variant="outline" className="h-auto p-4 flex flex-col items-center space-y-2">
                <TrendingUp className="h-5 w-5" />
                <span className="text-xs">Return Calculator</span>
              </Button>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}