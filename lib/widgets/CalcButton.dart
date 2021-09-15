import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final int textColor;
  final int fillColor;
  final double textSize;
  final Function callback;

  const CalcButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.fillColor,
    required this.callback,
    this.textSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 65,
        height: 65,
        child: TextButton(
          onPressed: () {
            callback(text);
          },
          child: Text(
            text,
            style: TextStyle(
                fontSize: textSize,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w300),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            primary: Color(textColor),
            // ignore: unnecessary_null_comparison
            backgroundColor: fillColor != null ? Color(fillColor) : null,
          ),
        ),
      ),
    );
  }
}
