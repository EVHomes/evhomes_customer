import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({super.key});

  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  double _loanAmount = 100000;
  double _interestRate = 7.0;
  double _tenureYears = 1; // Changed to years
  double _emi = 0;
  double _totalInterest = 0;
  int _touchedIndex = -1;

  List<Map<String, double>> amortizationSchedule = [];

  late TextEditingController _loanAmountController;
  late TextEditingController _interestRateController;
  late TextEditingController _tenureController;

  @override
  void initState() {
    super.initState();
    _loanAmountController = TextEditingController(text: _loanAmount.toStringAsFixed(0));
    _interestRateController = TextEditingController(text: _interestRate.toStringAsFixed(1));
    _tenureController = TextEditingController(text: _tenureYears.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _calculateEMI() {
    double principal = double.tryParse(_loanAmountController.text) ?? 0;
    double rate = double.tryParse(_interestRateController.text) ?? 0;
    double tenureYears = double.tryParse(_tenureController.text) ?? 0;
    double tenureMonths = tenureYears * 12; // Convert years to months

    if (principal > 0 && rate > 0 && tenureYears > 0) {
      double monthlyInterestRate = rate / 12 / 100;
      _emi = (principal * monthlyInterestRate * pow(1 + monthlyInterestRate, tenureMonths)) /
          (pow(1 + monthlyInterestRate, tenureMonths) - 1);
      double totalAmount = _emi * tenureMonths;
      _totalInterest = totalAmount - principal;

      _calculateAmortizationSchedule(principal, rate, tenureMonths);

      setState(() {});
    } else {
      _emi = 0;
      _totalInterest = 0;
      amortizationSchedule = [];
      setState(() {});
    }
  }

  void _calculateAmortizationSchedule(double principal, double rate, double tenureMonths) {
    amortizationSchedule = [];
    double monthlyInterestRate = rate / 12 / 100;
    double balance = principal;

    for (int month = 1; month <= tenureMonths; month++) {
      double interestPayment = balance * monthlyInterestRate;
      double principalPayment = _emi - interestPayment;
      double closingBalance = balance - principalPayment;

      amortizationSchedule.add({
        'openingBalance': balance,
        'emi': _emi,
        'interest': interestPayment,
        'principal': principalPayment,
        'closingBalance': closingBalance,
      });

      balance = closingBalance;
    }
  }

  List<Map<String, double>> _getYearlySummary() {
    List<Map<String, double>> yearlySummary = [];
    int totalMonths = (_tenureYears * 12).toInt();
    
    for (int year = 1; year <= _tenureYears; year++) {
      double yearInterest = 0;
      double yearPrincipal = 0;
      double yearOpeningBalance = amortizationSchedule.isNotEmpty ? amortizationSchedule[(year - 1) * 12]['openingBalance']! : _loanAmount;

      for (int month = (year - 1) * 12; month < year * 12 && month < totalMonths; month++) {
        yearInterest += amortizationSchedule[month]['interest']!;
        yearPrincipal += amortizationSchedule[month]['principal']!;
      }

      double yearClosingBalance = amortizationSchedule.length > year * 12
          ? amortizationSchedule[year * 12]['closingBalance']!
          : 0;

      yearlySummary.add({
        'year': year.toDouble(),
        'openingBalance': yearOpeningBalance,
        'interest': yearInterest,
        'principal': yearPrincipal,
        'closingBalance': yearClosingBalance,
      });
    }

    return yearlySummary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInputSection('Loan Amount', _loanAmountController, _loanAmount, 50000, 1000000, (value) {
                setState(() {
                  _loanAmount = value;
                });
              }),
              _buildInputSection('Interest Rate', _interestRateController, _interestRate, 7, 15, (value) {
                setState(() {
                  _interestRate = value;
                });
              }),
              _buildInputSection('Loan Tenure (Years)', _tenureController, _tenureYears, 1, 30, (value) {
                setState(() {
                  _tenureYears = value;
                });
              }),

              ElevatedButton(
                onPressed: _calculateEMI,
                child: const Text('Calculate EMI'),
              ),

              if (_emi > 0 && _totalInterest >= 0) ...[
                const SizedBox(height: 16),
                Text('EMI: ₹${_emi.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildInformationCard(),
                const SizedBox(height: 16),

                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse != null && pieTouchResponse.touchedSection != null) {
                              _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            } else {
                              _touchedIndex = -1;
                            }
                          });
                        },
                      ),
                      sections: _buildPieChartSections(),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _buildYearlySummaryTable(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearlySummaryTable() {
    final yearlySummary = _getYearlySummary();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(80),
            1: FixedColumnWidth(80),
            2: FixedColumnWidth(80),
            3: FixedColumnWidth(80),
            4: FixedColumnWidth(80),
          },
          children: [
            TableRow(
              children: [
                _buildTableHeader('Year'),
                _buildTableHeader('Opening Balance'),
                _buildTableHeader('Interest'),
                _buildTableHeader('Principal'),
                _buildTableHeader('Closing Balance'),
              ],
            ),
            for (var row in yearlySummary) TableRow(
              children: [
                _buildTableCell(row['year']!.toStringAsFixed(0)),
                _buildTableCell(row['openingBalance']!.toStringAsFixed(2)),
                _buildTableCell(row['interest']!.toStringAsFixed(2)),
                _buildTableCell(row['principal']!.toStringAsFixed(2)),
                _buildTableCell(row['closingBalance']!.toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 12))),
    );
  }

  Widget _buildInputSection(String title, TextEditingController controller, double value, double min, double max, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              double? newValue = double.tryParse(text);
              if (newValue != null && newValue >= min && newValue <= max) {
                onChanged(newValue);
              } else {
                controller.text = value.toStringAsFixed(0);
              }
            },
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: value.toInt().toString(),
          onChanged: (double newValue) {
            setState(() {
              onChanged(newValue);
              controller.text = newValue.toStringAsFixed(0);
            });
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        value: _loanAmount,
        color: Colors.blueAccent,
        title: 'Principal\n₹${_loanAmount.toInt()}',
        radius: _touchedIndex == 0 ? 100 : 80,
        titleStyle: const TextStyle(fontSize: 14, color: Colors.black),
        titlePositionPercentageOffset: 0.5,
      ),
      PieChartSectionData(
        value: _totalInterest,
        color: const Color.fromARGB(255, 217, 255, 64),
        title: 'Interest\n₹${_totalInterest.toStringAsFixed(0)}',
        radius: _touchedIndex == 1 ? 100 : 80,
        titleStyle: const TextStyle(fontSize: 14, color: Colors.black),
        titlePositionPercentageOffset: 0.5,
      ),
    ];
  }

  Widget _buildInformationCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildInfoRow('Loan Amount', '₹${_loanAmount.toStringAsFixed(0)}'),
            _buildInfoRow('Interest Rate', '${_interestRate.toStringAsFixed(1)}%'),
            _buildInfoRow('Tenure', '${_tenureYears.toStringAsFixed(0)} years'),
            _buildInfoRow('Total Interest', '₹${_totalInterest.toStringAsFixed(0)}'),
            _buildInfoRow('Monthly EMI', '₹${_emi.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
