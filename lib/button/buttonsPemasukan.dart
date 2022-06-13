import 'package:flutter/cupertino.dart';

class ButtonsPemasukan extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  ButtonsPemasukan(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor, fontSize: 20),
                ),
              ),
            )),
      ),
    );
  }
}
