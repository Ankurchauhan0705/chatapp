import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
      } else if (value == '=') {
        try {
          _input = eval(_input).toString();
        } catch (e) {
          _input = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Text(
                _input,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('C'),
              buildButton('0'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(text),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_input);
          ContextModel cm = ContextModel();
          _input = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          _input = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  double eval(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return 0.0;
    }
  }
}
