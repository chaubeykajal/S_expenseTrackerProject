
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_expense_tracker/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  runApp(ExpenseTrackerApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseTrackerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExpenseTrackerPage extends StatefulWidget {
  @override
  _ExpenseTrackerPageState createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> {
  late TextEditingController _expenseController;
  late TextEditingController _amountController;
  List<String> _expenses = [];
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _expenseController = TextEditingController();
    _amountController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _expenseController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  //this changes
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _expenses = prefs.getStringList('expenses') ?? [];
      _totalAmount = prefs.getDouble('totalAmount') ?? 0.0;
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('expenses', _expenses);
    await prefs.setDouble('totalAmount', _totalAmount);
  }

  void _addExpense() {
    setState(() {
      String newExpense = _expenseController.text;
      String amountText = _amountController.text;
      double amount = double.tryParse(amountText) ?? 0.0;
      if (newExpense.isNotEmpty && amount > 0) {
        _expenses.add('$newExpense          $amount');
        _totalAmount += amount;
        _expenseController.clear();
        _amountController.clear();
        _saveData();
      }
    });
  }

  void _clearExpenses() {
    setState(() {
      _expenses.clear();
      _totalAmount = 0.0;
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                outlinetext("This Month Spend"),
                totalexpencetext('$_totalAmount'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  outlinetext("Add New Expences"),
                ],
              ),
            ),
            TextField(
              controller: _expenseController,
              decoration: const InputDecoration(
                labelText: 'Expense ',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.add_box_rounded,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Amount ',
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.monetization_on,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _addExpense,
                    child: const Text('Add Expense'),
                  ),
                  ElevatedButton(
                    onPressed: _clearExpenses,
                    child: const Text('Clear Expenses'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  outlinetext("This Month Expences"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  return expencecontainer(_expenses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}