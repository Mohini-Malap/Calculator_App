import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        _num1 = double.tryParse(_output) ?? 0;
        _operand = buttonText;
        _output = "0";
      } else if (buttonText == "=") {
        _num2 = double.tryParse(_output) ?? 0;

        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error";
            break;
        }
        _operand = "";
      } else if (buttonText == "⌫") {
        if (_output.isNotEmpty && _output != "0") {
          _output = _output.substring(0, _output.length - 1);
          if (_output.isEmpty) _output = "0";
        }
      } else {
        if (_output == "0") _output = "";
        _output += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText, Color color, {Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: Colors.grey[400],
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 26,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🌿 Clean, modern white background
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400, // Elegant teal header
        elevation: 4,
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display section
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(30),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // readable on white
              ),
            ),
          ),
          const Divider(color: Colors.teal, thickness: 1.2),
          const SizedBox(height: 8),
          // Button grid
          Column(
            children: [
              Row(
                children: [
                  _buildButton("C", Colors.redAccent),
                  _buildButton("⌫", Colors.orangeAccent),
                  _buildButton("÷", Colors.teal),
                  _buildButton("×", Colors.teal),
                ],
              ),
              Row(
                children: [
                  _buildButton("7", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("8", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("9", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("-", Colors.teal),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("5", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("6", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("+", Colors.teal),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("2", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("3", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton("=", Colors.green.shade600),
                ],
              ),
              Row(
                children: [
                  _buildButton("0", Colors.grey.shade200, textColor: Colors.black87),
                  _buildButton(".", Colors.grey.shade200, textColor: Colors.black87),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
