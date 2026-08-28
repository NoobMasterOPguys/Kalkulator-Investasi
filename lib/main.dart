import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const InvestmentCalculatorApp());
}

class InvestmentCalculatorApp extends StatelessWidget {
  const InvestmentCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Investment Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4FBFC),
      ),
      home: const InvestmentCalculatorPage(),
    );
  }
}

class InvestmentCalculatorPage extends StatefulWidget {
  const InvestmentCalculatorPage({super.key});

  @override
  State<InvestmentCalculatorPage> createState() =>
      _InvestmentCalculatorPageState();
}

class _InvestmentCalculatorPageState
    extends State<InvestmentCalculatorPage> {
  // Controllers for the input fields
  final TextEditingController initialController =
      TextEditingController();

  final TextEditingController monthlyController =
      TextEditingController();

  final TextEditingController interestController =
      TextEditingController();

  final TextEditingController durationController =
      TextEditingController();

  // Result variables
  double? finalAmount;
  double? totalContribution;
  double? profit;

  // Currency formatter
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Convert input into a number
  double? parseNumber(String value) {
    String cleaned = value.trim();

    if (cleaned.isEmpty) {
      return null;
    }

    // Remove spaces and Rp
    cleaned = cleaned
        .replaceAll('Rp', '')
        .replaceAll('rp', '')
        .replaceAll(' ', '');

    // Remove thousand separators
    cleaned = cleaned.replaceAll('.', '');

    // Convert comma decimal separator into dot
    cleaned = cleaned.replaceAll(',', '.');

    return double.tryParse(cleaned);
  }

  // Calculate investment
  void calculateInvestment() {
    final double? initial = parseNumber(initialController.text);
    final double? monthly = parseNumber(monthlyController.text);
    final double? interest = parseNumber(interestController.text);
    final double? years = parseNumber(durationController.text);

    // Validation
    if (initial == null ||
        monthly == null ||
        interest == null ||
        years == null) {
      showError('Semua input harus diisi dengan angka.');
      return;
    }

    if (initial < 0 || monthly < 0 || interest < 0 || years <= 0) {
      showError('Masukkan nilai yang valid dan lebih dari 0.');
      return;
    }

    // Convert annual interest into monthly interest
    final double monthlyRate = interest / 100 / 12;

    // Total number of months
    final int months = (years * 12).round();

    double result;

    // Compound interest calculation
    if (monthlyRate == 0) {
      result = initial + (monthly * months);
    } else {
      final double compoundFactor =
          powValue(1 + monthlyRate, months);

      result = (initial * compoundFactor) +
          (monthly * ((compoundFactor - 1) / monthlyRate));
    }

    final double contributions =
        initial + (monthly * months);

    final double investmentProfit =
        result - contributions;

    // Update the UI
    setState(() {
      finalAmount = result;
      totalContribution = contributions;
      profit = investmentProfit;
    });
  }

  // Power calculation
  double powValue(double base, int exponent) {
    double result = 1;

    for (int i = 0; i < exponent; i++) {
      result *= base;
    }

    return result;
  }

  // Display error message
  void showError(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Reset everything
  void resetCalculator() {
    initialController.clear();
    monthlyController.clear();
    interestController.clear();
    durationController.clear();

    setState(() {
      finalAmount = null;
      totalContribution = null;
      profit = null;
    });
  }

  @override
  void dispose() {
    initialController.dispose();
    monthlyController.dispose();
    interestController.dispose();
    durationController.dispose();

    super.dispose();
  }

  Widget buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool decimal = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        decimal: decimal,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.cyan,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget buildResultRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.cyan.shade700,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator Investasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),

                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.cyan.shade50,
                      child: Icon(
                        Icons.account_balance,
                        size: 42,
                        color: Colors.cyan.shade700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'twelveTech',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Smart Investment Calculator',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Input Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,

                  children: [
                    const Text(
                      'Data Investasi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Initial investment
                    buildInputField(
                      label: 'Modal Awal (Rp)',
                      hint: 'Contoh: 10000000',
                      icon: Icons.account_balance_wallet,
                      controller: initialController,
                    ),

                    const SizedBox(height: 14),

                    // Monthly contribution
                    buildInputField(
                      label:
                          'Tambahan Rutin Bulanan (Rp)',
                      hint: 'Contoh: 500000',
                      icon: Icons.add_circle_outline,
                      controller: monthlyController,
                    ),

                    const SizedBox(height: 14),

                    // Interest and duration
                    Row(
                      children: [
                        Expanded(
                          child: buildInputField(
                            label: 'Bunga / Tahun (%)',
                            hint: 'Contoh: 8',
                            icon: Icons.trending_up,
                            controller: interestController,
                            decimal: true,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: buildInputField(
                            label: 'Durasi (Tahun)',
                            hint: 'Contoh: 5',
                            icon: Icons.timer_outlined,
                            controller: durationController,
                            decimal: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: resetCalculator,
                    icon: const Icon(Icons.refresh),
                    label: const Text('RESET'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      side: const BorderSide(
                        color: Colors.cyan,
                      ),
                      foregroundColor: Colors.cyan.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: calculateInvestment,
                    icon: const Icon(Icons.calculate),
                    label: const Text('HITUNG'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Result
            if (finalAmount != null)
              Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,

                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.analytics_outlined,
                            color: Colors.cyan.shade700,
                          ),

                          const SizedBox(width: 10),

                          const Text(
                            'Hasil Investasi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 25),

                      buildResultRow(
                        'Total Setoran',
                        currencyFormatter.format(
                          totalContribution,
                        ),
                        Icons.savings_outlined,
                      ),

                      buildResultRow(
                        'Keuntungan',
                        currencyFormatter.format(
                          profit,
                        ),
                        Icons.trending_up,
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade50,
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Nilai Akhir Investasi',
                              style: TextStyle(
                                color:
                                    Colors.cyan.shade800,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              currencyFormatter.format(
                                finalAmount,
                              ),
                              style: TextStyle(
                                color:
                                    Colors.cyan.shade900,
                                fontSize: 25,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}