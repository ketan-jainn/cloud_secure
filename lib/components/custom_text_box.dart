import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String title;
  final TextEditingController? textEditingController;
  const CustomTextBox({
    required this.title,
    Key? key,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Container(
          // margin: const EdgeInsets.fromLTRB(50, 10, 50, 30),
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
            ),
            maxLines: 2,
            // maxLines: 0,
          ),
        ),
      ],
    );
  }
}
