import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Input } from './ui/input';
import { Textarea } from './ui/textarea';
import { Badge } from './ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from './ui/select';
import { 
  BookOpen, 
  Video, 
  FileText, 
  Plus, 
  Edit, 
  Trash2, 
  Save,
  Eye,
  Clock,
  Target,
  Heart,
  DollarSign
} from 'lucide-react';
import { authService } from '../services/authService';
import { toast } from 'sonner@2.0.3';

interface ContentItem {
  id: string;
  title: string;
  description: string;
  content: string;
  type: 'lesson' | 'article' | 'video';
  category: 'health' | 'wealth';
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  duration: number; // in minutes
  tags: string[];
  author: string;
  createdAt: string;
  updatedAt: string;
  isPublished: boolean;
  views: number;
  likes: number;
  xpReward: number;
}

interface ContentManagementProps {
  userProfile: any;
  onContentSelect?: (content: ContentItem) => void;
}

export function ContentManagement({ userProfile, onContentSelect }: ContentManagementProps) {
  const [content, setContent] = useState<ContentItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [editingContent, setEditingContent] = useState<ContentItem | null>(null);
  const [isCreating, setIsCreating] = useState(false);
  const [filter, setFilter] = useState({
    category: 'all',
    type: 'all',
    difficulty: 'all'
  });

  // Sample content data
  const sampleContent: ContentItem[] = [
    {
      id: '1',
      title: 'Understanding Nutrition Basics',
      description: 'Learn the fundamentals of macro and micronutrients for better health.',
      content: `# Understanding Nutrition Basics

## Introduction
Nutrition is the foundation of good health. Understanding what your body needs can help you make better food choices.

## Macronutrients
- **Carbohydrates**: Your body's main energy source
- **Proteins**: Essential for muscle building and repair
- **Fats**: Important for hormone production and nutrient absorption

## Micronutrients
- **Vitamins**: Support various bodily functions
- **Minerals**: Essential for bone health, blood production, and more

## Practical Tips
1. Aim for a balanced plate: 50% vegetables, 25% protein, 25% complex carbs
2. Stay hydrated with 8-10 glasses of water daily
3. Limit processed foods and added sugars
4. Include a variety of colorful fruits and vegetables

## Conclusion
Good nutrition doesn't have to be complicated. Start with small changes and build healthy habits over time.`,
      type: 'lesson',
      category: 'health',
      difficulty: 'beginner',
      duration: 8,
      tags: ['nutrition', 'basics', 'healthy-eating'],
      author: 'Dr. Priya Sharma',
      createdAt: '2024-01-15T10:00:00Z',
      updatedAt: '2024-01-15T10:00:00Z',
      isPublished: true,
      views: 1250,
      likes: 89,
      xpReward: 25
    },
    {
      id: '2',
      title: 'Building Your First Budget',
      description: 'A step-by-step guide to creating a budget that works for Indian millennials.',
      content: `# Building Your First Budget

## Why Budget?
Budgeting helps you understand where your money goes and ensures you can meet your financial goals.

## The 50-30-20 Rule
This simple rule can help you get started:
- **50%** for needs (rent, groceries, utilities)
- **30%** for wants (entertainment, dining out)
- **20%** for savings and debt repayment

## Steps to Create Your Budget

### 1. Calculate Your Income
Include your salary, freelance income, and any other regular income sources.

### 2. Track Your Expenses
For one month, track everything you spend. Use apps like:
- YNAB (You Need A Budget)
- Mint
- ET Money
- Paisa Vasool

### 3. Categorize Expenses
- **Fixed expenses**: Rent, EMIs, insurance
- **Variable expenses**: Groceries, transportation
- **Discretionary expenses**: Entertainment, shopping

### 4. Set Financial Goals
- Emergency fund (3-6 months expenses)
- Short-term goals (vacation, gadgets)
- Long-term goals (house, retirement)

## Indian Context Tips
- Factor in festival expenses
- Consider family financial responsibilities
- Plan for monsoon-related expenses
- Account for inflation in food prices

## Common Mistakes to Avoid
1. Setting unrealistic budgets
2. Not tracking small expenses
3. Ignoring irregular expenses
4. Not adjusting the budget regularly

## Conclusion
Start simple and adjust as you learn. The perfect budget is one you'll actually follow.`,
      type: 'lesson',
      category: 'wealth',
      difficulty: 'beginner',
      duration: 12,
      tags: ['budgeting', 'money-management', 'savings'],
      author: 'Rohit Kumar, CFP',
      createdAt: '2024-01-20T14:30:00Z',
      updatedAt: '2024-01-20T14:30:00Z',
      isPublished: true,
      views: 2100,
      likes: 156,
      xpReward: 30
    },
    {
      id: '3',
      title: 'Mental Health in the Workplace',
      description: 'Managing stress and maintaining mental wellness in professional environments.',
      content: `# Mental Health in the Workplace

## Introduction
Modern work environments can be stressful. Learning to manage your mental health at work is crucial for long-term success and happiness.

## Common Workplace Stressors
- Heavy workloads and tight deadlines
- Difficult colleagues or managers
- Lack of work-life balance
- Job insecurity
- Office politics

## Stress Management Techniques

### 1. Time Management
- Use the Pomodoro Technique (25-minute work blocks)
- Prioritize tasks using the Eisenhower Matrix
- Learn to say "no" to non-essential requests

### 2. Mindfulness at Work
- Take 5-minute breathing breaks
- Practice desk yoga or stretching
- Use mindfulness apps during lunch breaks

### 3. Building Support Networks
- Connect with supportive colleagues
- Find a mentor or career guide
- Join professional networks or communities

## Creating Boundaries
- Set specific work hours and stick to them
- Avoid checking emails after work hours
- Take regular breaks throughout the day
- Use vacation time to truly disconnect

## When to Seek Help
If you experience:
- Persistent anxiety or depression
- Sleep problems related to work stress
- Physical symptoms (headaches, stomach issues)
- Thoughts of self-harm

Don't hesitate to reach out to:
- Employee assistance programs
- Mental health professionals
- Trusted friends or family members

## Building a Mentally Healthy Workplace
- Advocate for mental health initiatives
- Be supportive of colleagues
- Promote open conversations about mental health
- Suggest wellness programs to HR

## Conclusion
Your mental health is just as important as your physical health. Invest in it, protect it, and don't be afraid to ask for help when you need it.`,
      type: 'article',
      category: 'health',
      difficulty: 'intermediate',
      duration: 15,
      tags: ['mental-health', 'workplace', 'stress-management'],
      author: 'Dr. Anisha Patel',
      createdAt: '2024-01-25T09:15:00Z',
      updatedAt: '2024-01-25T09:15:00Z',
      isPublished: true,
      views: 890,
      likes: 67,
      xpReward: 35
    }
  ];

  useEffect(() => {
    loadContent();
  }, []);

  const loadContent = async () => {
    try {
      // In a real app, this would fetch from the server
      setContent(sampleContent);
    } catch (error) {
      console.error('Failed to load content:', error);
      toast.error('Failed to load content');
    } finally {
      setLoading(false);
    }
  };

  const filteredContent = content.filter(item => {
    if (filter.category !== 'all' && item.category !== filter.category) return false;
    if (filter.type !== 'all' && item.type !== filter.type) return false;
    if (filter.difficulty !== 'all' && item.difficulty !== filter.difficulty) return false;
    return true;
  });

  const handleCreateContent = () => {
    const newContent: ContentItem = {
      id: Date.now().toString(),
      title: '',
      description: '',
      content: '',
      type: 'lesson',
      category: 'health',
      difficulty: 'beginner',
      duration: 5,
      tags: [],
      author: userProfile?.name || 'Unknown',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      isPublished: false,
      views: 0,
      likes: 0,
      xpReward: 25
    };
    setEditingContent(newContent);
    setIsCreating(true);
  };

  const handleSaveContent = async () => {
    if (!editingContent) return;

    try {
      if (isCreating) {
        setContent(prev => [...prev, editingContent]);
        toast.success('Content created successfully!');
      } else {
        setContent(prev => prev.map(item => 
          item.id === editingContent.id ? editingContent : item
        ));
        toast.success('Content updated successfully!');
      }
      
      setEditingContent(null);
      setIsCreating(false);
    } catch (error) {
      console.error('Failed to save content:', error);
      toast.error('Failed to save content');
    }
  };

  const handleDeleteContent = async (id: string) => {
    try {
      setContent(prev => prev.filter(item => item.id !== id));
      toast.success('Content deleted successfully!');
    } catch (error) {
      console.error('Failed to delete content:', error);
      toast.error('Failed to delete content');
    }
  };

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'lesson': return <BookOpen className="h-4 w-4" />;
      case 'article': return <FileText className="h-4 w-4" />;
      case 'video': return <Video className="h-4 w-4" />;
      default: return <BookOpen className="h-4 w-4" />;
    }
  };

  const getCategoryIcon = (category: string) => {
    return category === 'health' 
      ? <Heart className="h-4 w-4 text-red-500" />
      : <DollarSign className="h-4 w-4 text-green-500" />;
  };

  if (loading) {
    return (
      <div className="p-4">
        <div className="animate-pulse space-y-4">
          {[...Array(3)].map((_, i) => (
            <div key={i} className="h-32 bg-gray-200 rounded"></div>
          ))}
        </div>
      </div>
    );
  }

  if (editingContent) {
    return (
      <div className="p-4 space-y-6">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-bold">
            {isCreating ? 'Create Content' : 'Edit Content'}
          </h2>
          <div className="flex gap-2">
            <Button
              variant="outline"
              onClick={() => {
                setEditingContent(null);
                setIsCreating(false);
              }}
            >
              Cancel
            </Button>
            <Button onClick={handleSaveContent}>
              <Save className="h-4 w-4 mr-2" />
              Save
            </Button>
          </div>
        </div>

        <Card>
          <CardContent className="pt-6 space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <label className="text-sm font-medium">Title</label>
                <Input
                  value={editingContent.title}
                  onChange={(e) => setEditingContent({
                    ...editingContent,
                    title: e.target.value
                  })}
                  placeholder="Enter content title"
                />
              </div>

              <div className="space-y-2">
                <label className="text-sm font-medium">Duration (minutes)</label>
                <Input
                  type="number"
                  value={editingContent.duration}
                  onChange={(e) => setEditingContent({
                    ...editingContent,
                    duration: parseInt(e.target.value) || 0
                  })}
                />
              </div>

              <div className="space-y-2">
                <label className="text-sm font-medium">Type</label>
                <Select
                  value={editingContent.type}
                  onValueChange={(value: any) => setEditingContent({
                    ...editingContent,
                    type: value
                  })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="lesson">Lesson</SelectItem>
                    <SelectItem value="article">Article</SelectItem>
                    <SelectItem value="video">Video</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <label className="text-sm font-medium">Category</label>
                <Select
                  value={editingContent.category}
                  onValueChange={(value: any) => setEditingContent({
                    ...editingContent,
                    category: value
                  })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="health">Health</SelectItem>
                    <SelectItem value="wealth">Wealth</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <label className="text-sm font-medium">Difficulty</label>
                <Select
                  value={editingContent.difficulty}
                  onValueChange={(value: any) => setEditingContent({
                    ...editingContent,
                    difficulty: value
                  })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="beginner">Beginner</SelectItem>
                    <SelectItem value="intermediate">Intermediate</SelectItem>
                    <SelectItem value="advanced">Advanced</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <label className="text-sm font-medium">XP Reward</label>
                <Input
                  type="number"
                  value={editingContent.xpReward}
                  onChange={(e) => setEditingContent({
                    ...editingContent,
                    xpReward: parseInt(e.target.value) || 0
                  })}
                />
              </div>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-medium">Description</label>
              <Textarea
                value={editingContent.description}
                onChange={(e) => setEditingContent({
                  ...editingContent,
                  description: e.target.value
                })}
                placeholder="Brief description of the content"
                rows={3}
              />
            </div>

            <div className="space-y-2">
              <label className="text-sm font-medium">Content (Markdown supported)</label>
              <Textarea
                value={editingContent.content}
                onChange={(e) => setEditingContent({
                  ...editingContent,
                  content: e.target.value
                })}
                placeholder="Write your content here using Markdown syntax..."
                rows={15}
                className="font-mono text-sm"
              />
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Content Library</h1>
        <Button onClick={handleCreateContent}>
          <Plus className="h-4 w-4 mr-2" />
          Create Content
        </Button>
      </div>

      {/* Filters */}
      <Card>
        <CardContent className="pt-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="space-y-2">
              <label className="text-sm font-medium">Category</label>
              <Select
                value={filter.category}
                onValueChange={(value) => setFilter({ ...filter, category: value })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Categories</SelectItem>
                  <SelectItem value="health">Health</SelectItem>
                  <SelectItem value="wealth">Wealth</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-medium">Type</label>
              <Select
                value={filter.type}
                onValueChange={(value) => setFilter({ ...filter, type: value })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Types</SelectItem>
                  <SelectItem value="lesson">Lessons</SelectItem>
                  <SelectItem value="article">Articles</SelectItem>
                  <SelectItem value="video">Videos</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-medium">Difficulty</label>
              <Select
                value={filter.difficulty}
                onValueChange={(value) => setFilter({ ...filter, difficulty: value })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Levels</SelectItem>
                  <SelectItem value="beginner">Beginner</SelectItem>
                  <SelectItem value="intermediate">Intermediate</SelectItem>
                  <SelectItem value="advanced">Advanced</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Content List */}
      <div className="space-y-4">
        {filteredContent.length === 0 ? (
          <Card>
            <CardContent className="pt-6 text-center py-12">
              <BookOpen className="h-12 w-12 mx-auto mb-4 text-muted-foreground" />
              <h3 className="text-lg font-medium mb-2">No content found</h3>
              <p className="text-muted-foreground mb-4">
                Try adjusting your filters or create new content.
              </p>
              <Button onClick={handleCreateContent}>
                <Plus className="h-4 w-4 mr-2" />
                Create First Content
              </Button>
            </CardContent>
          </Card>
        ) : (
          filteredContent.map((item) => (
            <Card key={item.id} className="hover:shadow-md transition-shadow">
              <CardContent className="pt-6">
                <div className="flex items-start justify-between">
                  <div className="flex-1 space-y-3">
                    <div className="flex items-center gap-3">
                      <div className="flex items-center gap-2">
                        {getTypeIcon(item.type)}
                        <h3 className="font-medium text-lg">{item.title}</h3>
                      </div>
                      <div className="flex items-center gap-2">
                        {getCategoryIcon(item.category)}
                        <Badge variant="outline" className="text-xs">
                          {item.difficulty}
                        </Badge>
                        {item.isPublished ? (
                          <Badge className="text-xs">Published</Badge>
                        ) : (
                          <Badge variant="secondary" className="text-xs">Draft</Badge>
                        )}
                      </div>
                    </div>

                    <p className="text-muted-foreground text-sm">
                      {item.description}
                    </p>

                    <div className="flex items-center gap-6 text-sm text-muted-foreground">
                      <div className="flex items-center gap-1">
                        <Clock className="h-4 w-4" />
                        {item.duration} min
                      </div>
                      <div className="flex items-center gap-1">
                        <Eye className="h-4 w-4" />
                        {item.views} views
                      </div>
                      <div className="flex items-center gap-1">
                        <Target className="h-4 w-4" />
                        +{item.xpReward} XP
                      </div>
                    </div>

                    <div className="flex items-center gap-2">
                      {item.tags.map((tag) => (
                        <Badge key={tag} variant="outline" className="text-xs">
                          {tag}
                        </Badge>
                      ))}
                    </div>
                  </div>

                  <div className="flex items-center gap-2 ml-4">
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => onContentSelect?.(item)}
                    >
                      <Eye className="h-4 w-4" />
                    </Button>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => setEditingContent(item)}
                    >
                      <Edit className="h-4 w-4" />
                    </Button>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => handleDeleteContent(item.id)}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))
        )}
      </div>
    </div>
  );
}