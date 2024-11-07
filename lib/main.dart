import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0"; // Output untuk kalkulator

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        output = "0"; // Clear output
      } else if (buttonText == "=") {
        try {
          output = evaluateExpression(output); // Evaluasi ekspresi
        } catch (e) {
          output = "Error"; // Jika ada kesalahan
        }
      } else {
        // Untuk tombol selain C dan =
        if (output == "0") {
          output = buttonText; // Mengganti angka jika 0
        } else {
          output += buttonText; // Menambah angka atau simbol ke output
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    final parsedExpression = Expression.parse(expression); // Parsing string ke ekspresi
    final evaluator = ExpressionEvaluator(); // Membuat evaluator untuk menghitung ekspresi
    final result = evaluator.eval(parsedExpression, {}); // Evaluasi ekspresi

    return result.toString(); // Kembalikan hasil sebagai string
  }

  // Fungsi untuk membuat tombol kalkulator
  Widget buildButton(String buttonText, Color color, {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText), // Tombol di-press
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 40.0, bottom: 24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("AC",Colors.grey.shade400),
                  buildButton("+/-",Colors.grey.shade400),
                  buildButton("%",Colors.grey.shade400),
                  buildButton("÷",Colors.orange.shade600),
                ],
              ),
              Row(
                children: [
                  buildButton("7",Colors.grey.shade600),
                  buildButton("8",Colors.grey.shade600),
                  buildButton("9",Colors.grey.shade600),
                  buildButton("x",Colors.orange.shade600),
                ],
              ),
              Row(
                children: [
                  buildButton("4",Colors.grey.shade600),
                  buildButton("5",Colors.grey.shade600),
                  buildButton("6",Colors.grey.shade600),
                  buildButton("-",Colors.orange.shade600),
                ],
              ),
              Row(
                children: [
                  buildButton("1",Colors.grey.shade600),
                  buildButton("2",Colors.grey.shade600),
                  buildButton("3",Colors.grey.shade600),
                  buildButton("+",Colors.orange.shade600),
                ],
              ),
              Row(
                children: [
                  buildButton("0",Colors.grey.shade600, widthFactor: 2.0),
                  buildButton(".",Colors.grey.shade600),
                  buildButton("=",Colors.orange.shade600),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}