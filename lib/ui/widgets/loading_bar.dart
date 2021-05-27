import 'package:flutter/material.dart';

import '../../shared/color.dart';

class LoadingBar extends StatelessWidget {
  final double? size;
  final Color? color;

  LoadingBar({
    this.size = 28,
    this.color = whitePure,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}