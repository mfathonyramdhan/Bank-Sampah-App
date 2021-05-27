import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String image;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final Function onPressed;

  SocialButton({
    this.height = 46,
    this.color,
    this.borderRadius,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Image(
            width: 22,
            height: 22,
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
