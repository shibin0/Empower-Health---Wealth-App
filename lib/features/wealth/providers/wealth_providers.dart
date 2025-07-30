import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/financial_data.dart';

part 'wealth_providers.g.dart';

@riverpod
class PortfolioNotifier extends _$PortfolioNotifier {
  @override
  Future<Portfolio?> build() async {
    return await _loadPortfolio();
  }

  Future<Portfolio?> _loadPortfolio() async {
    // For now, return mock data until storage services are properly integrated
    final mockInvestments = [
      Investment(
        id: '1',
        symbol: 'AAPL',
        name: 'Apple Inc.',
        shares: 10,
        currentPrice: 150.0,
        purchasePrice: 140.0,
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        type: InvestmentType.stock,
        dividendYield: 0.5,
      ),
      Investment(
        id: '2',
        symbol: 'GOOGL',
        name: 'Alphabet Inc.',
        shares: 5,
        currentPrice: 2800.0,
        purchasePrice: 2700.0,
        purchaseDate: DateTime.now().subtract(const Duration(days: 60)),
        type: InvestmentType.stock,
        dividendYield: 0.0,
      ),
    ];

    final totalValue = mockInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.currentPrice));
    final totalCost = mockInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.purchasePrice));
    final totalGain = totalValue - totalCost;
    final totalGainPercentage = (totalGain / totalCost) * 100;

    return Portfolio(
      id: 'portfolio_1',
      userId: 'user_1',
      investments: mockInvestments,
      totalValue: totalValue,
      totalGain: totalGain,
      totalGainPercentage: totalGainPercentage,
      lastUpdated: DateTime.now(),
    );
  }

  Future<void> addInvestment(Investment investment) async {
    final currentPortfolio = await future;
    if (currentPortfolio == null) return;

    final updatedInvestments = [...currentPortfolio.investments, investment];
    final totalValue = updatedInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.currentPrice));
    final totalCost = updatedInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.purchasePrice));
    final totalGain = totalValue - totalCost;
    final totalGainPercentage = totalCost > 0 ? (totalGain / totalCost) * 100 : 0.0;

    final updatedPortfolio = currentPortfolio.copyWith(
      investments: updatedInvestments,
      totalValue: totalValue,
      totalGain: totalGain,
      totalGainPercentage: totalGainPercentage,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPortfolio);
  }

  Future<void> updateInvestment(Investment updatedInvestment) async {
    final currentPortfolio = await future;
    if (currentPortfolio == null) return;

    final updatedInvestments = currentPortfolio.investments.map((inv) {
      return inv.id == updatedInvestment.id ? updatedInvestment : inv;
    }).toList();

    final totalValue = updatedInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.currentPrice));
    final totalCost = updatedInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.purchasePrice));
    final totalGain = totalValue - totalCost;
    final totalGainPercentage = totalCost > 0 ? (totalGain / totalCost) * 100 : 0.0;

    final updatedPortfolio = currentPortfolio.copyWith(
      investments: updatedInvestments,
      totalValue: totalValue,
      totalGain: totalGain,
      totalGainPercentage: totalGainPercentage,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPortfolio);
  }

  Future<void> removeInvestment(String investmentId) async {
    final currentPortfolio = await future;
    if (currentPortfolio == null) return;

    final updatedInvestments = currentPortfolio.investments
        .where((inv) => inv.id != investmentId)
        .toList();

    final totalValue = updatedInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.currentPrice));
    final totalCost = updatedInvestments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.purchasePrice));
    final totalGain = totalValue - totalCost;
    final totalGainPercentage = totalCost > 0 ? (totalGain / totalCost) * 100 : 0.0;

    final updatedPortfolio = currentPortfolio.copyWith(
      investments: updatedInvestments,
      totalValue: totalValue,
      totalGain: totalGain,
      totalGainPercentage: totalGainPercentage,
      lastUpdated: DateTime.now(),
    );

    state = AsyncValue.data(updatedPortfolio);
  }

  Future<void> refreshPortfolio() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadPortfolio());
  }
}

@riverpod
class FinancialGoalsNotifier extends _$FinancialGoalsNotifier {
  @override
  Future<List<FinancialGoal>> build() async {
    return await _loadFinancialGoals();
  }

