import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_data.freezed.dart';
part 'financial_data.g.dart';

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    required String id,
    required String userId,
    required List<Investment> investments,
    required double totalValue,
    required double totalGain,
    required double totalGainPercentage,
    required DateTime lastUpdated,
    @Default(false) bool isSynced,
    DateTime? lastSyncedAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Portfolio;

  factory Portfolio.fromJson(Map<String, dynamic> json) =>
      _$PortfolioFromJson(json);
}

@freezed
class Investment with _$Investment {
  const factory Investment({
    required String id,
    required String symbol,
    required String name,
    required double shares,
    required double currentPrice,
    required double purchasePrice,
    required DateTime purchaseDate,
    required InvestmentType type,
    @Default(0.0) double dividendYield,
    @Default({}) Map<String, dynamic> metadata,
    @Default(false) bool isSynced,
    DateTime? lastSyncedAt,
  }) = _Investment;

  factory Investment.fromJson(Map<String, dynamic> json) =>
      _$InvestmentFromJson(json);
}

@freezed
class WealthInsights with _$WealthInsights {
  const factory WealthInsights({
    required String userId,
    required DateTime generatedAt,
    required PortfolioAnalysis portfolioAnalysis,
    required List<WealthRecommendation> recommendations,
    required RiskAssessment riskAssessment,
    required List<WealthTrend> trends,
    @Default({}) Map<String, dynamic> additionalData,
  }) = _WealthInsights;

  factory WealthInsights.fromJson(Map<String, dynamic> json) =>
      _$WealthInsightsFromJson(json);
}

@freezed
class PortfolioAnalysis with _$PortfolioAnalysis {
  const factory PortfolioAnalysis({
    required double totalValue,
    required double totalReturn,
    required double totalReturnPercentage,
    required double annualizedReturn,
    required double volatility,
    required double sharpeRatio,
    required Map<AssetClass, double> assetAllocation,
    required Map<String, double> sectorAllocation,
    required DateTime analysisDate,
  }) = _PortfolioAnalysis;

  factory PortfolioAnalysis.fromJson(Map<String, dynamic> json) =>
      _$PortfolioAnalysisFromJson(json);
}

@freezed
class WealthRecommendation with _$WealthRecommendation {
  const factory WealthRecommendation({
    required String id,
    required String title,
    required String description,
    required RecommendationPriority priority,
    required WealthRecommendationType type,
    required List<String> actionItems,
    @Default({}) Map<String, dynamic> metadata,
  }) = _WealthRecommendation;

  factory WealthRecommendation.fromJson(Map<String, dynamic> json) =>
      _$WealthRecommendationFromJson(json);
}

@freezed
class RiskAssessment with _$RiskAssessment {
  const factory RiskAssessment({
    required RiskLevel overallRisk,
    required double riskScore,
    required Map<RiskCategory, double> categoryRisks,
    required List<RiskFactor> riskFactors,
    required DateTime assessmentDate,
  }) = _RiskAssessment;

  factory RiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$RiskAssessmentFromJson(json);
}

@freezed
class WealthTrend with _$WealthTrend {
  const factory WealthTrend({
    required WealthMetricType type,
    required TrendDirection direction,
    required double changePercentage,
    required String description,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) = _WealthTrend;

  factory WealthTrend.fromJson(Map<String, dynamic> json) =>
      _$WealthTrendFromJson(json);
}

@freezed
class RiskFactor with _$RiskFactor {
  const factory RiskFactor({
    required String name,
    required RiskLevel level,
    required double impact,
    required String description,
  }) = _RiskFactor;

