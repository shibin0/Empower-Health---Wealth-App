import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

// Data models for calculator results
class SIPCalculationResult {
  final double monthlyInvestment;
  final double expectedReturns;
  final double totalInvestment;
  final double maturityAmount;
  final double wealthGained;
  final int years;
  final List<YearlyBreakdown> yearlyBreakdown;

  const SIPCalculationResult({
    required this.monthlyInvestment,
    required this.expectedReturns,
    required this.totalInvestment,
    required this.maturityAmount,
    required this.wealthGained,
    required this.years,
    required this.yearlyBreakdown,
  });
}

class YearlyBreakdown {
  final int year;
  final double totalInvested;
  final double totalValue;
  final double returns;

  const YearlyBreakdown({
    required this.year,
    required this.totalInvested,
    required this.totalValue,
    required this.returns,
  });
}

class BMICalculationResult {
  final double bmi;
  final String category;
  final String description;
  final String healthRisk;
  final double idealWeightMin;
  final double idealWeightMax;
  final String recommendations;

  const BMICalculationResult({
    required this.bmi,
    required this.category,
    required this.description,
    required this.healthRisk,
    required this.idealWeightMin,
    required this.idealWeightMax,
    required this.recommendations,
  });
}

class BudgetCalculationResult {
  final double totalIncome;
  final double totalExpenses;
  final double savings;
  final double savingsPercentage;
  final Map<String, double> expenseBreakdown;
  final Map<String, double> expensePercentages;
  final String budgetStatus;
  final List<String> recommendations;

  const BudgetCalculationResult({
    required this.totalIncome,
    required this.totalExpenses,
    required this.savings,
    required this.savingsPercentage,
    required this.expenseBreakdown,
    required this.expensePercentages,
    required this.budgetStatus,
    required this.recommendations,
  });
}

class LumpSumCalculationResult {
  final double initialInvestment;
  final double expectedReturns;
  final double maturityAmount;
  final double wealthGained;
  final int years;
  final List<YearlyBreakdown> yearlyBreakdown;

  const LumpSumCalculationResult({
    required this.initialInvestment,
    required this.expectedReturns,
    required this.maturityAmount,
    required this.wealthGained,
    required this.years,
    required this.yearlyBreakdown,
  });
}

class EMICalculationResult {
  final double loanAmount;
  final double interestRate;
  final int tenure;
  final double emi;
  final double totalInterest;
  final double totalAmount;
  final List<EMIBreakdown> emiBreakdown;

  const EMICalculationResult({
    required this.loanAmount,
    required this.interestRate,
    required this.tenure,
    required this.emi,
    required this.totalInterest,
    required this.totalAmount,
    required this.emiBreakdown,
  });
}

class EMIBreakdown {
  final int month;
  final double emi;
  final double principal;
  final double interest;
  final double balance;

  const EMIBreakdown({
    required this.month,
    required this.emi,
    required this.principal,
    required this.interest,
    required this.balance,
  });
}

