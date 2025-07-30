import { Hono } from 'npm:hono'
import { cors } from 'npm:hono/cors'
import { logger } from 'npm:hono/logger'
import { createClient } from 'npm:@supabase/supabase-js'
import * as kv from './kv_store.tsx'

const app = new Hono()

// Middleware
app.use('*', cors({
  origin: '*',
  allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowHeaders: ['Content-Type', 'Authorization'],
}))

app.use('*', logger(console.log))

// Initialize Supabase client
const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

// Helper function to get user from access token
async function getUserFromToken(accessToken: string) {
  const { data: { user }, error } = await supabase.auth.getUser(accessToken)
  if (error || !user) {
    throw new Error('Unauthorized')
  }
  return user
}

// Auth Routes
app.post('/make-server-b724bdf3/auth/signup', async (c) => {
  try {
    const { email, password, name } = await c.req.json()
    
    const { data, error } = await supabase.auth.admin.createUser({
      email,
      password,
      user_metadata: { name },
      // Automatically confirm the user's email since an email server hasn't been configured.
      email_confirm: true
    })
    
    if (error) {
      console.error('Signup error:', error)
      return c.json({ error: error.message }, 400)
    }
    
    // Initialize user profile in KV store
    const userProfile = {
      id: data.user.id,
      name,
      email,
      xp: 0,
      level: 1,
      streak: 0,
      joinedDate: new Date().toISOString(),
      healthGoal: null,
      wealthGoal: null,
      currentLevel: 'beginner',
      totalLessonsCompleted: 0,
      totalQuizzesTaken: 0,
      achievements: [],
      lastActiveDate: new Date().toISOString()
    }
    
    await kv.set(`user:${data.user.id}`, userProfile)
    
    return c.json({ user: data.user, profile: userProfile })
  } catch (error) {
    console.error('Signup error:', error)
    return c.json({ error: 'Internal server error during signup' }, 500)
  }
})

