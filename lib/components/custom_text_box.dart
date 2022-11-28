import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String title;
  const CustomTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 10, 50, 30),
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: const TextField(
            decoration: InputDecoration(
                focusColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                )),
            maxLines: 5,
            // maxLines: 0,
          ),
        ),
      ],
    );
  }
}
