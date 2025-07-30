import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from './ui/select';
import { 
  TrendingUp, 
  Users, 
  BookOpen, 
  Trophy,
  Activity,
  Clock,
  Target,
  BarChart3,
  PieChart,
  LineChart,
  Calendar,
  Download
} from 'lucide-react';
import { Button } from './ui/button';
import { Badge } from './ui/badge';

interface AnalyticsData {
  userMetrics: {
    totalUsers: number;
    activeUsers: number;
    newUsers: number;
    retentionRate: number;
    avgSessionDuration: number;
    dailyActiveUsers: Array<{ date: string; count: number }>;
  };
  contentMetrics: {
    totalContent: number;
    contentViews: number;
    avgCompletionRate: number;
    popularContent: Array<{
      id: string;
      title: string;
      views: number;
      completionRate: number;
      category: string;
    }>;
    categoryDistribution: Array<{ category: string; count: number; percentage: number }>;
  };
  engagementMetrics: {
    totalQuizzes: number;
    avgQuizScore: number;
    totalXP: number;
    achievementsUnlocked: number;
    streakDistribution: Array<{ range: string; count: number }>;
    dailyTaskCompletion: Array<{ date: string; completion: number }>;
  };
  communityMetrics: {
    totalChallenges: number;
    challengeParticipation: number;
    leaderboardActivity: number;
    socialShares: number;
  };
}

