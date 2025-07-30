import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Progress } from './ui/progress';
import { Badge } from './ui/badge';
import { CheckCircle, XCircle, Brain, Trophy, Clock } from 'lucide-react';

interface QuizQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer: number;
  explanation: string;
  category: 'health' | 'wealth';
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  topic: string;
}

interface QuizResult {
  questionId: string;
  selectedAnswer: number;
  isCorrect: boolean;
  timeSpent: number;
}

interface QuizSession {
  id: string;
  questions: QuizQuestion[];
  results: QuizResult[];
  startTime: Date;
  endTime?: Date;
  score: number;
  category: 'health' | 'wealth';
}

interface QuizSystemProps {
  category: 'health' | 'wealth';
  userLevel: 'beginner' | 'intermediate' | 'advanced';
  onComplete: (session: QuizSession) => void;
  onXPEarned: (xp: number) => void;
}

export function QuizSystem({ category, userLevel, onComplete, onXPEarned }: QuizSystemProps) {
  const [currentQuiz, setCurrentQuiz] = useState<QuizSession | null>(null);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [showExplanation, setShowExplanation] = useState(false);
  const [timeSpent, setTimeSpent] = useState(0);
  const [questionStartTime, setQuestionStartTime] = useState<Date>(new Date());

  // Sample quiz questions
  const quizQuestions: QuizQuestion[] = [
    // Health Questions
    {
      id: 'h1',
      question: 'How many glasses of water should you drink daily?',
      options: ['4-5 glasses', '6-8 glasses', '10-12 glasses', '15+ glasses'],
      correctAnswer: 1,
      explanation: '6-8 glasses (about 2-3 liters) is the recommended daily water intake for most adults.',
      category: 'health',
      difficulty: 'beginner',
      topic: 'nutrition'
    },
    {
      id: 'h2',
      question: 'What percentage of your plate should be vegetables for a balanced meal?',
      options: ['25%', '33%', '50%', '75%'],
      correctAnswer: 2,
      explanation: 'Half your plate should be filled with vegetables and fruits for optimal nutrition.',
      category: 'health',
      difficulty: 'beginner',
      topic: 'nutrition'
    },
    {
      id: 'h3',
      question: 'How many hours of sleep do adults need for optimal health?',
      options: ['5-6 hours', '7-8 hours', '9-10 hours', '11+ hours'],
      correctAnswer: 1,
      explanation: '7-8 hours of sleep is recommended for most adults to maintain good health.',
      category: 'health',
      difficulty: 'beginner',
      topic: 'sleep'
    },
    {
      id: 'h4',
      question: 'What is the recommended amount of moderate exercise per week?',
      options: ['75 minutes', '150 minutes', '300 minutes', '450 minutes'],
      correctAnswer: 1,
      explanation: '150 minutes (2.5 hours) of moderate exercise per week is recommended by health authorities.',
      category: 'health',
      difficulty: 'intermediate',
      topic: 'fitness'
    },
    {
      id: 'h5',
      question: 'Which practice is most effective for managing stress?',
      options: ['Avoiding stress', 'Deep breathing', 'Working more', 'Sleeping extra'],
      correctAnswer: 1,
      explanation: 'Deep breathing and mindfulness practices are scientifically proven to reduce stress effectively.',
      category: 'health',
      difficulty: 'intermediate',
      topic: 'mental-health'
    },

    // Wealth Questions
    {
      id: 'w1',
      question: 'What is the 50-30-20 rule in budgeting?',
      options: [
        '50% savings, 30% needs, 20% wants',
        '50% needs, 30% wants, 20% savings',
        '50% wants, 30% savings, 20% needs',
        '50% investments, 30% savings, 20% expenses'
      ],
      correctAnswer: 1,
      explanation: 'The 50-30-20 rule allocates 50% for needs, 30% for wants, and 20% for savings and debt repayment.',
      category: 'wealth',
      difficulty: 'beginner',
      topic: 'budgeting'
    },
    {
      id: 'w2',
      question: 'What does SIP stand in investing?',
      options: [
        'Systematic Investment Plan',
        'Simple Interest Payment',
        'Systematic Insurance Policy',
        'Systematic Income Plan'
      ],
      correctAnswer: 0,
      explanation: 'SIP (Systematic Investment Plan) allows you to invest a fixed amount regularly in mutual funds.',
      category: 'wealth',
      difficulty: 'beginner',
      topic: 'investing'
    },
    {
      id: 'w3',
      question: 'What is a good credit score range?',
      options: ['300-579', '580-669', '670-739', '740-850'],
      correctAnswer: 3,
      explanation: 'A credit score of 740-850 is considered excellent and will get you the best loan terms.',
      category: 'wealth',
      difficulty: 'intermediate',
      topic: 'credit'
    },
    {
      id: 'w4',
      question: 'How much should your emergency fund cover?',
      options: ['1 month expenses', '3-6 months expenses', '1 year expenses', '2 years expenses'],
      correctAnswer: 1,
      explanation: 'An emergency fund should cover 3-6 months of living expenses for financial security.',
      category: 'wealth',
      difficulty: 'intermediate',
      topic: 'savings'
    },
    {
      id: 'w5',
      question: 'What is compound interest?',
      options: [
        'Interest on principal only',
        'Interest on interest earned',
        'Simple interest calculation',
        'Bank charges'
      ],
      correctAnswer: 1,
      explanation: 'Compound interest is earning interest on both your principal and previously earned interest.',
      category: 'wealth',
      difficulty: 'advanced',
      topic: 'investing'
    }
  ];

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (currentQuiz && !showExplanation) {
      interval = setInterval(() => {
        setTimeSpent(prev => prev + 1);
      }, 1000);
    }
    return () => clearInterval(interval);
  }, [currentQuiz, showExplanation]);

  const startQuiz = () => {
    // Filter questions by category and difficulty
    const availableQuestions = quizQuestions.filter(q => 
      q.category === category && 
      (q.difficulty === userLevel || q.difficulty === 'beginner')
    );

    // Select 5 random questions
    const selectedQuestions = availableQuestions
      .sort(() => 0.5 - Math.random())
      .slice(0, 5);

    const newQuiz: QuizSession = {
      id: Date.now().toString(),
      questions: selectedQuestions,
      results: [],
      startTime: new Date(),
      score: 0,
      category
    };

    setCurrentQuiz(newQuiz);
    setCurrentQuestionIndex(0);
    setSelectedAnswer(null);
    setShowExplanation(false);
    setTimeSpent(0);
    setQuestionStartTime(new Date());
  };

  const submitAnswer = () => {
    if (!currentQuiz || selectedAnswer === null) return;

    const currentQuestion = currentQuiz.questions[currentQuestionIndex];
    const isCorrect = selectedAnswer === currentQuestion.correctAnswer;
    const questionTime = (new Date().getTime() - questionStartTime.getTime()) / 1000;

    const result: QuizResult = {
      questionId: currentQuestion.id,
      selectedAnswer,
      isCorrect,
      timeSpent: questionTime
    };

    const updatedQuiz = {
      ...currentQuiz,
      results: [...currentQuiz.results, result],
      score: currentQuiz.score + (isCorrect ? 1 : 0)
    };

    setCurrentQuiz(updatedQuiz);
    setShowExplanation(true);

    // Award XP for correct answers
    if (isCorrect) {
      const baseXP = 25;
      const difficultyMultiplier = currentQuestion.difficulty === 'advanced' ? 2 : 
                                  currentQuestion.difficulty === 'intermediate' ? 1.5 : 1;
      const speedBonus = questionTime < 10 ? 10 : 0;
      const xpEarned = Math.round(baseXP * difficultyMultiplier + speedBonus);
      onXPEarned(xpEarned);
    }
  };

  const nextQuestion = () => {
    if (!currentQuiz) return;

    if (currentQuestionIndex < currentQuiz.questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setSelectedAnswer(null);
      setShowExplanation(false);
      setQuestionStartTime(new Date());
    } else {
      // Quiz completed
      const completedQuiz = {
        ...currentQuiz,
        endTime: new Date()
      };
      setCurrentQuiz(null);
      onComplete(completedQuiz);
    }
  };

  if (!currentQuiz) {
    return (
      <Card className="max-w-md mx-auto">
        <CardHeader className="text-center">
          <CardTitle className="flex items-center justify-center gap-2">
            <Brain className="h-6 w-6" />
            {category === 'health' ? 'Health' : 'Wealth'} Quiz
          </CardTitle>
          <p className="text-muted-foreground">
            Test your knowledge and earn XP!
          </p>
        </CardHeader>
        <CardContent className="text-center space-y-4">
          <div className="bg-accent p-4 rounded-lg">
            <h4 className="font-medium mb-2">Quiz Details</h4>
            <ul className="text-sm text-muted-foreground space-y-1">
              <li>• 5 questions</li>
              <li>• Earn XP for correct answers</li>
              <li>• Speed bonus available</li>
              <li>• Learn from explanations</li>
            </ul>
          </div>
          <Button onClick={startQuiz} className="w-full">
            Start Quiz
          </Button>
        </CardContent>
      </Card>
    );
  }

  const currentQuestion = currentQuiz.questions[currentQuestionIndex];
  const progress = ((currentQuestionIndex + 1) / currentQuiz.questions.length) * 100;

  return (
    <Card className="max-w-md mx-auto">
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle className="text-lg">
            Question {currentQuestionIndex + 1} of {currentQuiz.questions.length}
          </CardTitle>
          <div className="flex items-center gap-2 text-sm text-muted-foreground">
            <Clock className="h-4 w-4" />
            {Math.floor(timeSpent / 60)}:{(timeSpent % 60).toString().padStart(2, '0')}
          </div>
        </div>
        <Progress value={progress} className="h-2" />
        <div className="flex gap-2">
          <Badge variant="outline" className="text-xs">
            {currentQuestion.topic}
          </Badge>
          <Badge variant="outline" className="text-xs">
            {currentQuestion.difficulty}
          </Badge>
        </div>
      </CardHeader>

      <CardContent className="space-y-6">
        <h3 className="text-lg font-medium">{currentQuestion.question}</h3>

        {!showExplanation ? (
          <div className="space-y-3">
            {currentQuestion.options.map((option, index) => (
              <button
                key={index}
                onClick={() => setSelectedAnswer(index)}
                className={`w-full p-4 text-left rounded-lg border transition-colors ${
                  selectedAnswer === index
                    ? 'border-primary bg-primary/5'
                    : 'border-border hover:bg-accent'
                }`}
              >
                <div className="flex items-center gap-3">
                  <div className={`w-6 h-6 rounded-full border-2 flex items-center justify-center ${
                    selectedAnswer === index ? 'border-primary bg-primary text-primary-foreground' : 'border-muted-foreground'
                  }`}>
                    {selectedAnswer === index && <span className="text-xs">✓</span>}
                  </div>
                  <span>{option}</span>
                </div>
              </button>
            ))}

            <Button 
              onClick={submitAnswer} 
              disabled={selectedAnswer === null}
              className="w-full"
            >
              Submit Answer
            </Button>
          </div>
        ) : (
          <div className="space-y-4">
            {/* Show correct/incorrect with explanation */}
            <div className={`p-4 rounded-lg border-l-4 ${
              currentQuiz.results[currentQuestionIndex]?.isCorrect
                ? 'border-green-500 bg-green-50'
                : 'border-red-500 bg-red-50'
            }`}>
              <div className="flex items-center gap-2 mb-2">
                {currentQuiz.results[currentQuestionIndex]?.isCorrect ? (
                  <CheckCircle className="h-5 w-5 text-green-600" />
                ) : (
                  <XCircle className="h-5 w-5 text-red-600" />
                )}
                <span className="font-medium">
                  {currentQuiz.results[currentQuestionIndex]?.isCorrect ? 'Correct!' : 'Incorrect'}
                </span>
              </div>
              <p className="text-sm">{currentQuestion.explanation}</p>
            </div>

            <div className="text-center">
              <p className="text-sm text-muted-foreground mb-3">
                Score: {currentQuiz.score}/{currentQuestionIndex + 1}
              </p>
              <Button onClick={nextQuestion} className="w-full">
                {currentQuestionIndex < currentQuiz.questions.length - 1 ? 'Next Question' : 'Complete Quiz'}
              </Button>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
}

export function QuizResults({ session }: { session: QuizSession }) {
  const accuracy = (session.score / session.questions.length) * 100;
  const totalTime = session.endTime && session.startTime 
    ? (session.endTime.getTime() - session.startTime.getTime()) / 1000 
    : 0;

  const getPerformanceMessage = (accuracy: number) => {
    if (accuracy >= 90) return "Outstanding! You're a true expert! 🌟";
    if (accuracy >= 70) return "Great job! You're doing really well! 👏";
    if (accuracy >= 50) return "Good effort! Keep learning and improving! 💪";
    return "Don't worry, practice makes perfect! 📚";
  };

  return (
    <Card className="max-w-md mx-auto">
      <CardHeader className="text-center">
        <CardTitle className="flex items-center justify-center gap-2">
          <Trophy className="h-6 w-6 text-yellow-500" />
          Quiz Complete!
        </CardTitle>
      </CardHeader>
      
      <CardContent className="space-y-6">
        <div className="text-center space-y-4">
          <div className="text-4xl font-bold">{session.score}/{session.questions.length}</div>
          <div className="text-lg font-medium">{accuracy.toFixed(0)}% Accuracy</div>
          <p className="text-muted-foreground">{getPerformanceMessage(accuracy)}</p>
        </div>

        <div className="grid grid-cols-2 gap-4 text-center">
          <div className="p-3 bg-accent rounded-lg">
            <div className="text-sm text-muted-foreground">Time Taken</div>
            <div className="font-medium">
              {Math.floor(totalTime / 60)}:{(totalTime % 60).toFixed(0).padStart(2, '0')}
            </div>
          </div>
          <div className="p-3 bg-accent rounded-lg">
            <div className="text-sm text-muted-foreground">XP Earned</div>
            <div className="font-medium">+{session.score * 25}</div>
          </div>
        </div>

        <div className="space-y-2">
          <h4 className="font-medium">Question Breakdown:</h4>
          {session.questions.map((question, index) => (
            <div key={question.id} className="flex items-center justify-between p-2 bg-accent rounded">
              <span className="text-sm">{question.topic}</span>
              {session.results[index]?.isCorrect ? (
                <CheckCircle className="h-4 w-4 text-green-600" />
              ) : (
                <XCircle className="h-4 w-4 text-red-600" />
              )}
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  );
}