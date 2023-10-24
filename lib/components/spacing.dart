import 'package:flutter/material.dart';

class spacing extends StatelessWidget {
  const spacing({Key? key, required this.height}) : super(key: key);
  final height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