export function AnalyticsDashboard() {
  const [analyticsData, setAnalyticsData] = useState<AnalyticsData | null>(null);
  const [loading, setLoading] = useState(true);
  const [timeRange, setTimeRange] = useState('7d');

  // Sample analytics data
  const sampleData: AnalyticsData = {
    userMetrics: {
      totalUsers: 12450,
      activeUsers: 8920,
      newUsers: 340,
      retentionRate: 68.5,
      avgSessionDuration: 18.5,
      dailyActiveUsers: [
        { date: '2024-01-20', count: 8200 },
        { date: '2024-01-21', count: 8450 },
        { date: '2024-01-22', count: 8100 },
        { date: '2024-01-23', count: 8650 },
        { date: '2024-01-24', count: 8920 },
        { date: '2024-01-25', count: 9100 },
        { date: '2024-01-26', count: 8900 },
      ]
    },
    contentMetrics: {
      totalContent: 156,
      contentViews: 45670,
      avgCompletionRate: 78.3,
      popularContent: [
        {
          id: '1',
          title: 'Building Your First Budget',
          views: 3420,
          completionRate: 89.2,
          category: 'wealth'
        },
        {
          id: '2',
          title: 'Understanding Nutrition Basics',
          views: 2890,
          completionRate: 82.5,
          category: 'health'
        },
        {
          id: '3',
          title: 'Mental Health in the Workplace',
          views: 2650,
          completionRate: 76.8,
          category: 'health'
        },
        {
          id: '4',
          title: 'Investment Basics for Beginners',
          views: 2340,
          completionRate: 71.3,
          category: 'wealth'
        },
        {
          id: '5',
          title: 'Sleep Hygiene Guide',
          views: 2100,
          completionRate: 85.7,
          category: 'health'
        }
      ],
      categoryDistribution: [
        { category: 'Health', count: 78, percentage: 50 },
        { category: 'Wealth', count: 78, percentage: 50 }
      ]
    },
    engagementMetrics: {
      totalQuizzes: 8940,
      avgQuizScore: 76.8,
      totalXP: 2340000,
      achievementsUnlocked: 15670,
      streakDistribution: [
        { range: '1-3 days', count: 3400 },
        { range: '4-7 days', count: 2800 },
        { range: '8-14 days', count: 1900 },
        { range: '15-30 days', count: 1200 },
        { range: '30+ days', count: 620 }
      ],
      dailyTaskCompletion: [
        { date: '2024-01-20', completion: 72 },
        { date: '2024-01-21', completion: 75 },
        { date: '2024-01-22', completion: 68 },
        { date: '2024-01-23', completion: 81 },
        { date: '2024-01-24', completion: 78 },
        { date: '2024-01-25', completion: 83 },
        { date: '2024-01-26', completion: 79 },
      ]
    },
    communityMetrics: {
      totalChallenges: 24,
      challengeParticipation: 4560,
      leaderboardActivity: 8920,
      socialShares: 1230
    }
  };

  useEffect(() => {
    loadAnalytics();
  }, [timeRange]);

  const loadAnalytics = async () => {
    setLoading(true);
    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      setAnalyticsData(sampleData);
    } catch (error) {
      console.error('Failed to load analytics:', error);
    } finally {
      setLoading(false);
    }
  };

  const exportData = () => {
    const dataStr = JSON.stringify(analyticsData, null, 2);
    const dataBlob = new Blob([dataStr], { type: 'application/json' });
    const url = URL.createObjectURL(dataBlob);
    const link = document.createElement('a');
    link.href = url;
    link.download = `empower-analytics-${new Date().toISOString().split('T')[0]}.json`;
    link.click();
    URL.revokeObjectURL(url);
  };

  if (loading) {
    return (
      <div className="p-4 space-y-4">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded mb-4"></div>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
            {[...Array(4)].map((_, i) => (
              <div key={i} className="h-24 bg-gray-200 rounded"></div>
            ))}
          </div>
          <div className="h-64 bg-gray-200 rounded"></div>
        </div>
      </div>
    );
  }

  if (!analyticsData) return null;

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Analytics Dashboard</h1>
          <p className="text-muted-foreground">
            Track app performance and user engagement
          </p>
        </div>
        <div className="flex items-center gap-3">
          <Select value={timeRange} onValueChange={setTimeRange}>
            <SelectTrigger className="w-32">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="7d">Last 7 days</SelectItem>
              <SelectItem value="30d">Last 30 days</SelectItem>
              <SelectItem value="90d">Last 90 days</SelectItem>
              <SelectItem value="1y">Last year</SelectItem>
            </SelectContent>
          </Select>
          <Button variant="outline" onClick={exportData}>
            <Download className="h-4 w-4 mr-2" />
            Export
          </Button>
        </div>
      </div>

      {/* Key Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Total Users</p>
                <p className="text-2xl font-bold">{analyticsData.userMetrics.totalUsers.toLocaleString()}</p>
                <p className="text-xs text-green-600">+{analyticsData.userMetrics.newUsers} new this week</p>
              </div>
              <Users className="h-8 w-8 text-blue-500" />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Active Users</p>
                <p className="text-2xl font-bold">{analyticsData.userMetrics.activeUsers.toLocaleString()}</p>
                <p className="text-xs text-green-600">{analyticsData.userMetrics.retentionRate}% retention</p>
              </div>
              <Activity className="h-8 w-8 text-green-500" />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Content Views</p>
                <p className="text-2xl font-bold">{analyticsData.contentMetrics.contentViews.toLocaleString()}</p>
                <p className="text-xs text-green-600">{analyticsData.contentMetrics.avgCompletionRate}% completion</p>
              </div>
              <BookOpen className="h-8 w-8 text-purple-500" />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Total XP Earned</p>
                <p className="text-2xl font-bold">{(analyticsData.engagementMetrics.totalXP / 1000000).toFixed(1)}M</p>
                <p className="text-xs text-green-600">{analyticsData.engagementMetrics.achievementsUnlocked} achievements</p>
              </div>
              <Trophy className="h-8 w-8 text-yellow-500" />
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Detailed Analytics */}
      <Tabs defaultValue="users" className="space-y-6">
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="users">Users</TabsTrigger>
          <TabsTrigger value="content">Content</TabsTrigger>
          <TabsTrigger value="engagement">Engagement</TabsTrigger>
          <TabsTrigger value="community">Community</TabsTrigger>
        </TabsList>

        <TabsContent value="users" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <Card>
              <CardHeader>
                <CardTitle className="text-base flex items-center gap-2">
                  <LineChart className="h-5 w-5" />
                  Daily Active Users
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {analyticsData.userMetrics.dailyActiveUsers.map((day, index) => (
                    <div key={day.date} className="flex items-center justify-between">
                      <span className="text-sm">{day.date}</span>
                      <div className="flex items-center gap-2">
                        <div className="w-24 bg-gray-200 rounded-full h-2">
                          <div 
                            className="bg-blue-500 h-2 rounded-full"
                            style={{ width: `${(day.count / 10000) * 100}%` }}
                          />
                        </div>
                        <span className="text-sm font-medium">{day.count.toLocaleString()}</span>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">User Metrics</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center justify-between">
                  <span className="text-sm">Average Session Duration</span>
                  <span className="font-medium">{analyticsData.userMetrics.avgSessionDuration} min</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm">Retention Rate</span>
                  <span className="font-medium">{analyticsData.userMetrics.retentionRate}%</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-sm">New Users (7d)</span>
                  <span className="font-medium">{analyticsData.userMetrics.newUsers}</span>
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="content" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Popular Content</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {analyticsData.contentMetrics.popularContent.map((content, index) => (
                    <div key={content.id} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <span className="text-sm font-medium">{content.title}</span>
                        <Badge variant={content.category === 'health' ? 'default' : 'secondary'}>
                          {content.category}
                        </Badge>
                      </div>
                      <div className="flex items-center justify-between text-xs text-muted-foreground">
                        <span>{content.views} views</span>
                        <span>{content.completionRate}% completion</span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-1">
                        <div 
                          className="bg-green-500 h-1 rounded-full"
                          style={{ width: `${content.completionRate}%` }}
                        />
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base flex items-center gap-2">
                  <PieChart className="h-5 w-5" />
                  Content Distribution
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {analyticsData.contentMetrics.categoryDistribution.map((category) => (
                    <div key={category.category} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{category.category}</span>
                        <span className="text-sm font-medium">{category.count} items</span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-2">
                        <div 
                          className={`h-2 rounded-full ${
                            category.category === 'Health' ? 'bg-red-500' : 'bg-green-500'
                          }`}
                          style={{ width: `${category.percentage}%` }}
                        />
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="engagement" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Streak Distribution</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {analyticsData.engagementMetrics.streakDistribution.map((streak) => (
                    <div key={streak.range} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{streak.range}</span>
                        <span className="text-sm font-medium">{streak.count} users</span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-2">
                        <div 
                          className="bg-orange-500 h-2 rounded-full"
                          style={{ width: `${(streak.count / 3400) * 100}%` }}
                        />
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">Daily Task Completion</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {analyticsData.engagementMetrics.dailyTaskCompletion.map((day) => (
                    <div key={day.date} className="flex items-center justify-between">
                      <span className="text-sm">{day.date}</span>
                      <div className="flex items-center gap-2">
                        <div className="w-20 bg-gray-200 rounded-full h-2">
                          <div 
                            className="bg-blue-500 h-2 rounded-full"
                            style={{ width: `${day.completion}%` }}
                          />
                        </div>
                        <span className="text-sm font-medium">{day.completion}%</span>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.engagementMetrics.totalQuizzes}</div>
                <div className="text-sm text-muted-foreground">Total Quizzes</div>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.engagementMetrics.avgQuizScore}%</div>
                <div className="text-sm text-muted-foreground">Avg Quiz Score</div>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.engagementMetrics.achievementsUnlocked}</div>
                <div className="text-sm text-muted-foreground">Achievements Unlocked</div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="community" className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.communityMetrics.totalChallenges}</div>
                <div className="text-sm text-muted-foreground">Active Challenges</div>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.communityMetrics.challengeParticipation}</div>
                <div className="text-sm text-muted-foreground">Challenge Participants</div>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.communityMetrics.leaderboardActivity}</div>
                <div className="text-sm text-muted-foreground">Leaderboard Views</div>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-6 text-center">
                <div className="text-2xl font-bold">{analyticsData.communityMetrics.socialShares}</div>
                <div className="text-sm text-muted-foreground">Social Shares</div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}