// User Profile Routes
app.get('/make-server-b724bdf3/profile', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const profile = await kv.get(`user:${user.id}`)
    
    if (!profile) {
      return c.json({ error: 'Profile not found' }, 404)
    }
    
    return c.json(profile)
  } catch (error) {
    console.error('Profile fetch error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

app.put('/make-server-b724bdf3/profile', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const updates = await c.req.json()
    
    const currentProfile = await kv.get(`user:${user.id}`)
    if (!currentProfile) {
      return c.json({ error: 'Profile not found' }, 404)
    }
    
    const updatedProfile = {
      ...currentProfile,
      ...updates,
      lastActiveDate: new Date().toISOString()
    }
    
    await kv.set(`user:${user.id}`, updatedProfile)
    
    return c.json(updatedProfile)
  } catch (error) {
    console.error('Profile update error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

// Daily Tasks Routes
app.get('/make-server-b724bdf3/daily-tasks', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const today = new Date().toDateString()
    
    const tasks = await kv.get(`tasks:${user.id}:${today}`)
    
    if (!tasks) {
      // Generate daily tasks for the user
      const profile = await kv.get(`user:${user.id}`)
      const newTasks = generateDailyTasks(profile)
      await kv.set(`tasks:${user.id}:${today}`, newTasks)
      return c.json(newTasks)
    }
    
    return c.json(tasks)
  } catch (error) {
    console.error('Daily tasks fetch error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

app.post('/make-server-b724bdf3/complete-task', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const { taskId } = await c.req.json()
    const today = new Date().toDateString()
    
    const tasks = await kv.get(`tasks:${user.id}:${today}`)
    if (!tasks) {
      return c.json({ error: 'Tasks not found' }, 404)
    }
    
    const updatedTasks = tasks.map((task: any) => {
      if (task.id === taskId && !task.completed) {
        return { ...task, completed: true, completedAt: new Date().toISOString() }
      }
      return task
    })
    
    await kv.set(`tasks:${user.id}:${today}`, updatedTasks)
    
    // Update user XP and streak
    const completedTask = updatedTasks.find((task: any) => task.id === taskId)
    if (completedTask) {
      const profile = await kv.get(`user:${user.id}`)
      const newXP = profile.xp + completedTask.xpReward
      const newLevel = Math.floor(newXP / 500) + 1
      
      // Update streak logic
      const lastActive = new Date(profile.lastActiveDate)
      const now = new Date()
      const daysDiff = Math.floor((now.getTime() - lastActive.getTime()) / (1000 * 60 * 60 * 24))
      
      let newStreak = profile.streak
      if (daysDiff === 0) {
        // Same day, maintain streak
      } else if (daysDiff === 1) {
        // Next day, increment streak
        newStreak = profile.streak + 1
      } else {
        // Missed days, reset streak
        newStreak = 1
      }
      
      const updatedProfile = {
        ...profile,
        xp: newXP,
        level: newLevel,
        streak: newStreak,
        lastActiveDate: new Date().toISOString()
      }
      
      await kv.set(`user:${user.id}`, updatedProfile)
      
      return c.json({ 
        task: completedTask, 
        profile: updatedProfile,
        levelUp: newLevel > profile.level
      })
    }
    
    return c.json({ task: completedTask })
  } catch (error) {
    console.error('Complete task error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

// Quiz Routes
app.post('/make-server-b724bdf3/quiz/submit', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const quizSession = await c.req.json()
    
    // Store quiz session
    const quizId = `quiz:${user.id}:${Date.now()}`
    await kv.set(quizId, {
      ...quizSession,
      userId: user.id,
      submittedAt: new Date().toISOString()
    })
    
    // Update user profile with quiz completion
    const profile = await kv.get(`user:${user.id}`)
    const xpEarned = quizSession.score * 25
    const newXP = profile.xp + xpEarned
    const newLevel = Math.floor(newXP / 500) + 1
    
    const updatedProfile = {
      ...profile,
      xp: newXP,
      level: newLevel,
      totalQuizzesTaken: (profile.totalQuizzesTaken || 0) + 1,
      lastActiveDate: new Date().toISOString()
    }
    
    await kv.set(`user:${user.id}`, updatedProfile)
    
    return c.json({ 
      quizId, 
      xpEarned, 
      profile: updatedProfile,
      levelUp: newLevel > profile.level
    })
  } catch (error) {
    console.error('Quiz submit error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

app.get('/make-server-b724bdf3/quiz/history', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const quizHistory = await kv.getByPrefix(`quiz:${user.id}:`)
    
    return c.json(quizHistory || [])
  } catch (error) {
    console.error('Quiz history error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

// Leaderboard Routes
app.get('/make-server-b724bdf3/leaderboard', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    await getUserFromToken(accessToken) // Validate token
    
    const type = c.req.query('type') || 'xp' // xp, streak, level
    const limit = parseInt(c.req.query('limit') || '10')
    
    // Get all user profiles
    const allProfiles = await kv.getByPrefix('user:')
    
    // Sort by the requested type
    const sortedProfiles = allProfiles.sort((a: any, b: any) => {
      if (type === 'xp') return b.xp - a.xp
      if (type === 'streak') return b.streak - a.streak
      if (type === 'level') return b.level - a.level
      return 0
    })
    
    // Return top profiles with limited data
    const leaderboard = sortedProfiles.slice(0, limit).map((profile: any, index: number) => ({
      rank: index + 1,
      name: profile.name,
      xp: profile.xp,
      level: profile.level,
      streak: profile.streak,
      achievements: profile.achievements?.length || 0
    }))
    
    return c.json(leaderboard)
  } catch (error) {
    console.error('Leaderboard error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

// Challenges Routes
app.get('/make-server-b724bdf3/challenges', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    await getUserFromToken(accessToken)
    
    // Get or create weekly challenges
    const weekKey = getWeekKey()
    let challenges = await kv.get(`challenges:${weekKey}`)
    
    if (!challenges) {
      challenges = generateWeeklyChallenges()
      await kv.set(`challenges:${weekKey}`, challenges)
    }
    
    return c.json(challenges)
  } catch (error) {
    console.error('Challenges error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

app.post('/make-server-b724bdf3/challenges/join', async (c) => {
  try {
    const accessToken = c.req.header('Authorization')?.split(' ')[1]
    if (!accessToken) {
      return c.json({ error: 'No access token provided' }, 401)
    }
    
    const user = await getUserFromToken(accessToken)
    const { challengeId } = await c.req.json()
    
    // Add user to challenge participants
    const weekKey = getWeekKey()
    const participantKey = `challenge:${challengeId}:${weekKey}:participants`
    
    let participants = await kv.get(participantKey) || []
    
    if (!participants.some((p: any) => p.userId === user.id)) {
      participants.push({
        userId: user.id,
        joinedAt: new Date().toISOString(),
        progress: 0
      })
      await kv.set(participantKey, participants)
    }
    
    return c.json({ success: true, participants: participants.length })
  } catch (error) {
    console.error('Challenge join error:', error)
    return c.json({ error: 'Unauthorized' }, 401)
  }
})

// Helper functions
function generateDailyTasks(profile: any) {
  const today = new Date().toDateString()
  const tasks = [
    {
      id: '1',
      title: 'Complete a health lesson',
      type: 'health',
      completed: false,
      xpReward: 25,
      date: today
    },
    {
      id: '2',
      title: 'Take a wealth quiz',
      type: 'wealth',
      completed: false,
      xpReward: 30,
      date: today
    },
    {
      id: '3',
      title: 'Track your daily expenses',
      type: 'wealth',
      completed: false,
      xpReward: 20,
      date: today
    },
    {
      id: '4',
      title: 'Log your water intake',
      type: 'health',
      completed: false,
      xpReward: 15,
      date: today
    }
  ]
  
  // Add personalized tasks based on user level
  if (profile.level >= 5) {
    tasks.push({
      id: '5',
      title: 'Review your investment portfolio',
      type: 'wealth',
      completed: false,
      xpReward: 35,
      date: today
    })
  }
  
  return tasks
}

function generateWeeklyChallenges() {
  return [
    {
      id: 'streak-7',
      title: '7-Day Streak Challenge',
      description: 'Complete daily tasks for 7 consecutive days',
      type: 'streak',
      target: 7,
      reward: 200,
      participants: 0,
      endsAt: getWeekEnd()
    },
    {
      id: 'quiz-master',
      title: 'Quiz Master',
      description: 'Complete 10 quizzes this week',
      type: 'quiz',
      target: 10,
      reward: 150,
      participants: 0,
      endsAt: getWeekEnd()
    },
    {
      id: 'health-focus',
      title: 'Health Focus Week',
      description: 'Complete 5 health-related lessons',
      type: 'lessons',
      target: 5,
      reward: 100,
      participants: 0,
      endsAt: getWeekEnd()
    }
  ]
}

function getWeekKey() {
  const now = new Date()
  const startOfWeek = new Date(now.setDate(now.getDate() - now.getDay()))
  return startOfWeek.toISOString().split('T')[0]
}

function getWeekEnd() {
  const now = new Date()
  const endOfWeek = new Date(now.setDate(now.getDate() - now.getDay() + 6))
  return endOfWeek.toISOString()
}

// Health check
app.get('/make-server-b724bdf3/health', (c) => {
  return c.json({ status: 'healthy', timestamp: new Date().toISOString() })
})

Deno.serve(app.fetch)