import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/calculator_service.dart';
import '../utils/app_theme.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Financial Calculators',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.lightMutedForeground,
          indicatorColor: AppTheme.primaryColor,
          isScrollable: true,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'SIP'),
            Tab(text: 'BMI'),
            Tab(text: 'Budget'),
            Tab(text: 'Lump Sum'),
            Tab(text: 'EMI'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SIPCalculatorTab(),
          BMICalculatorTab(),
          BudgetCalculatorTab(),
          LumpSumCalculatorTab(),
          EMICalculatorTab(),
        ],
      ),
    );
  }
}

class SIPCalculatorTab extends ConsumerStatefulWidget {
  const SIPCalculatorTab({super.key});

  @override
  ConsumerState<SIPCalculatorTab> createState() => _SIPCalculatorTabState();
}

class _SIPCalculatorTabState extends ConsumerState<SIPCalculatorTab> {
  final _monthlyInvestmentController = TextEditingController(text: '5000');
  final _expectedReturnsController = TextEditingController(text: '12');
  final _yearsController = TextEditingController(text: '10');

  @override
  void dispose() {
    _monthlyInvestmentController.dispose();
    _expectedReturnsController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _calculateSIP() {
    final monthlyInvestment = double.tryParse(_monthlyInvestmentController.text) ?? 0;
    final expectedReturns = double.tryParse(_expectedReturnsController.text) ?? 0;
    final years = int.tryParse(_yearsController.text) ?? 0;

    if (monthlyInvestment > 0 && expectedReturns > 0 && years > 0) {
      final result = CalculatorService.calculateSIP(
        monthlyInvestment: monthlyInvestment,
        expectedReturns: expectedReturns,
        years: years,
      );
      ref.read(sipCalculatorProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(sipCalculatorProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SIP Calculator',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Calculate returns on your Systematic Investment Plan',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightMutedForeground,
            ),
          ),
          const SizedBox(height: 24),

          // Input fields
          _buildInputField(
            controller: _monthlyInvestmentController,
            label: 'Monthly Investment (₹)',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _expectedReturnsController,
            label: 'Expected Annual Returns (%)',
            hint: 'Enter percentage',
            suffix: '%',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _yearsController,
            label: 'Investment Period (Years)',
            hint: 'Enter years',
            suffix: 'years',
          ),
          const SizedBox(height: 24),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateSIP,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Calculate SIP Returns'),
            ),
          ),
          const SizedBox(height: 24),

          // Results
          if (result != null) ...[
            _buildResultCard(
              title: 'SIP Calculation Results',
              children: [
                _buildResultRow('Monthly Investment', '₹${_formatNumber(result.monthlyInvestment)}'),
                _buildResultRow('Total Investment', '₹${_formatNumber(result.totalInvestment)}'),
                _buildResultRow('Maturity Amount', '₹${_formatNumber(result.maturityAmount)}'),
                _buildResultRow('Wealth Gained', '₹${_formatNumber(result.wealthGained)}', 
                  valueColor: AppTheme.successColor),
                const SizedBox(height: 16),
                _buildChart(result.yearlyBreakdown),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<YearlyBreakdown> breakdown) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Year-wise Growth',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: breakdown.length,
              itemBuilder: (context, index) {
                final year = breakdown[index];
                final maxValue = breakdown.map((e) => e.totalValue).reduce((a, b) => a > b ? a : b);
                final height = (year.totalValue / maxValue) * 120;
                
                return Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: height,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Y${year.year}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 10000000) {
      return '${(number / 10000000).toStringAsFixed(2)} Cr';
    } else if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(2)} L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)} K';
    } else {
      return number.toStringAsFixed(0);
    }
  }
}

class BMICalculatorTab extends ConsumerStatefulWidget {
  const BMICalculatorTab({super.key});

  @override
  ConsumerState<BMICalculatorTab> createState() => _BMICalculatorTabState();
}

class _BMICalculatorTabState extends ConsumerState<BMICalculatorTab> {
  final _weightController = TextEditingController(text: '70');
  final _heightController = TextEditingController(text: '170');

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      final result = CalculatorService.calculateBMI(
        weight: weight,
        height: height,
      );
      ref.read(bmiCalculatorProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(bmiCalculatorProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI Calculator',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Calculate your Body Mass Index and health status',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightMutedForeground,
            ),
          ),
          const SizedBox(height: 24),

