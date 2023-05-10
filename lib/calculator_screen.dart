import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInp = "";
  String result = "0";
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(66, 149, 216, 213),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  userInp,
                  style: const TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  style: const TextStyle(
                      fontSize: 48,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                }),
          ))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () {
        setState(() {
          handleInput(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3)),
          ],
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: getColor(text)),
        )),
      ),
    );
  }

  getColor(String text) {
    if (text == '/' ||
        text == '+' ||
        text == '*' ||
        text == '-' ||
        text == 'C' ||
        text == '(' ||
        text == ')') {
      return Colors.redAccent;
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == 'AC') {
      return Colors.redAccent;
    }
    if (text == '=') {
      return Colors.greenAccent;
    }
    return Colors.deepPurple;
  }

  handleInput(String text) {
    if (text == 'AC') {
      userInp = "";
      result = "0";
      return;
    }
    if (text == 'C') {
      if (userInp.isNotEmpty) {
        userInp = userInp.substring(0, userInp.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == '=') {
      result = calculate();
      if (result.endsWith(".0")) {
        String res = result.replaceAll(".0", "");
        result = res;
        userInp = res;
        return;
      }
    }

    userInp = userInp + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInp);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
