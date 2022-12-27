import 'package:flutter/material.dart';

class GreenButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  const GreenButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
   State<GreenButton> createState() => _GreenButtonState();
}


class _GreenButtonState extends State<GreenButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(10, 101, 90, 1),
        foregroundColor: Colors.white,
      ),
      onPressed: widget.onPressed,
      child: Text(widget.title),
    );
  }
}