  Future<List<FinancialGoal>> _loadFinancialGoals() async {
    // For now, return mock data
    return [
      FinancialGoal(
        id: '1',
        userId: 'user_1',
        title: 'Emergency Fund',
        description: 'Build an emergency fund covering 6 months of expenses',
        targetAmount: 50000.0,
        currentAmount: 25000.0,
        targetDate: DateTime.now().add(const Duration(days: 365)),
        category: GoalCategory.emergencyFund,
        priority: GoalPriority.high,
        status: GoalStatus.active,
      ),
      FinancialGoal(
        id: '2',
        userId: 'user_1',
        title: 'Retirement Savings',
        description: 'Save for comfortable retirement',
        targetAmount: 1000000.0,
        currentAmount: 150000.0,
        targetDate: DateTime.now().add(const Duration(days: 365 * 20)),
        category: GoalCategory.retirement,
        priority: GoalPriority.critical,
        status: GoalStatus.active,
      ),
    ];
  }

  Future<void> addGoal(FinancialGoal goal) async {
    final currentGoals = await future;
    state = AsyncValue.data([...currentGoals, goal]);
  }

  Future<void> updateGoal(FinancialGoal updatedGoal) async {
    final currentGoals = await future;
    final updatedGoals = currentGoals.map((goal) {
      return goal.id == updatedGoal.id ? updatedGoal : goal;
    }).toList();
    
    state = AsyncValue.data(updatedGoals);
  }

  Future<void> deleteGoal(String goalId) async {
    final currentGoals = await future;
    final updatedGoals = currentGoals.where((goal) => goal.id != goalId).toList();
    
    state = AsyncValue.data(updatedGoals);
  }

  Future<void> updateGoalProgress(String goalId, double newAmount) async {
    final currentGoals = await future;
    final updatedGoals = currentGoals.map((goal) {
      if (goal.id == goalId) {
        // Update status based on progress
        GoalStatus newStatus = goal.status;
        if (newAmount >= goal.targetAmount) {
          newStatus = GoalStatus.completed;
        } else if (newAmount > goal.currentAmount) {
          newStatus = GoalStatus.active;
        }
        
        return goal.copyWith(
          currentAmount: newAmount,
          status: newStatus,
        );
      }
      return goal;
    }).toList();
    
    state = AsyncValue.data(updatedGoals);
  }
}

// Filtered providers for specific investment types
@riverpod
Future<List<Investment>> investmentsByType(
  InvestmentsByTypeRef ref,
  InvestmentType type,
) async {
  final portfolio = await ref.watch(portfolioNotifierProvider.future);
  if (portfolio == null) return [];
  
  return portfolio.investments.where((inv) => inv.type == type).toList();
}

// Portfolio analysis provider
@riverpod
Future<PortfolioAnalysis?> portfolioAnalysis(PortfolioAnalysisRef ref) async {
  final portfolio = await ref.watch(portfolioNotifierProvider.future);
  if (portfolio == null || portfolio.investments.isEmpty) return null;

  final investments = portfolio.investments;
  final totalValue = portfolio.totalValue;
  final totalCost = investments.fold(0.0, (sum, inv) => sum + (inv.shares * inv.purchasePrice));
  final totalReturn = totalValue - totalCost;
  final totalReturnPercentage = totalCost > 0 ? (totalReturn / totalCost) * 100 : 0.0;

  // Calculate asset allocation
  final Map<AssetClass, double> allocation = {};
  for (final investment in investments) {
    final value = investment.shares * investment.currentPrice;
    final assetClass = _mapInvestmentTypeToAssetClass(investment.type);
    allocation[assetClass] = (allocation[assetClass] ?? 0) + value;
  }

  // Convert to percentages
  final Map<AssetClass, double> allocationPercentages = {};
  for (final entry in allocation.entries) {
    allocationPercentages[entry.key] = (entry.value / totalValue) * 100;
  }

  return PortfolioAnalysis(
    totalValue: totalValue,
    totalReturn: totalReturn,
    totalReturnPercentage: totalReturnPercentage,
    annualizedReturn: _calculateAnnualizedReturn(investments),
    volatility: _calculateVolatility(investments),
    sharpeRatio: _calculateSharpeRatio(investments),
    assetAllocation: allocationPercentages,
    sectorAllocation: {}, // Would be calculated based on actual sector data
    analysisDate: DateTime.now(),
  );
}

