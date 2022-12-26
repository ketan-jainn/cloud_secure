import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const GreenButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(10, 101, 90, 1),
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
