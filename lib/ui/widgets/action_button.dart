import 'package:flutter/material.dart';

import '../../shared/font.dart';
import '../../shared/size.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Function onPressed;

  ActionButton({
    this.height = 46,
    this.text = "",
    this.color,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: height,
      child: MaterialButton(
        color: color,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.black.withOpacity(0.4),
        visualDensity: VisualDensity.comfortable,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        child: Text(
          text,
          style: boldCalibriFont.copyWith(
            fontSize: 16,
            color: textColor,
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
