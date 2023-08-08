import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String _operation = '';

  void _onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '=') {
      _calculate();
    } else {
      _handleOperationInput(buttonText);
    }
  }

  void _handleOperationInput(String buttonText) {
    setState(() {
      _output = '';
      _operation = buttonText;
    });
  }

  void _calculate() {
    setState(() {
      switch (_operation) {
        case '+':
          _output = 'Result: Addition';
          break;
        case '-':
          _output = 'Result: Subtraction';
          break;
        case '*':
          _output = 'Result: Multiplication';
          break;
        case '/':
          _output = 'Result: Division';
          break;
        default:
          _output = 'Invalid Operation';
          break;
      }
      _operation = '';
    });
  }

  void _clear() {
    setState(() {
      _output = '';
      _operation = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey.keyLabel != null) {
              String keyLabel = event.logicalKey.keyLabel;
              if (keyLabel == 'Enter') keyLabel = '=';
              _onButtonPressed(keyLabel);
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerRight,
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton('+'),
                  _buildButton('-'),
                  _buildButton('*'),
                  _buildButton('/'),
                  _buildButton('C'),
                  _buildButton('='),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow, // Change button background color to yellow
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24, color: Colors.black), // Set text color to black
      ),
    ),
  );
}


}
