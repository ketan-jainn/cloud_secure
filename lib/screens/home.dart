import 'package:flutter/material.dart';

import '../components/custom_text_box.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0e8778),
        centerTitle: true,
        title: const Text('CLOUD ENCRYPTION DEMO',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      backgroundColor: const Color(0xffb9fff7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Choose Encryption Algorithm: '),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    dropdownColor: Colors.white,
                    onChanged: (value) {},
                    items: const [
                      DropdownMenuItem(
                        child: Text('DES'),
                      ),
                    ],
                    onTap: () {},
                  ),
                ],
              ),
              const CustomTextBox(
                title: 'Enter Plain Text',
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0e8778),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('ENCRYPT')),
              const CustomTextBox(
                title: 'Encrypted Text',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