class CalculatorService {
  // SIP Calculator
  static SIPCalculationResult calculateSIP({
    required double monthlyInvestment,
    required double expectedReturns,
    required int years,
  }) {
    final monthlyRate = expectedReturns / 100 / 12;
    final totalMonths = years * 12;
    
    // SIP formula: M * [((1 + r)^n - 1) / r] * (1 + r)
    final maturityAmount = monthlyInvestment * 
        (((pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate) * (1 + monthlyRate));
    
    final totalInvestment = monthlyInvestment * totalMonths;
    final wealthGained = maturityAmount - totalInvestment;

    // Generate yearly breakdown
    final yearlyBreakdown = <YearlyBreakdown>[];
    for (int year = 1; year <= years; year++) {
      final monthsCompleted = year * 12;
      final investedAmount = monthlyInvestment * monthsCompleted;
      final valueAtYear = monthlyInvestment * 
          (((pow(1 + monthlyRate, monthsCompleted) - 1) / monthlyRate) * (1 + monthlyRate));
      final returnsAtYear = valueAtYear - investedAmount;

      yearlyBreakdown.add(YearlyBreakdown(
        year: year,
        totalInvested: investedAmount,
        totalValue: valueAtYear,
        returns: returnsAtYear,
      ));
    }

    return SIPCalculationResult(
      monthlyInvestment: monthlyInvestment,
      expectedReturns: expectedReturns,
      totalInvestment: totalInvestment,
      maturityAmount: maturityAmount,
      wealthGained: wealthGained,
      years: years,
      yearlyBreakdown: yearlyBreakdown,
    );
  }

  // Lump Sum Calculator
  static LumpSumCalculationResult calculateLumpSum({
    required double initialInvestment,
    required double expectedReturns,
    required int years,
  }) {
    final annualRate = expectedReturns / 100;
    
    // Compound interest formula: P * (1 + r)^t
    final maturityAmount = initialInvestment * pow(1 + annualRate, years);
    final wealthGained = maturityAmount - initialInvestment;

    // Generate yearly breakdown
    final yearlyBreakdown = <YearlyBreakdown>[];
    for (int year = 1; year <= years; year++) {
      final valueAtYear = initialInvestment * pow(1 + annualRate, year);
      final returnsAtYear = valueAtYear - initialInvestment;

      yearlyBreakdown.add(YearlyBreakdown(
        year: year,
        totalInvested: initialInvestment,
        totalValue: valueAtYear,
        returns: returnsAtYear,
      ));
    }

    return LumpSumCalculationResult(
      initialInvestment: initialInvestment,
      expectedReturns: expectedReturns,
      maturityAmount: maturityAmount,
      wealthGained: wealthGained,
      years: years,
      yearlyBreakdown: yearlyBreakdown,
    );
  }

  // BMI Calculator
  static BMICalculationResult calculateBMI({
    required double weight, // in kg
    required double height, // in cm
  }) {
    final heightInMeters = height / 100;
    final bmi = weight / (heightInMeters * heightInMeters);

    String category;
    String description;
    String healthRisk;
    String recommendations;

    if (bmi < 18.5) {
      category = 'Underweight';
      description = 'Below normal weight';
      healthRisk = 'Low';
      recommendations = 'Consider gaining weight through a balanced diet and strength training. Consult a nutritionist for a personalized plan.';
    } else if (bmi >= 18.5 && bmi < 25) {
      category = 'Normal';
      description = 'Healthy weight range';
      healthRisk = 'Very Low';
      recommendations = 'Maintain your current weight through regular exercise and a balanced diet. Keep up the good work!';
    } else if (bmi >= 25 && bmi < 30) {
      category = 'Overweight';
      description = 'Above normal weight';
      healthRisk = 'Moderate';
      recommendations = 'Consider losing weight through a combination of diet and exercise. Aim for 150 minutes of moderate exercise per week.';
    } else {
      category = 'Obese';
      description = 'Significantly above normal weight';
      healthRisk = 'High';
      recommendations = 'Consult a healthcare provider for a weight management plan. Focus on gradual weight loss through diet and exercise.';
    }

    // Calculate ideal weight range (BMI 18.5-24.9)
    final idealWeightMin = 18.5 * (heightInMeters * heightInMeters);
    final idealWeightMax = 24.9 * (heightInMeters * heightInMeters);

    return BMICalculationResult(
      bmi: bmi,
      category: category,
      description: description,
      healthRisk: healthRisk,
      idealWeightMin: idealWeightMin,
      idealWeightMax: idealWeightMax,
      recommendations: recommendations,
    );
  }

  // Budget Calculator
  static BudgetCalculationResult calculateBudget({
    required double income,
    required Map<String, double> expenses,
  }) {
    final totalExpenses = expenses.values.fold(0.0, (sum, expense) => sum + expense);
    final savings = income - totalExpenses;
    final savingsPercentage = (savings / income) * 100;

    // Calculate expense percentages
    final expensePercentages = <String, double>{};
    for (final entry in expenses.entries) {
      expensePercentages[entry.key] = (entry.value / income) * 100;
    }

    String budgetStatus;
    List<String> recommendations = [];

    if (savings < 0) {
      budgetStatus = 'Over Budget';
      recommendations.addAll([
        'You are spending more than you earn. Review and cut unnecessary expenses.',
        'Consider increasing your income through side hustles or skill development.',
        'Track your daily expenses to identify spending patterns.',
      ]);
    } else if (savingsPercentage < 10) {
      budgetStatus = 'Tight Budget';
      recommendations.addAll([
        'Try to save at least 10-20% of your income for emergencies.',
        'Review your expenses and identify areas where you can cut back.',
        'Consider the 50/30/20 rule: 50% needs, 30% wants, 20% savings.',
      ]);
    } else if (savingsPercentage < 20) {
      budgetStatus = 'Good Budget';
      recommendations.addAll([
        'You\'re on the right track! Try to increase savings to 20% if possible.',
        'Consider investing your savings for long-term wealth building.',
        'Build an emergency fund covering 3-6 months of expenses.',
      ]);
    } else {
      budgetStatus = 'Excellent Budget';
      recommendations.addAll([
        'Great job! You\'re saving a healthy amount.',
        'Consider investing excess savings in mutual funds or stocks.',
        'You might want to increase spending on experiences or skill development.',
      ]);
    }

    return BudgetCalculationResult(
      totalIncome: income,
      totalExpenses: totalExpenses,
      savings: savings,
      savingsPercentage: savingsPercentage,
      expenseBreakdown: expenses,
      expensePercentages: expensePercentages,
      budgetStatus: budgetStatus,
      recommendations: recommendations,
    );
  }

  // EMI Calculator
  static EMICalculationResult calculateEMI({
    required double loanAmount,
    required double interestRate,
    required int tenureMonths,
  }) {
    final monthlyRate = interestRate / 100 / 12;
    
    // EMI formula: P * r * (1 + r)^n / ((1 + r)^n - 1)
    final emi = loanAmount * monthlyRate * pow(1 + monthlyRate, tenureMonths) /
        (pow(1 + monthlyRate, tenureMonths) - 1);
    
    final totalAmount = emi * tenureMonths;
    final totalInterest = totalAmount - loanAmount;

    // Generate EMI breakdown
    final emiBreakdown = <EMIBreakdown>[];
    double remainingBalance = loanAmount;

    for (int month = 1; month <= tenureMonths; month++) {
      final interestComponent = remainingBalance * monthlyRate;
      final principalComponent = emi - interestComponent;
      remainingBalance -= principalComponent;

      emiBreakdown.add(EMIBreakdown(
        month: month,
        emi: emi,
        principal: principalComponent,
        interest: interestComponent,
        balance: remainingBalance > 0 ? remainingBalance : 0,
      ));
    }

    return EMICalculationResult(
      loanAmount: loanAmount,
      interestRate: interestRate,
      tenure: tenureMonths,
      emi: emi,
      totalInterest: totalInterest,
      totalAmount: totalAmount,
      emiBreakdown: emiBreakdown,
    );
  }

  // Retirement Calculator
  static Map<String, dynamic> calculateRetirement({
    required int currentAge,
    required int retirementAge,
    required double currentSavings,
    required double monthlyContribution,
    required double expectedReturns,
    required double inflationRate,
    required double monthlyExpensesAtRetirement,
  }) {
    final yearsToRetirement = retirementAge - currentAge;
    final monthsToRetirement = yearsToRetirement * 12;
    final monthlyRate = expectedReturns / 100 / 12;
    
    // Future value of current savings
    final futureValueCurrentSavings = currentSavings * pow(1 + expectedReturns / 100, yearsToRetirement);
    
    // Future value of monthly contributions (SIP)
    final futureValueContributions = monthlyContribution * 
        (((pow(1 + monthlyRate, monthsToRetirement) - 1) / monthlyRate) * (1 + monthlyRate));
    
    final totalRetirementCorpus = futureValueCurrentSavings + futureValueContributions;
    
    // Adjust monthly expenses for inflation
    final adjustedMonthlyExpenses = monthlyExpensesAtRetirement * pow(1 + inflationRate / 100, yearsToRetirement);
    final annualExpensesAtRetirement = adjustedMonthlyExpenses * 12;
    
    // Calculate how long the corpus will last (assuming 4% withdrawal rate)
    final yearsCorpusWillLast = totalRetirementCorpus / annualExpensesAtRetirement;
    
    return {
      'totalCorpus': totalRetirementCorpus,
      'futureValueCurrentSavings': futureValueCurrentSavings,
      'futureValueContributions': futureValueContributions,
      'adjustedMonthlyExpenses': adjustedMonthlyExpenses,
      'yearsCorpusWillLast': yearsCorpusWillLast,
      'isCorpusSufficient': yearsCorpusWillLast >= 25, // Assuming 25 years post-retirement
    };
  }

  // Tax Calculator (Simple - Indian Tax Slabs)
  static Map<String, dynamic> calculateTax({
    required double annualIncome,
    required String taxRegime, // 'old' or 'new'
  }) {
    double tax = 0;
    double cess = 0;
    
    if (taxRegime == 'new') {
      // New Tax Regime (2023-24)
      if (annualIncome <= 300000) {
        tax = 0;
      } else if (annualIncome <= 600000) {
        tax = (annualIncome - 300000) * 0.05;
      } else if (annualIncome <= 900000) {
        tax = 15000 + (annualIncome - 600000) * 0.10;
      } else if (annualIncome <= 1200000) {
        tax = 45000 + (annualIncome - 900000) * 0.15;
      } else if (annualIncome <= 1500000) {
        tax = 90000 + (annualIncome - 1200000) * 0.20;
      } else {
        tax = 150000 + (annualIncome - 1500000) * 0.30;
      }
    } else {
      // Old Tax Regime
      if (annualIncome <= 250000) {
        tax = 0;
      } else if (annualIncome <= 500000) {
        tax = (annualIncome - 250000) * 0.05;
      } else if (annualIncome <= 1000000) {
        tax = 12500 + (annualIncome - 500000) * 0.20;
      } else {
        tax = 112500 + (annualIncome - 1000000) * 0.30;
      }
    }
    
    // Health and Education Cess (4% of tax)
    cess = tax * 0.04;
    final totalTax = tax + cess;
    final netIncome = annualIncome - totalTax;
    final effectiveRate = (totalTax / annualIncome) * 100;
    
    return {
      'grossIncome': annualIncome,
      'incomeTax': tax,
      'cess': cess,
      'totalTax': totalTax,
      'netIncome': netIncome,
      'effectiveRate': effectiveRate,
      'taxRegime': taxRegime,
    };
  }
}

// Riverpod providers for calculator state management
final sipCalculatorProvider = StateProvider<SIPCalculationResult?>((ref) => null);
final bmiCalculatorProvider = StateProvider<BMICalculationResult?>((ref) => null);
final budgetCalculatorProvider = StateProvider<BudgetCalculationResult?>((ref) => null);
final lumpSumCalculatorProvider = StateProvider<LumpSumCalculationResult?>((ref) => null);
final emiCalculatorProvider = StateProvider<EMICalculationResult?>((ref) => null);