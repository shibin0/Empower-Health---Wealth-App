// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioImpl _$$PortfolioImplFromJson(Map<String, dynamic> json) =>
    _$PortfolioImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      investments: (json['investments'] as List<dynamic>)
          .map((e) => Investment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalValue: (json['totalValue'] as num).toDouble(),
      totalGain: (json['totalGain'] as num).toDouble(),
      totalGainPercentage: (json['totalGainPercentage'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$PortfolioImplToJson(_$PortfolioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'investments': instance.investments,
      'totalValue': instance.totalValue,
      'totalGain': instance.totalGain,
      'totalGainPercentage': instance.totalGainPercentage,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'isSynced': instance.isSynced,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
      'metadata': instance.metadata,
    };

_$InvestmentImpl _$$InvestmentImplFromJson(Map<String, dynamic> json) =>
    _$InvestmentImpl(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      shares: (json['shares'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      type: $enumDecode(_$InvestmentTypeEnumMap, json['type']),
      dividendYield: (json['dividendYield'] as num?)?.toDouble() ?? 0.0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      isSynced: json['isSynced'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
    );

Map<String, dynamic> _$$InvestmentImplToJson(_$InvestmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'shares': instance.shares,
      'currentPrice': instance.currentPrice,
      'purchasePrice': instance.purchasePrice,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'type': _$InvestmentTypeEnumMap[instance.type]!,
      'dividendYield': instance.dividendYield,
      'metadata': instance.metadata,
      'isSynced': instance.isSynced,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
    };

const _$InvestmentTypeEnumMap = {
  InvestmentType.stock: 'stock',
  InvestmentType.bond: 'bond',
  InvestmentType.etf: 'etf',
  InvestmentType.mutualFund: 'mutual_fund',
  InvestmentType.crypto: 'crypto',
  InvestmentType.realEstate: 'real_estate',
  InvestmentType.commodity: 'commodity',
  InvestmentType.cash: 'cash',
  InvestmentType.other: 'other',
};

_$WealthInsightsImpl _$$WealthInsightsImplFromJson(Map<String, dynamic> json) =>
    _$WealthInsightsImpl(
      userId: json['userId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      portfolioAnalysis: PortfolioAnalysis.fromJson(
          json['portfolioAnalysis'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => WealthRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      riskAssessment: RiskAssessment.fromJson(
          json['riskAssessment'] as Map<String, dynamic>),
      trends: (json['trends'] as List<dynamic>)
          .map((e) => WealthTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$WealthInsightsImplToJson(
        _$WealthInsightsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'portfolioAnalysis': instance.portfolioAnalysis,
      'recommendations': instance.recommendations,
      'riskAssessment': instance.riskAssessment,
      'trends': instance.trends,
      'additionalData': instance.additionalData,
    };

_$PortfolioAnalysisImpl _$$PortfolioAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$PortfolioAnalysisImpl(
      totalValue: (json['totalValue'] as num).toDouble(),
      totalReturn: (json['totalReturn'] as num).toDouble(),
      totalReturnPercentage: (json['totalReturnPercentage'] as num).toDouble(),
      annualizedReturn: (json['annualizedReturn'] as num).toDouble(),
      volatility: (json['volatility'] as num).toDouble(),
      sharpeRatio: (json['sharpeRatio'] as num).toDouble(),
      assetAllocation: (json['assetAllocation'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$AssetClassEnumMap, k), (e as num).toDouble()),
      ),
      sectorAllocation: (json['sectorAllocation'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      analysisDate: DateTime.parse(json['analysisDate'] as String),
    );

Map<String, dynamic> _$$PortfolioAnalysisImplToJson(
        _$PortfolioAnalysisImpl instance) =>
    <String, dynamic>{
      'totalValue': instance.totalValue,
      'totalReturn': instance.totalReturn,
      'totalReturnPercentage': instance.totalReturnPercentage,
      'annualizedReturn': instance.annualizedReturn,
      'volatility': instance.volatility,
      'sharpeRatio': instance.sharpeRatio,
      'assetAllocation': instance.assetAllocation
          .map((k, e) => MapEntry(_$AssetClassEnumMap[k]!, e)),
      'sectorAllocation': instance.sectorAllocation,
      'analysisDate': instance.analysisDate.toIso8601String(),
    };

const _$AssetClassEnumMap = {
  AssetClass.equity: 'equity',
  AssetClass.fixedIncome: 'fixed_income',
  AssetClass.realEstate: 'real_estate',
  AssetClass.commodities: 'commodities',
  AssetClass.cash: 'cash',
  AssetClass.alternatives: 'alternatives',
};

_$WealthRecommendationImpl _$$WealthRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$WealthRecommendationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: $enumDecode(_$RecommendationPriorityEnumMap, json['priority']),
      type: $enumDecode(_$WealthRecommendationTypeEnumMap, json['type']),
      actionItems: (json['actionItems'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$WealthRecommendationImplToJson(
        _$WealthRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$RecommendationPriorityEnumMap[instance.priority]!,
      'type': _$WealthRecommendationTypeEnumMap[instance.type]!,
      'actionItems': instance.actionItems,
      'metadata': instance.metadata,
    };

const _$RecommendationPriorityEnumMap = {
  RecommendationPriority.low: 'low',
  RecommendationPriority.medium: 'medium',
  RecommendationPriority.high: 'high',
  RecommendationPriority.critical: 'critical',
};

const _$WealthRecommendationTypeEnumMap = {
  WealthRecommendationType.rebalancing: 'rebalancing',
  WealthRecommendationType.diversification: 'diversification',
  WealthRecommendationType.riskManagement: 'risk_management',
  WealthRecommendationType.taxOptimization: 'tax_optimization',
  WealthRecommendationType.goalAdjustment: 'goal_adjustment',
  WealthRecommendationType.investmentOpportunity: 'investment_opportunity',
};

_$RiskAssessmentImpl _$$RiskAssessmentImplFromJson(Map<String, dynamic> json) =>
    _$RiskAssessmentImpl(
      overallRisk: $enumDecode(_$RiskLevelEnumMap, json['overallRisk']),
      riskScore: (json['riskScore'] as num).toDouble(),
      categoryRisks: (json['categoryRisks'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$RiskCategoryEnumMap, k), (e as num).toDouble()),
      ),
      riskFactors: (json['riskFactors'] as List<dynamic>)
          .map((e) => RiskFactor.fromJson(e as Map<String, dynamic>))
          .toList(),
      assessmentDate: DateTime.parse(json['assessmentDate'] as String),
    );

Map<String, dynamic> _$$RiskAssessmentImplToJson(
        _$RiskAssessmentImpl instance) =>
    <String, dynamic>{
      'overallRisk': _$RiskLevelEnumMap[instance.overallRisk]!,
      'riskScore': instance.riskScore,
      'categoryRisks': instance.categoryRisks
          .map((k, e) => MapEntry(_$RiskCategoryEnumMap[k]!, e)),
      'riskFactors': instance.riskFactors,
      'assessmentDate': instance.assessmentDate.toIso8601String(),
    };

const _$RiskLevelEnumMap = {
  RiskLevel.veryLow: 'very_low',
  RiskLevel.low: 'low',
  RiskLevel.moderate: 'moderate',
  RiskLevel.high: 'high',
  RiskLevel.veryHigh: 'very_high',
};

const _$RiskCategoryEnumMap = {
  RiskCategory.marketRisk: 'market_risk',
  RiskCategory.creditRisk: 'credit_risk',
  RiskCategory.liquidityRisk: 'liquidity_risk',
  RiskCategory.inflationRisk: 'inflation_risk',
  RiskCategory.currencyRisk: 'currency_risk',
  RiskCategory.concentrationRisk: 'concentration_risk',
};

_$WealthTrendImpl _$$WealthTrendImplFromJson(Map<String, dynamic> json) =>
    _$WealthTrendImpl(
      type: $enumDecode(_$WealthMetricTypeEnumMap, json['type']),
      direction: $enumDecode(_$TrendDirectionEnumMap, json['direction']),
      changePercentage: (json['changePercentage'] as num).toDouble(),
      description: json['description'] as String,
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
    );

Map<String, dynamic> _$$WealthTrendImplToJson(_$WealthTrendImpl instance) =>
    <String, dynamic>{
      'type': _$WealthMetricTypeEnumMap[instance.type]!,
      'direction': _$TrendDirectionEnumMap[instance.direction]!,
      'changePercentage': instance.changePercentage,
      'description': instance.description,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
    };

const _$WealthMetricTypeEnumMap = {
  WealthMetricType.totalValue: 'total_value',
  WealthMetricType.totalReturn: 'total_return',
  WealthMetricType.annualReturn: 'annual_return',
  WealthMetricType.volatility: 'volatility',
  WealthMetricType.sharpeRatio: 'sharpe_ratio',
  WealthMetricType.dividendYield: 'dividend_yield',
};

const _$TrendDirectionEnumMap = {
  TrendDirection.improving: 'improving',
  TrendDirection.declining: 'declining',
  TrendDirection.stable: 'stable',
  TrendDirection.fluctuating: 'fluctuating',
};

_$RiskFactorImpl _$$RiskFactorImplFromJson(Map<String, dynamic> json) =>
    _$RiskFactorImpl(
      name: json['name'] as String,
      level: $enumDecode(_$RiskLevelEnumMap, json['level']),
      impact: (json['impact'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$RiskFactorImplToJson(_$RiskFactorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'level': _$RiskLevelEnumMap[instance.level]!,
      'impact': instance.impact,
      'description': instance.description,
    };

_$FinancialGoalImpl _$$FinancialGoalImplFromJson(Map<String, dynamic> json) =>
    _$FinancialGoalImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      targetAmount: (json['targetAmount'] as num).toDouble(),
      currentAmount: (json['currentAmount'] as num).toDouble(),
      targetDate: DateTime.parse(json['targetDate'] as String),
      category: $enumDecode(_$GoalCategoryEnumMap, json['category']),
      priority: $enumDecode(_$GoalPriorityEnumMap, json['priority']),
      status: $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
          GoalStatus.active,
      isSynced: json['isSynced'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$FinancialGoalImplToJson(_$FinancialGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'targetAmount': instance.targetAmount,
      'currentAmount': instance.currentAmount,
      'targetDate': instance.targetDate.toIso8601String(),
      'category': _$GoalCategoryEnumMap[instance.category]!,
      'priority': _$GoalPriorityEnumMap[instance.priority]!,
      'status': _$GoalStatusEnumMap[instance.status]!,
      'isSynced': instance.isSynced,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$GoalCategoryEnumMap = {
  GoalCategory.retirement: 'retirement',
  GoalCategory.emergencyFund: 'emergency_fund',
  GoalCategory.housePurchase: 'house_purchase',
  GoalCategory.education: 'education',
  GoalCategory.vacation: 'vacation',
  GoalCategory.debtPayoff: 'debt_payoff',
  GoalCategory.investment: 'investment',
  GoalCategory.other: 'other',
};

const _$GoalPriorityEnumMap = {
  GoalPriority.low: 'low',
  GoalPriority.medium: 'medium',
  GoalPriority.high: 'high',
  GoalPriority.critical: 'critical',
};

const _$GoalStatusEnumMap = {
  GoalStatus.active: 'active',
  GoalStatus.completed: 'completed',
  GoalStatus.paused: 'paused',
  GoalStatus.cancelled: 'cancelled',
};
