import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Badge } from './ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';
import { 
  Trophy, 
  Users, 
  Target, 
  Flame, 
  Star, 
  TrendingUp, 
  Calendar,
  Award,
  Crown,
  Medal
} from 'lucide-react';
import { authService } from '../services/authService';
import { toast } from 'sonner@2.0.3';

interface LeaderboardEntry {
  rank: number;
  name: string;
  xp: number;
  level: number;
  streak: number;
  achievements: number;
}

interface Challenge {
  id: string;
  title: string;
  description: string;
  type: string;
  target: number;
  reward: number;
  participants: number;
  endsAt: string;
}

export function CommunitySection() {
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
  const [challenges, setChallenges] = useState<Challenge[]>([]);
  const [loading, setLoading] = useState(true);
  const [leaderboardType, setLeaderboardType] = useState<'xp' | 'streak' | 'level'>('xp');
  const [joinedChallenges, setJoinedChallenges] = useState<Set<string>>(new Set());

  useEffect(() => {
    loadData();
  }, []);

  useEffect(() => {
    loadLeaderboard();
  }, [leaderboardType]);

  const loadData = async () => {
    try {
      const [leaderboardData, challengesData] = await Promise.all([
        authService.getLeaderboard(leaderboardType),
        authService.getChallenges()
      ]);

      setLeaderboard(leaderboardData);
      setChallenges(challengesData);
    } catch (error) {
      console.error('Failed to load community data:', error);
      toast.error('Failed to load community data');
    } finally {
      setLoading(false);
    }
  };

  const loadLeaderboard = async () => {
    try {
      const data = await authService.getLeaderboard(leaderboardType);
      setLeaderboard(data);
    } catch (error) {
      console.error('Failed to load leaderboard:', error);
    }
  };

  const joinChallenge = async (challengeId: string) => {
    try {
      await authService.joinChallenge(challengeId);
      setJoinedChallenges(prev => new Set([...prev, challengeId]));
      
      // Update participant count
      setChallenges(prev => prev.map(challenge => 
        challenge.id === challengeId 
          ? { ...challenge, participants: challenge.participants + 1 }
          : challenge
      ));
      
      toast.success('Successfully joined challenge! 🎯');
    } catch (error) {
      console.error('Failed to join challenge:', error);
      toast.error('Failed to join challenge');
    }
  };

  const getRankIcon = (rank: number) => {
    switch (rank) {
      case 1: return <Crown className="h-5 w-5 text-yellow-500" />;
      case 2: return <Medal className="h-5 w-5 text-gray-400" />;
      case 3: return <Medal className="h-5 w-5 text-amber-600" />;
      default: return <span className="text-sm font-medium">#{rank}</span>;
    }
  };

  const getTimeRemaining = (endsAt: string) => {
    const now = new Date();
    const end = new Date(endsAt);
    const diff = end.getTime() - now.getTime();
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    
    if (days > 0) return `${days}d ${hours}h`;
    if (hours > 0) return `${hours}h`;
    return 'Ending soon';
  };

  if (loading) {
    return (
      <div className="p-4 space-y-4">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded mb-4"></div>
          <div className="space-y-3">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="h-16 bg-gray-200 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="text-center space-y-2">
        <h1 className="text-2xl font-bold flex items-center justify-center gap-2">
          <Users className="h-6 w-6" />
          Community
        </h1>
        <p className="text-muted-foreground">
          Compete, learn, and grow together
        </p>
      </div>

      <Tabs defaultValue="leaderboard" className="w-full">
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="leaderboard">Leaderboard</TabsTrigger>
          <TabsTrigger value="challenges">Challenges</TabsTrigger>
        </TabsList>

        <TabsContent value="leaderboard" className="space-y-4">
          {/* Leaderboard Type Selector */}
          <div className="flex space-x-2">
            <Button
              variant={leaderboardType === 'xp' ? 'default' : 'outline'}
              size="sm"
              onClick={() => setLeaderboardType('xp')}
            >
              <Star className="h-4 w-4 mr-1" />
              XP
            </Button>
            <Button
              variant={leaderboardType === 'streak' ? 'default' : 'outline'}
              size="sm"
              onClick={() => setLeaderboardType('streak')}
            >
              <Flame className="h-4 w-4 mr-1" />
              Streak
            </Button>
            <Button
              variant={leaderboardType === 'level' ? 'default' : 'outline'}
              size="sm"
              onClick={() => setLeaderboardType('level')}
            >
              <TrendingUp className="h-4 w-4 mr-1" />
              Level
            </Button>
          </div>

          {/* Leaderboard */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Trophy className="h-5 w-5" />
                Top Performers
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              {leaderboard.length === 0 ? (
                <div className="text-center py-8 text-muted-foreground">
                  <Users className="h-12 w-12 mx-auto mb-4 opacity-50" />
                  <p>No leaderboard data yet</p>
                  <p className="text-sm">Complete some tasks to see rankings!</p>
                </div>
              ) : (
                leaderboard.map((entry) => (
                  <div
                    key={entry.rank}
                    className={`flex items-center justify-between p-3 rounded-lg ${
                      entry.rank <= 3 ? 'bg-accent' : 'bg-muted/50'
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      {getRankIcon(entry.rank)}
                      <div>
                        <div className="font-medium">{entry.name}</div>
                        <div className="text-sm text-muted-foreground">
                          Level {entry.level} • {entry.achievements} achievements
                        </div>
                      </div>
                    </div>
                    <div className="text-right">
                      <div className="font-medium">
                        {leaderboardType === 'xp' && `${entry.xp} XP`}
                        {leaderboardType === 'streak' && `${entry.streak} days`}
                        {leaderboardType === 'level' && `Level ${entry.level}`}
                      </div>
                      {leaderboardType === 'streak' && (
                        <div className="text-sm text-muted-foreground">
                          {entry.xp} XP
                        </div>
                      )}
                    </div>
                  </div>
                ))
              )}
            </CardContent>
          </Card>

          {/* User's Rank */}
          <Card>
            <CardContent className="pt-6">
              <div className="text-center space-y-2">
                <div className="text-sm text-muted-foreground">Your Rank</div>
                <div className="text-2xl font-bold">#--</div>
                <div className="text-sm text-muted-foreground">
                  Complete more tasks to climb the leaderboard!
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="challenges" className="space-y-4">
          {/* Active Challenges */}
          <div className="space-y-4">
            {challenges.length === 0 ? (
              <Card>
                <CardContent className="pt-6">
                  <div className="text-center py-8 text-muted-foreground">
                    <Target className="h-12 w-12 mx-auto mb-4 opacity-50" />
                    <p>No active challenges</p>
                    <p className="text-sm">New challenges coming soon!</p>
                  </div>
                </CardContent>
              </Card>
            ) : (
              challenges.map((challenge) => (
                <Card key={challenge.id} className="relative overflow-hidden">
                  <CardHeader className="pb-3">
                    <div className="flex items-start justify-between">
                      <div className="space-y-1">
                        <CardTitle className="text-lg">{challenge.title}</CardTitle>
                        <p className="text-sm text-muted-foreground">
                          {challenge.description}
                        </p>
                      </div>
                      <Badge variant="outline" className="ml-2">
                        {challenge.type}
                      </Badge>
                    </div>
                  </CardHeader>
                  
                  <CardContent className="space-y-4">
                    <div className="flex items-center justify-between text-sm">
                      <div className="flex items-center gap-4">
                        <div className="flex items-center gap-1">
                          <Users className="h-4 w-4" />
                          <span>{challenge.participants} joined</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <Calendar className="h-4 w-4" />
                          <span>{getTimeRemaining(challenge.endsAt)}</span>
                        </div>
                      </div>
                      <div className="flex items-center gap-1">
                        <Award className="h-4 w-4 text-yellow-500" />
                        <span className="font-medium">+{challenge.reward} XP</span>
                      </div>
                    </div>

                    <div className="flex items-center justify-between">
                      <div className="text-sm text-muted-foreground">
                        Target: {challenge.target} {challenge.type === 'streak' ? 'days' : 
                                 challenge.type === 'quiz' ? 'quizzes' : 'lessons'}
                      </div>
                      <Button
                        onClick={() => joinChallenge(challenge.id)}
                        disabled={joinedChallenges.has(challenge.id)}
                        size="sm"
                      >
                        {joinedChallenges.has(challenge.id) ? 'Joined ✓' : 'Join Challenge'}
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              ))
            )}
          </div>

          {/* Challenge Tips */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">💡 Challenge Tips</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-2 text-sm">
                <div>• Join challenges that match your current level</div>
                <div>• Consistent daily activity helps with streak challenges</div>
                <div>• Complete tasks early to avoid last-minute pressure</div>
                <div>• Check progress regularly to stay motivated</div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}