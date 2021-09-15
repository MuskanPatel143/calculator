import 'package:calculat/widgets/CalcButton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalcApp());
}

bool dark = true;
bool textchange = true;

class CalcApp extends StatefulWidget {
  @override
  _CalcAppState createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String input = '';
  String _history = '';
  String _expression = '';
  String _history1 = '';
  String _expression1 = '';
  int bgcolor = 0x4DFFFFFF;
  int txcolor = 0xB3FFFFFF;
  int ntcolor = 0xB3FFFFFF;
  int ncolor = 0xFF212121;
  int icolor = 0xffffffff;
  int contcolor = 0xFF757575;
  int calcolor = 0xffffffff;
  int caltcolor = 0xFF26A69A;
  int mcolor = 0xffffffff;

  void zero(String text) {
    if (text == '0') {
      if (_expression == text) {
        _expression = _expression;
      } else if (_expression.contains('=')) {
        setState(() {
          _history1 = _history;
          _expression1 = _expression;
          _history = '';
          _expression = text;
        });
      } else if (_expression == '') {
        setState(() {
          _expression = text;
          textchange = false;
        });
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
    // if ((text == '-' || text == '+') &&
    //     (_history[_history.length - 1] == '-' ||
    //         _history[_history.length - 1] == '+')) {
    // } else {
    if (_expression != '') {
      if (_expression.substring(_expression.length - 1) == '.') {
        _expression = _expression.substring(0, _expression.length - 1);
        setState(() {
          _history += _expression + text;
          _expression = '';
        });
      } else if (_expression.startsWith('=')) {
        setState(() {
          _history1 = _history;
          _expression1 = _expression;
          _expression = _expression.substring(1, _expression.length);
          _history = _expression + text;
          _expression = '';
        });
      } else if ((_history.endsWith('-') ||
              _history.endsWith('+') ||
              _history.endsWith('×') ||
              _history.endsWith('÷') ||
              _history.endsWith('%')) &&
          _expression.startsWith('-')) {
        if (_expression.endsWith('0') ||
            _expression.endsWith('1') ||
            _expression.endsWith('2') ||
            _expression.endsWith('3') ||
            _expression.endsWith('4') ||
            _expression.endsWith('5') ||
            _expression.endsWith('6') ||
            _expression.endsWith('7') ||
            _expression.endsWith('8') ||
            _expression.endsWith('9')) {
          if ((_history.endsWith('-') && _expression.startsWith('-'))) {
            _history = _history.substring(0, _history.length - 1);
            _expression = _expression.replaceAll('-', '+');
            setState(() {
              _history += _expression + text;
              _expression = '';
            });
          } else if ((_history.endsWith('+') && _expression.startsWith('-'))) {
            _history = _history.substring(0, _history.length - 1);
            setState(() {
              _history += _expression + text;
              _expression = '';
            });
          } else if ((_history.endsWith('×') && _expression.startsWith('-'))) {
            setState(() {
              _history += _expression + text;
              _expression = '';
            });
          } else if ((_history.endsWith('÷') && _expression.startsWith('-'))) {
            setState(() {
              _history += _expression + text;
              _expression = '';
            });
          } else if ((_history.endsWith('%') && _expression.startsWith('-'))) {
            setState(() {
              _history += _expression + text;
              _expression = '';
            });
          }
        }
      } else if (_history.startsWith('-')) {
        setState(() {
          _history = _history + _expression + text;
          _expression = '';
        });
      } else if (_expression.contains(RegExp(r'[a-z]'))) {
        _expression = '';
        _history = '';
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
    } else if (_expression == '') {
      setState(() {
        _expression = text;
        textchange = false;
      });
    } else if (_expression.startsWith('0')) {
      if (_expression.startsWith('0.')) {
        setState(() {
          _expression += text;
        });
      } else {
        _expression = _expression.substring(1, _expression.length);
        setState(() {
          _expression += text;
        });
      }
    } else if (_expression.contains('=')) {
      setState(() {
        _history1 = _history;
        _expression1 = _expression;
        _history = '';
        _expression = text;
      });
    } else {
      _expression += text;
    }
    setState(() {
      _history = _history;
      _expression = _expression;
    });
  }

  void changetext(String text) {
    if (_expression != '') {
      setState(() {
        textchange = true;
        _history = '';
        _expression = '';
      });
    } else if (_expression == '' && _history == '') {
      setState(() {
        _history1 = '';
        _expression1 = '';
      });
    } else if (_expression == '') {
      setState(() {
        textchange = true;
        _history = '';
      });
    }
  }

  void clear(String text) {
    // ignore: unnecessary_null_comparison
    if (_expression != null && _expression.length > 0) {
      if (_expression == 'can not divide by 0') {
        _expression = '';
        _history = '';
      } else if (_expression != '') {
        setState(() {
          textchange = false;
          _expression = _expression.substring(0, _expression.length - 1);
        });
        if (_expression == '') {
          setState(() {
            textchange = true;
          });
        }
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
          _history1 = _history;
          _expression1 = _expression;
          _history = '';
          _expression = '-';
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
    } else if (_expression == '') {
      setState(() {
        _expression = '-';
        textchange = false;
      });
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
    if (input.contains('%')) {
      s = s.replaceAll('%', '*0.01*');
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
      _expression = eval.toStringAsFixed(2);
      _expression = '=' + _expression;
    });
    if (_expression == '=Infinity' || _expression.contains('NaN')) {
      _expression = 'can not divide by 0';
    }
    if (_history.contains('--')) {
      _history = _history.replaceAll('--', '+');
    }
    if (_history.contains('+-')) {
      _history = _history.replaceAll('+-', '-');
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
        contcolor = 0xFF757575;
        calcolor = 0xffffffff;
        caltcolor = 0xFF26A69A;
        mcolor = 0xffffffff;
      });
    } else {
      setState(() {
        bgcolor = 0xB3FFFFFF;
        txcolor = 0xFF616161;
        ntcolor = 0xFF9E9E9E;
        ncolor = 0xB3FFFFFF;
        icolor = 0xFF757575;
        contcolor = 0xFFBDBDBD;
        calcolor = 0xFF26A69A;
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
          backgroundColor: dark ? Color(0xFF212121) : Color(0xffffffff),
          body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          child: Image(
                            image: dark
                                ? AssetImage('images/left-alignment-4-128.png')
                                : AssetImage('images/icon1.png'),
                            // color: Color(mcolor),
                          ),
                          // height: 10,
                          // width: 10,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Calculator',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w600,
                            ),
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
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Color(contcolor),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            changetheme();
                            print("change theme called");
                          },
                          icon: Icon(
                            dark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: Color(icolor),
                          )),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 24, bottom: 10),
                            child: Text(
                              _history1,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w300,
                                  color: dark
                                      ? Color(0xFF616161)
                                      : Color(0xFFBDBDBD)),
                            ),
                            alignment: Alignment(1, 1),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 24, bottom: 20),
                            child: Text(
                              _expression1,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w300,
                                color: dark
                                    ? Color(0xFF616161)
                                    : Color(0xFFBDBDBD),
                              ),
                            ),
                            alignment: Alignment(1, 1),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 24, bottom: 10),
                            child: Text(
                              _history,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w300,
                                  color: dark
                                      ? Color(0xFF616161)
                                      : Color(0xFFBDBDBD)),
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
                              // flag.toString()
                              CalcButton(
                                text: textchange ? 'AC' : 'C',
                                textColor: txcolor,
                                fillColor: bgcolor,
                                callback: changetext,
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
                                textColor: 0xFF26A69A,
                                fillColor: 0xFFFFFFFF,
                                callback: opr,
                                textSize: 25,
                              ),
                              CalcButton(
                                text: '÷',
                                textColor: 0xFF26A69A,
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
                                textColor: 0xFF26A69A,
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
                                textColor: 0xFF26A69A,
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
                                textColor: 0xFF26A69A,
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
                                textColor: 0xFF26A69A,
                                fillColor: 0xFFFFFFFF,
                                callback: evaluate,
                                textSize: 35,
                              ),
                            ],
                          ),
                        ]),
                  ),
                ]),
          ),
        ));
  }
}