AssetClass _mapInvestmentTypeToAssetClass(InvestmentType type) {
  switch (type) {
    case InvestmentType.stock:
    case InvestmentType.etf:
    case InvestmentType.mutualFund:
      return AssetClass.equity;
    case InvestmentType.bond:
      return AssetClass.fixedIncome;
    case InvestmentType.realEstate:
      return AssetClass.realEstate;
    case InvestmentType.commodity:
      return AssetClass.commodities;
    case InvestmentType.cash:
      return AssetClass.cash;
    case InvestmentType.crypto:
    case InvestmentType.other:
      return AssetClass.alternatives;
  }
}

double _calculateAnnualizedReturn(List<Investment> investments) {
  // Simplified calculation - would need historical data for accurate calculation
  if (investments.isEmpty) return 0.0;
  
  double totalReturn = 0.0;
  double totalWeight = 0.0;
  
  for (final investment in investments) {
    final currentValue = investment.shares * investment.currentPrice;
    final purchaseValue = investment.shares * investment.purchasePrice;
    final returnRate = (currentValue - purchaseValue) / purchaseValue;
    
    totalReturn += returnRate * currentValue;
    totalWeight += currentValue;
  }
  
  return totalWeight > 0 ? (totalReturn / totalWeight) * 100 : 0.0;
}

double _calculateVolatility(List<Investment> investments) {
  // Simplified calculation - would need historical price data
  return 15.0; // Mock volatility percentage
}

double _calculateSharpeRatio(List<Investment> investments) {
  // Simplified calculation - would need risk-free rate and historical data
  final annualizedReturn = _calculateAnnualizedReturn(investments);
  final volatility = _calculateVolatility(investments);
  const riskFreeRate = 2.0; // Mock risk-free rate
  
  return volatility > 0 ? (annualizedReturn - riskFreeRate) / volatility : 0.0;
}

// Wealth trends provider
@riverpod
Future<List<WealthTrend>> wealthTrends(WealthTrendsRef ref) async {
  final analysis = await ref.watch(portfolioAnalysisProvider.future);
  if (analysis == null) return [];

  // For now, return mock trends
  return [
    WealthTrend(
      type: WealthMetricType.totalValue,
      direction: analysis.totalReturnPercentage > 0 ? TrendDirection.improving : TrendDirection.declining,
      changePercentage: analysis.totalReturnPercentage.abs(),
      description: 'Portfolio ${analysis.totalReturnPercentage > 0 ? 'gained' : 'lost'} ${analysis.totalReturnPercentage.abs().toStringAsFixed(1)}%',
      periodStart: DateTime.now().subtract(const Duration(days: 30)),
      periodEnd: DateTime.now(),
    ),
  ];
}

// Wealth insights provider (simplified for now)
@riverpod
Future<WealthInsights?> wealthInsights(WealthInsightsRef ref) async {
  final analysis = await ref.watch(portfolioAnalysisProvider.future);
  final trends = await ref.watch(wealthTrendsProvider.future);
  
  if (analysis == null) return null;
  
  // For now, return simplified insights
  // Later this would integrate with AI service
  return WealthInsights(
    userId: 'current_user', // Would get from auth
    generatedAt: DateTime.now(),
    portfolioAnalysis: analysis,
    recommendations: [], // Would be generated by AI
    riskAssessment: RiskAssessment(
      overallRisk: RiskLevel.moderate,
      riskScore: 60.0,
      categoryRisks: {
        RiskCategory.marketRisk: 70.0,
        RiskCategory.concentrationRisk: 50.0,
      },
      riskFactors: [],
      assessmentDate: DateTime.now(),
    ),
    trends: trends,
  );
}

// Goal progress tracking
@riverpod
Future<Map<String, double>> goalProgress(GoalProgressRef ref) async {
  final goals = await ref.watch(financialGoalsNotifierProvider.future);
  final Map<String, double> progress = {};
  
  for (final goal in goals) {
    progress[goal.id] = goal.targetAmount > 0 
        ? (goal.currentAmount / goal.targetAmount) * 100 
        : 0.0;
  }
  
  return progress;
}

// Sync status for wealth data (simplified for now)
@riverpod
Future<bool> wealthDataSyncStatus(WealthDataSyncStatusRef ref) async {
  // For now, always return true (synced)
  // Later this would check actual sync status
  return true;
}