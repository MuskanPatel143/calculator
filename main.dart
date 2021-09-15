import 'package:calculat/widgets/CalcButton.dart';
import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalcApp());
}

bool dark = true;

class CalcApp extends StatefulWidget {
  @override
  _CalcAppState createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String input = '';
  String _history = '';
  String _expression = '';
  int bgcolor = 0x4DFFFFFF;
  int txcolor = 0xB3FFFFFF;
  int ntcolor = 0xB3FFFFFF;
  int ncolor = 0xFF212121;
  int icolor = 0xffffffff;
  int contcolor = 0xFF616161;
  int calcolor = 0xffffffff;
  int caltcolor = 0xFF00BFA5;
  int mcolor = 0xffffffff;

  void zero(String text) {
    if (text == '0') {
      if (_expression == text) {
        _expression = _expression;
      } else if (_expression.contains('=')) {
        _expression = _expression;
      } else {
        _expression += text;
      }
    }
    setState(() {
      _expression = _expression;
    });
  }

  void dot(String text) {
    if (text == '.') {
      if (_expression.contains(text) ||
          _expression.contains('=') ||
          _expression.endsWith('-')) {
        _expression = _expression;
      } else if (_expression == '') {
        _expression = _expression;
      } else {
        _expression += text;
      }
    }
    setState(() {
      _expression = _expression;
    });
  }

  void opr(String text) {
    // ignore: unnecessary_null_comparison
    if (_expression != '') {
      if (_expression.substring(_expression.length - 1) == '.') {
        _expression = _expression.substring(0, _expression.length - 1);
        setState(() {
          _history += _expression + text;
          _expression = '';
        });
      } else if (_history.endsWith('-') && _expression.startsWith('-')) {
        _history = _history.substring(0, _expression.length - 1);
        _expression = _expression.replaceAll('-', '+');
        setState(() {
          _history += _expression + text;
          _expression = '';
        });
      } else if (_expression.contains(RegExp(r'[a-z]'))) {
        _expression = '';
        _history = '';
      } else if (_expression.startsWith('=')) {
        _expression = _expression.substring(1, _expression.length);
        setState(() {
          _history = _expression + text;
          _expression = '';
        });
      } else if (_history.endsWith('+') ||
          _history.endsWith('-') ||
          _history.endsWith('×') ||
          _history.endsWith('÷') ||
          _history.endsWith('%')) {
        setState(() {
          _history += _expression + text;
          _expression = '';
        });
      } else if (_expression.endsWith('-')) {
        setState(() {
          _expression = _expression;
        });
      } else {
        setState(() {
          _expression += text;
          _history = _expression;
          _expression = "";
        });
      }
    } else {
      if (_history.substring(_history.length - 1) == '+' ||
          _history.substring(_history.length - 1) == '-' ||
          _history.substring(_history.length - 1) == '×' ||
          _history.substring(_history.length - 1) == '÷' ||
          _history.substring(_history.length - 1) == '%') {
        _history = _history.substring(0, _history.length - 1);
        setState(() {
          _history += text;
        });
      }
    }
  }

  void numClick(String text) {
    if (_expression.contains(RegExp(r'[a-z]'))) {
      _expression = text;
      _history = '';
    } else if (_expression.contains('=')) {
      _expression = _expression;
    } else {
      _expression += text;
    }
    setState(() {
      _expression = _expression;
    });
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void clear(String text) {
    // ignore: unnecessary_null_comparison
    if (_expression != null && _expression.length > 0) {
      if (_expression == 'can not divide by 0') {
        _expression = '';
        _history = '';
      } else if (_expression.contains('=')) {
        _expression = _expression;
      } else {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    }
    setState(() {
      _expression = _expression;
    });
  }

  void plus(String text) {
    if (_expression != '') {
      if (_expression.contains('=')) {
        setState(() {
          _expression = _expression;
        });
      } else if (_expression.contains('-')) {
        setState(() {
          _expression = _expression.replaceAll('-', '');
        });
      } else {
        setState(() {
          _expression = '-' + _expression;
        });
      }
    } else {
      setState(() {
        _expression = '-' + _expression;
      });
    }
  }

  void evaluate(String text) {
    String s = '';
    input = _history + _expression;

    s = input;
    if (input.contains('÷')) {
      s = input.replaceAll('÷', '/');
    }
    if (input.contains('×')) {
      s = s.replaceAll('×', '*');
    }
    // print(s);
    // if (s.contains('=')) {
    //   setState(() {
    //     s = _expression;
    //   });
    // }
    // try {
    Parser p = Parser();
    Expression exp = p.parse(s);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      _history += _expression;
      _expression = eval.toString();
      _expression = '=' + _expression;
    });
    if (_history.endsWith('÷0')) {
      _expression = 'can not divide by 0';
    }
    if (_history.contains('--')) {
      _history = _history.replaceAll('--', '+');
    }
    if (_expression.endsWith('.0')) {
      _expression = _expression.replaceAll('.0', '');
    }
    // }
    // catch (e) {
    //   setState(() {
    //     _history = "";
    //     _expression = "not valid";
    //   });
    // }
  }

