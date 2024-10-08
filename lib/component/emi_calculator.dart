
import 'package:ev_homes_customer/pages/AnimatedGradientScreen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({Key? key}) : super(key: key);

  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> with SingleTickerProviderStateMixin {
  double _loanAmount = 0;
  double _interestRate = 0;
  double _tenureYears = 0;
  double _emi = 0;
  double _totalInterest = 0;

  late TextEditingController _loanAmountController;
  late TextEditingController _interestRateController;
  late TextEditingController _tenureController;

  String? _loanAmountError;
  String? _interestRateError;
  String? _tenureError;

  List<Map<String, double>> amortizationSchedule = [];

  final currencyFormat = NumberFormat("#,##0.00", "en_US");

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loanAmountController = TextEditingController();
    _interestRateController = TextEditingController();
    _tenureController = TextEditingController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _tenureController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateEMI() {
    FocusScope.of(context).unfocus();
    double principal = double.tryParse(_loanAmountController.text) ?? 0;
    double rate = double.tryParse(_interestRateController.text) ?? 0;
    double tenureYears = double.tryParse(_tenureController.text) ?? 0;

    setState(() {
      _loanAmountError = null;
      _interestRateError = null;
      _tenureError = null;
    });

    bool isValid = true;

    if (principal < 50000 || principal > 1000000000) {
      _loanAmountError = 'Enter an amount between ₹50,000 and ₹100,000,000';
      isValid = false;
    }
    if (rate < 7 || rate > 15) {
      _interestRateError = 'Enter a rate between 7% and 15%';
      isValid = false;
    }
    if (tenureYears < 1 || tenureYears > 35) {
      _tenureError = 'Enter a tenure between 1 and 35 years';
      isValid = false;
    }

    if (!isValid) return;

    double tenureMonths = tenureYears * 12;
    double monthlyInterestRate = rate / 12 / 100;
    _emi = (principal * monthlyInterestRate * pow(1 + monthlyInterestRate, tenureMonths)) /
        (pow(1 + monthlyInterestRate, tenureMonths) - 1);
    double totalAmount = _emi * tenureMonths;
    _totalInterest = totalAmount - principal;

    _buildAmortizationSchedule(principal, monthlyInterestRate, tenureMonths);

    setState(() {});
  }

  void _buildAmortizationSchedule(double principal, double monthlyInterestRate, double tenureMonths) {
    amortizationSchedule.clear();
    double remainingPrincipal = principal;

    for (int month = 1; month <= tenureMonths; month++) {
      double interest = remainingPrincipal * monthlyInterestRate;
      double principalPaid = _emi - interest;
      remainingPrincipal -= principalPaid;

      if (month % 12 == 0 || month == tenureMonths) {
        amortizationSchedule.add({
          'year': (month / 12).ceilToDouble(),
          'openingBalance': principal,
          'interest': interest,
          'principal': principalPaid,
          'closingBalance': remainingPrincipal > 0 ? remainingPrincipal : 0,
        });
      }

      principal -= principalPaid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Calculator', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white.withAlpha(120),
        elevation: 0,
      ),
       body: Stack(
        children: [
          AnimatedGradient(),
          SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  SizedBox(height: 24),
                  _buildInputCard(),
                  SizedBox(height: 24),
                  _buildActionButtons(),
                  SizedBox(height: 24),
                  _buildResultsCard(),
                  if (_emi > 0 && _totalInterest >= 0) ...[
                    SizedBox(height: 24),
                    _buildYearlySummaryTable(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withAlpha(120),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.real_estate_agent, size: 32, color: Color(0xFF8554D1)),
            SizedBox(width: 12),
            Expanded(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: Text(
                      'The best way to predict your future is to create it',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF8554D1),fontStyle: FontStyle.italic ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withAlpha(120),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              'Loan Amount (₹)',
              _loanAmountController,
              _loanAmount,
              (value) => setState(() => _loanAmount = value),
              _loanAmountError,
              Icons.money,
            ),
            SizedBox(height: 16),
            _buildInputField(
              'Interest Rate (%)',
              _interestRateController,
              _interestRate,
              (value) => setState(() => _interestRate = value),
              _interestRateError,
              Icons.percent,
            ),
            SizedBox(height: 16),
            _buildInputField(
              'Loan Tenure (Years)',
              _tenureController,
              _tenureYears,
              (value) => setState(() => _tenureYears = value),
              _tenureError,
              Icons.calendar_today,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    double value,
    ValueChanged<double> onChanged,
    String? errorText,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        prefixIcon: Icon(icon, color: Color(0xFF8554D1)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF8554D1), width: 2),
        ),
      ),
      onChanged: (text) {
        final newValue = double.tryParse(text) ?? 0;
        onChanged(newValue);
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: _calculateEMI,
          icon: Icon(Icons.calculate),
          label: Text('Calculate EMI'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withAlpha(120),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _resetFields,
          icon: Icon(Icons.refresh),
          label: Text('Reset'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withAlpha(120),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withAlpha(120),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Loan Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF8554D1)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            _buildPieChartWithLegend(),
            SizedBox(height: 16),
            if (_emi > 0 && _totalInterest >= 0) ...[
              _buildResultItem('Monthly EMI', '₹${currencyFormat.format(_emi)}'),
              _buildResultItem('Total Interest', '₹${currencyFormat.format(_totalInterest)}'),
              _buildResultItem('Total Payment', '₹${currencyFormat.format(_emi * _tenureYears * 12)}'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 16, color: Color(0xFF8554D1))),
        ],
      ),
    );
  }

  Widget _buildPieChartWithLegend() {
    double principal = _emi * _tenureYears * 12 - _totalInterest;
    double totalAmount = principal + _totalInterest;
    double principalPercentage = totalAmount > 0 ? (principal / totalAmount) * 100 : 0;
    double interestPercentage = totalAmount > 0 ? (_totalInterest / totalAmount) * 100 : 0;

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: _buildPieChartSections(),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
            ),
          ),
        ),
        SizedBox(height: 22),
        Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildLegendItem('Principal', Color(0xFFCEA9BC), principalPercentage), // Coral color
    _buildLegendItem('Interest', Color(0xFF0A417A),interestPercentage),   // Teal color
  ],
),

      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, double percentage) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          '$label: ${percentage.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    if (_emi == 0 && _totalInterest == 0) {
      return [
        PieChartSectionData(
          color: Colors.white.withAlpha(120),
          value: 100,
          title: '',
          radius: 80,
          titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ];
    }

    double principal = _emi * _tenureYears * 12 - _totalInterest;
    return [
      PieChartSectionData(
        color: Color(0xFFCEA9BC),
        value: principal,
        title: '',
        radius: 80,
      ),
      PieChartSectionData(
        color: Color(0xFF0A417A),
        value: _totalInterest,
        title: '',
        radius: 80,
      ),
    ];
  }

  Widget _buildYearlySummaryTable() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
       color: Colors.white.withAlpha(120),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Yearly Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8554D1)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.purple.shade100),
                dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                    }
                    return null;
                  },
                ),
                columns: [
                  DataColumn(label: _buildColumnHeader('Year')),
                  DataColumn(label: _buildColumnHeader('Opening\nBalance')),
                  DataColumn(label: _buildColumnHeader('Interest')),
                  DataColumn(label: _buildColumnHeader('Principal')),
                  DataColumn(label: _buildColumnHeader('Closing\nBalance')),
                ],
                rows: amortizationSchedule.map((row) {
                  return DataRow(cells: [
                    DataCell(_buildCellText(row['year']!.toStringAsFixed(0))),
                    DataCell(_buildCellText('₹${currencyFormat.format(row['openingBalance'])}')),
                    DataCell(_buildCellText('₹${currencyFormat.format(row['interest'])}')),
                    DataCell(_buildCellText('₹${currencyFormat.format(row['principal'])}')),
                    DataCell(_buildCellText('₹${currencyFormat.format(row['closingBalance'])}')),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8554D1)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCellText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.black87),
        textAlign: TextAlign.right,
      ),
    );
  }

  void _resetFields() {
    _loanAmountController.clear();
    _interestRateController.clear();
    _tenureController.clear();
    setState(() {
      _emi = 0;
      _totalInterest = 0;
      amortizationSchedule.clear();
    });
  }
}