          // Input fields
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  controller: _weightController,
                  label: 'Weight (kg)',
                  hint: 'Enter weight',
                  suffix: 'kg',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  controller: _heightController,
                  label: 'Height (cm)',
                  hint: 'Enter height',
                  suffix: 'cm',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.successColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Calculate BMI'),
            ),
          ),
          const SizedBox(height: 24),

          // Results
          if (result != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI Results',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // BMI Value
                    Center(
                      child: Column(
                        children: [
                          Text(
                            result.bmi.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: _getBMIColor(result.category),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            result.category,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: _getBMIColor(result.category),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.lightMutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // BMI Scale
                    _buildBMIScale(result.bmi),
                    const SizedBox(height: 24),
                    
                    _buildResultRow('Health Risk', result.healthRisk),
                    _buildResultRow('Ideal Weight Range', 
                      '${result.idealWeightMin.toStringAsFixed(1)} - ${result.idealWeightMax.toStringAsFixed(1)} kg'),
                    const SizedBox(height: 16),
                    
                    // Recommendations
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recommendations',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result.recommendations,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMIScale(double bmi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BMI Scale',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Colors.blue,    // Underweight
                Colors.green,   // Normal
                Colors.orange,  // Overweight
                Colors.red,     // Obese
              ],
              stops: [0.0, 0.3, 0.6, 1.0],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('18.5', style: Theme.of(context).textTheme.bodySmall),
            Text('25', style: Theme.of(context).textTheme.bodySmall),
            Text('30', style: Theme.of(context).textTheme.bodySmall),
            Text('35+', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Color _getBMIColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return AppTheme.primaryColor;
    }
  }
}

class BudgetCalculatorTab extends ConsumerStatefulWidget {
  const BudgetCalculatorTab({super.key});

  @override
  ConsumerState<BudgetCalculatorTab> createState() => _BudgetCalculatorTabState();
}

class _BudgetCalculatorTabState extends ConsumerState<BudgetCalculatorTab> {
  final _incomeController = TextEditingController(text: '50000');
  final _housingController = TextEditingController(text: '15000');
  final _foodController = TextEditingController(text: '8000');
  final _transportController = TextEditingController(text: '5000');
  final _utilitiesController = TextEditingController(text: '3000');
  final _entertainmentController = TextEditingController(text: '4000');
  final _othersController = TextEditingController(text: '2000');

  @override
  void dispose() {
    _incomeController.dispose();
    _housingController.dispose();
    _foodController.dispose();
    _transportController.dispose();
    _utilitiesController.dispose();
    _entertainmentController.dispose();
    _othersController.dispose();
    super.dispose();
  }

  void _calculateBudget() {
    final income = double.tryParse(_incomeController.text) ?? 0;
    final expenses = {
      'Housing': double.tryParse(_housingController.text) ?? 0,
      'Food': double.tryParse(_foodController.text) ?? 0,
      'Transport': double.tryParse(_transportController.text) ?? 0,
      'Utilities': double.tryParse(_utilitiesController.text) ?? 0,
      'Entertainment': double.tryParse(_entertainmentController.text) ?? 0,
      'Others': double.tryParse(_othersController.text) ?? 0,
    };

    if (income > 0) {
      final result = CalculatorService.calculateBudget(
        income: income,
        expenses: expenses,
      );
      ref.read(budgetCalculatorProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(budgetCalculatorProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget Calculator',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your income and expenses to manage your budget',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightMutedForeground,
            ),
          ),
          const SizedBox(height: 24),

          // Income
          _buildInputField(
            controller: _incomeController,
            label: 'Monthly Income (₹)',
            hint: 'Enter income',
            prefix: '₹',
          ),
          const SizedBox(height: 24),

          Text(
            'Monthly Expenses',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Expenses
          _buildInputField(
            controller: _housingController,
            label: 'Housing (Rent/EMI)',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _foodController,
            label: 'Food & Groceries',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _transportController,
            label: 'Transportation',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _utilitiesController,
            label: 'Utilities',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _entertainmentController,
            label: 'Entertainment',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _othersController,
            label: 'Others',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 24),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateBudget,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.warningColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Analyze Budget'),
            ),
          ),
          const SizedBox(height: 24),

          // Results
          if (result != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Analysis',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildResultRow('Total Income', '₹${_formatNumber(result.totalIncome)}'),
                    _buildResultRow('Total Expenses', '₹${_formatNumber(result.totalExpenses)}'),
                    _buildResultRow('Savings', '₹${_formatNumber(result.savings)}', 
                      valueColor: result.savings >= 0 ? AppTheme.successColor : AppTheme.errorColor),
                    _buildResultRow('Savings Rate', '${result.savingsPercentage.toStringAsFixed(1)}%'),
                    const SizedBox(height: 16),
                    
                    // Budget Status
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _getBudgetStatusColor(result.budgetStatus).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getBudgetStatusIcon(result.budgetStatus),
                            color: _getBudgetStatusColor(result.budgetStatus),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            result.budgetStatus,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: _getBudgetStatusColor(result.budgetStatus),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Recommendations
                    Text(
                      'Recommendations',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...result.recommendations.map((rec) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(
                            child: Text(
                              rec,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBudgetStatusColor(String status) {
    switch (status) {
      case 'Over Budget':
        return AppTheme.errorColor;
      case 'Tight Budget':
        return AppTheme.warningColor;
      case 'Good Budget':
        return AppTheme.primaryColor;
      case 'Excellent Budget':
        return AppTheme.successColor;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getBudgetStatusIcon(String status) {
    switch (status) {
      case 'Over Budget':
        return Icons.warning;
      case 'Tight Budget':
        return Icons.info;
      case 'Good Budget':
        return Icons.thumb_up;
      case 'Excellent Budget':
        return Icons.star;
      default:
        return Icons.info;
    }
  }

  String _formatNumber(double number) {
    if (number >= 10000000) {
      return '${(number / 10000000).toStringAsFixed(2)} Cr';
    } else if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(2)} L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)} K';
    } else {
      return number.toStringAsFixed(0);
    }
  }
}

class LumpSumCalculatorTab extends ConsumerStatefulWidget {
  const LumpSumCalculatorTab({super.key});

  @override
  ConsumerState<LumpSumCalculatorTab> createState() => _LumpSumCalculatorTabState();
}

class _LumpSumCalculatorTabState extends ConsumerState<LumpSumCalculatorTab> {
  final _principalController = TextEditingController(text: '100000');
  final _rateController = TextEditingController(text: '12');
  final _yearsController = TextEditingController(text: '5');

  @override
  void dispose() {
    _principalController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _calculateLumpSum() {
    final principal = double.tryParse(_principalController.text) ?? 0;
    final rate = double.tryParse(_rateController.text) ?? 0;
    final years = int.tryParse(_yearsController.text) ?? 0;

    if (principal > 0 && rate > 0 && years > 0) {
      final result = CalculatorService.calculateLumpSum(
        initialInvestment: principal,
        expectedReturns: rate,
        years: years,
      );
      ref.read(lumpSumCalculatorProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(lumpSumCalculatorProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lump Sum Calculator',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Calculate returns on your one-time investment',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightMutedForeground,
            ),
          ),
          const SizedBox(height: 24),

          // Input fields
          _buildInputField(
            controller: _principalController,
            label: 'Investment Amount (₹)',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _rateController,
            label: 'Expected Annual Returns (%)',
            hint: 'Enter percentage',
            suffix: '%',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _yearsController,
            label: 'Investment Period (Years)',
            hint: 'Enter years',
            suffix: 'years',
          ),
          const SizedBox(height: 24),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateLumpSum,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Calculate Returns'),
            ),
          ),
          const SizedBox(height: 24),

          // Results
          if (result != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lump Sum Calculation Results',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildResultRow('Principal Amount', '₹${_formatNumber(result.initialInvestment)}'),
                    _buildResultRow('Maturity Amount', '₹${_formatNumber(result.maturityAmount)}'),
                    _buildResultRow('Total Gains', '₹${_formatNumber(result.wealthGained)}',
                      valueColor: AppTheme.successColor),
                    _buildResultRow('Expected Returns', '${result.expectedReturns.toStringAsFixed(2)}%'),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 10000000) {
      return '${(number / 10000000).toStringAsFixed(2)} Cr';
    } else if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(2)} L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)} K';
    } else {
      return number.toStringAsFixed(0);
    }
  }
}

class EMICalculatorTab extends ConsumerStatefulWidget {
  const EMICalculatorTab({super.key});

  @override
  ConsumerState<EMICalculatorTab> createState() => _EMICalculatorTabState();
}

class _EMICalculatorTabState extends ConsumerState<EMICalculatorTab> {
  final _loanAmountController = TextEditingController(text: '1000000');
  final _interestRateController = TextEditingController(text: '8.5');
  final _tenureController = TextEditingController(text: '20');

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _calculateEMI() {
    final loanAmount = double.tryParse(_loanAmountController.text) ?? 0;
    final interestRate = double.tryParse(_interestRateController.text) ?? 0;
    final tenure = int.tryParse(_tenureController.text) ?? 0;

    if (loanAmount > 0 && interestRate > 0 && tenure > 0) {
      final result = CalculatorService.calculateEMI(
        loanAmount: loanAmount,
        interestRate: interestRate,
        tenureMonths: tenure * 12,
      );
      ref.read(emiCalculatorProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(emiCalculatorProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EMI Calculator',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Calculate your loan EMI and payment schedule',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightMutedForeground,
            ),
          ),
          const SizedBox(height: 24),

          // Input fields
          _buildInputField(
            controller: _loanAmountController,
            label: 'Loan Amount (₹)',
            hint: 'Enter amount',
            prefix: '₹',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _interestRateController,
            label: 'Interest Rate (% per annum)',
            hint: 'Enter rate',
            suffix: '%',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _tenureController,
            label: 'Loan Tenure (Years)',
            hint: 'Enter years',
            suffix: 'years',
          ),
          const SizedBox(height: 24),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateEMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Calculate EMI'),
            ),
          ),
          const SizedBox(height: 24),

          // Results
          if (result != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMI Calculation Results',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildResultRow('Monthly EMI', '₹${_formatNumber(result.emi)}'),
                    _buildResultRow('Principal Amount', '₹${_formatNumber(result.loanAmount)}'),
                    _buildResultRow('Total Interest', '₹${_formatNumber(result.totalInterest)}'),
                    _buildResultRow('Total Amount', '₹${_formatNumber(result.totalAmount)}'),
                    const SizedBox(height: 16),
                    
                    // EMI Breakdown
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Breakdown',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Principal',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.errorColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Interest',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 10000000) {
      return '${(number / 10000000).toStringAsFixed(2)} Cr';
    } else if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(2)} L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)} K';
    } else {
      return number.toStringAsFixed(0);
    }
  }
}