  void changetheme() {
    dark = !dark;
    if (dark == true) {
      setState(() {
        bgcolor = 0x4DFFFFFF;
        txcolor = 0xB3FFFFFF;
        ntcolor = 0xB3FFFFFF;
        ncolor = 0xFF212121;
        icolor = 0xffffffff;
        contcolor = 0xFF616161;
        calcolor = 0xffffffff;
        caltcolor = 0xFF00BFA5;
        mcolor = 0xffffffff;
      });
    } else {
      setState(() {
        bgcolor = 0xB3FFFFFF;
        txcolor = 0xFF283637;
        ntcolor = 0xFF283637;
        ncolor = 0xB3FFFFFF;
        icolor = 0xFF757575;
        contcolor = 0xFFBDBDBD;
        calcolor = 0xFF00BFA5;
        caltcolor = 0xffffffff;
        mcolor = 0xFF757575;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CALC',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: dark ? Color(0xFF212121) : Color(0xffffffff),
            actions: [
              IconButton(
                  onPressed: () {
                    changetheme();
                    print("change theme called");
                  },
                  icon: Icon(
                    dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    color: Color(icolor),
                  )),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    color: Color(mcolor),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Calculator',
                      style: TextStyle(
                          fontFamily: 'Rubik', fontWeight: FontWeight.w300),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Color(caltcolor),
                      backgroundColor: Color(calcolor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Converter',
                      style: TextStyle(
                          fontFamily: 'Rubik', fontWeight: FontWeight.w300),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Color(contcolor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: dark ? Color(0xFF212121) : Color(0xffffffff),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 24, bottom: 10),
                  child: Text(
                    _history,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w300,
                        color: dark ? Color(0xFF616161) : Color(0xFFBDBDBD)),
                  ),
                  alignment: Alignment(1, 1),
                ),
                Container(
                  padding: EdgeInsets.only(right: 24),
                  child: Text(
                    _expression,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w300,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  ),
                  alignment: Alignment(1, 1),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: 'AC',
                      textColor: txcolor,
                      fillColor: bgcolor,
                      callback: allClear,
                      textSize: 25,
                    ),
                    CalcButton(
                      text: '⌫',
                      textColor: txcolor,
                      fillColor: bgcolor,
                      callback: clear,
                      textSize: 25,
                    ),
                    CalcButton(
                      text: '%',
                      textColor: 0xFF00BFA5,
                      fillColor: 0xFFFFFFFF,
                      callback: opr,
                      textSize: 25,
                    ),
                    CalcButton(
                      text: '÷',
                      textColor: 0xFF00BFA5,
                      fillColor: 0xFFFFFFFF,
                      callback: opr,
                      textSize: 35,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '7',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '8',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '9',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '×',
                      textColor: 0xFF00BFA5,
                      fillColor: 0xFFFFFFFF,
                      callback: opr,
                      textSize: 35,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '4',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '5',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '6',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '-',
                      textColor: 0xFF00BFA5,
                      fillColor: 0xFFFFFFFF,
                      callback: opr,
                      textSize: 40,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '1',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '2',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '3',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '+',
                      textColor: 0xFF00BFA5,
                      fillColor: 0xFFFFFFFF,
                      callback: opr,
                      textSize: 35,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '±',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: plus,
                      textSize: 25,
                    ),
                    CalcButton(
                      text: '0',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: zero,
                    ),
                    CalcButton(
                      text: '.',
                      textColor: ntcolor,
                      fillColor: ncolor,
                      callback: dot,
                    ),
                    CalcButton(
                      text: '=',
                      textColor: 0xFF00BFA5,
                      fillColor: 0xFFFFFFFF,
                      callback: evaluate,
                      textSize: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
