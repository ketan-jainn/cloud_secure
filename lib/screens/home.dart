import 'package:cloud_secure/components/green_button.dart';
import 'package:cloud_secure/models/encrypt_data_model.dart';
import 'package:cloud_secure/services/encrypt_data_crud.dart';
import 'package:flutter/material.dart';
import 'package:crypton/crypton.dart';
// ignore: depend_on_referenced_packages

import '../components/custom_text_box.dart';

String? encrypted = "";
String decrypted = "";
RSAKeypair rsaKeypair = RSAKeypair.fromRandom();

class Home extends StatelessWidget {
  Home({super.key});
  final plainTextController = TextEditingController();
  final encryptedTextController = TextEditingController();
  final decryptedTextController = TextEditingController();
  final noDecryptedTextController = TextEditingController();

  Future<String> encryptData(String plainText) async {
    encrypted = rsaKeypair.publicKey.encrypt(plainText);
    return encrypted!;
  }

  Future<String> decryptData(String plainText) async {
    decrypted = rsaKeypair.privateKey.decrypt(plainText);
    return decrypted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(10, 101, 90, 1),
        centerTitle: true,
        title: const Text('CLOUD ENCRYPTION DEMO',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      backgroundColor: const Color.fromRGBO(139, 191, 185, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomTextBox(
                  title: 'Enter Plain Text',
                  textEditingController: plainTextController,
                ),
                const SizedBox(
                  height: 15,
                ),
                GreenButton(
                  title: 'Encrypt Data',
                  onPressed: () async {
                    String encryptedData =
                        await encryptData(plainTextController.text);
                    encryptedTextController.text = encryptedData;
                    Item item = Item(id: '1', encryptedData: encryptedData);
                    EncryptDataServices().sendData(item);
                  },
                ),
                CustomTextBox(
                  title: 'Encrypted Text Sent: ',
                  textEditingController: encryptedTextController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextBox(
                  title: 'Data Received without Decryption: ',
                  textEditingController: noDecryptedTextController,
                ),
                CustomTextBox(
                  title: 'Data Received after Decryption: ',
                  textEditingController: decryptedTextController,
                ),
                const SizedBox(
                  height: 15,
                ),
                GreenButton(
                  title: 'Get Data',
                  onPressed: () async {
                    Item? item = await EncryptDataServices().getEncryptedData();
                    // Cypher Text Received
                    noDecryptedTextController.text = item!.encryptedData;

                    // After Decryption
                    String decryptedData =
                        await decryptData((item.encryptedData).toString());
                    decryptedTextController.text = decryptedData;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