  factory RiskFactor.fromJson(Map<String, dynamic> json) =>
      _$RiskFactorFromJson(json);
}

@freezed
class FinancialGoal with _$FinancialGoal {
  const factory FinancialGoal({
    required String id,
    required String userId,
    required String title,
    required String description,
    required double targetAmount,
    required double currentAmount,
    required DateTime targetDate,
    required GoalCategory category,
    required GoalPriority priority,
    @Default(GoalStatus.active) GoalStatus status,
    @Default(false) bool isSynced,
    DateTime? lastSyncedAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _FinancialGoal;

  factory FinancialGoal.fromJson(Map<String, dynamic> json) =>
      _$FinancialGoalFromJson(json);
}

// Enums
enum InvestmentType {
  @JsonValue('stock')
  stock,
  @JsonValue('bond')
  bond,
  @JsonValue('etf')
  etf,
  @JsonValue('mutual_fund')
  mutualFund,
  @JsonValue('crypto')
  crypto,
  @JsonValue('real_estate')
  realEstate,
  @JsonValue('commodity')
  commodity,
  @JsonValue('cash')
  cash,
  @JsonValue('other')
  other,
}

enum AssetClass {
  @JsonValue('equity')
  equity,
  @JsonValue('fixed_income')
  fixedIncome,
  @JsonValue('real_estate')
  realEstate,
  @JsonValue('commodities')
  commodities,
  @JsonValue('cash')
  cash,
  @JsonValue('alternatives')
  alternatives,
}

enum RecommendationPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum WealthRecommendationType {
  @JsonValue('rebalancing')
  rebalancing,
  @JsonValue('diversification')
  diversification,
  @JsonValue('risk_management')
  riskManagement,
  @JsonValue('tax_optimization')
  taxOptimization,
  @JsonValue('goal_adjustment')
  goalAdjustment,
  @JsonValue('investment_opportunity')
  investmentOpportunity,
}

enum RiskLevel {
  @JsonValue('very_low')
  veryLow,
  @JsonValue('low')
  low,
  @JsonValue('moderate')
  moderate,
  @JsonValue('high')
  high,
  @JsonValue('very_high')
  veryHigh,
}

enum RiskCategory {
  @JsonValue('market_risk')
  marketRisk,
  @JsonValue('credit_risk')
  creditRisk,
  @JsonValue('liquidity_risk')
  liquidityRisk,
  @JsonValue('inflation_risk')
  inflationRisk,
  @JsonValue('currency_risk')
  currencyRisk,
  @JsonValue('concentration_risk')
  concentrationRisk,
}

enum TrendDirection {
  @JsonValue('improving')
  improving,
  @JsonValue('declining')
  declining,
  @JsonValue('stable')
  stable,
  @JsonValue('fluctuating')
  fluctuating,
}

enum WealthMetricType {
  @JsonValue('total_value')
  totalValue,
  @JsonValue('total_return')
  totalReturn,
  @JsonValue('annual_return')
  annualReturn,
  @JsonValue('volatility')
  volatility,
  @JsonValue('sharpe_ratio')
  sharpeRatio,
  @JsonValue('dividend_yield')
  dividendYield,
}

enum GoalCategory {
  @JsonValue('retirement')
  retirement,
  @JsonValue('emergency_fund')
  emergencyFund,
  @JsonValue('house_purchase')
  housePurchase,
  @JsonValue('education')
  education,
  @JsonValue('vacation')
  vacation,
  @JsonValue('debt_payoff')
  debtPayoff,
  @JsonValue('investment')
  investment,
  @JsonValue('other')
  other,
}

enum GoalPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum GoalStatus {
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
  @JsonValue('paused')
  paused,
  @JsonValue('cancelled')
  cancelled,
}

// Extension methods for better usability
extension InvestmentTypeExtension on InvestmentType {
  String get displayName {
    switch (this) {
      case InvestmentType.stock:
        return 'Stock';
      case InvestmentType.bond:
        return 'Bond';
      case InvestmentType.etf:
        return 'ETF';
      case InvestmentType.mutualFund:
        return 'Mutual Fund';
      case InvestmentType.crypto:
        return 'Cryptocurrency';
      case InvestmentType.realEstate:
        return 'Real Estate';
      case InvestmentType.commodity:
        return 'Commodity';
      case InvestmentType.cash:
        return 'Cash';
      case InvestmentType.other:
        return 'Other';
    }
  }
}

extension RiskLevelExtension on RiskLevel {
  String get displayName {
    switch (this) {
      case RiskLevel.veryLow:
        return 'Very Low';
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.moderate:
        return 'Moderate';
      case RiskLevel.high:
        return 'High';
      case RiskLevel.veryHigh:
        return 'Very High';
    }
  }

  double get numericValue {
    switch (this) {
      case RiskLevel.veryLow:
        return 1.0;
      case RiskLevel.low:
        return 2.0;
      case RiskLevel.moderate:
        return 3.0;
      case RiskLevel.high:
        return 4.0;
      case RiskLevel.veryHigh:
        return 5.0;
    }
  }
}

extension GoalCategoryExtension on GoalCategory {
  String get displayName {
    switch (this) {
      case GoalCategory.retirement:
        return 'Retirement';
      case GoalCategory.emergencyFund:
        return 'Emergency Fund';
      case GoalCategory.housePurchase:
        return 'House Purchase';
      case GoalCategory.education:
        return 'Education';
      case GoalCategory.vacation:
        return 'Vacation';
      case GoalCategory.debtPayoff:
        return 'Debt Payoff';
      case GoalCategory.investment:
        return 'Investment';
      case GoalCategory.other:
        return 'Other';
    }
  }
}