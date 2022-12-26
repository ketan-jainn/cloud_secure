import 'package:cloud_secure/components/green_button.dart';
import 'package:cloud_secure/models/encrypt_data_model.dart';
import 'package:cloud_secure/services/encrypt_data_crud.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:pointycastle/asymmetric/api.dart' as ass;

import '../components/custom_text_box.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final plainTextController = TextEditingController();

  Future<String> encryptData(String plainText) async {
    ass.RSAPrivateKey? privKey =
        await parseKeyFromFile<ass.RSAPrivateKey>('keys/private.pem');

    ass.RSAPublicKey? publicKey =
        await parseKeyFromFile<ass.RSAPublicKey>('keys/public.pem');

    Encrypter encrypter;
    Encrypted encrypted;
    // String decrypted;

    encrypter = Encrypter(
      RSA(
        publicKey: publicKey,
        privateKey: privKey,
        encoding: RSAEncoding.OAEP,
      ),
    );
    encrypted = encrypter.encrypt(plainText);
    // decrypted = encrypter.decrypt(encrypted);

    return encrypted.base64;
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
                    // Item? item;
                    // item!.encryptedData = encryptedData!;
                    String encryptedData =
                        await encryptData(plainTextController.text);
                    Item item = Item(id: '1', encryptedData: encryptedData);
                    EncryptDataServices().sendData(item);
                  },
                ),
                const CustomTextBox(
                  title: 'Encrypted Text Sent: ',
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomTextBox(
                  title: 'Data Received without Decryption: ',
                ),
                const CustomTextBox(
                  title: 'Data Received after Decryption: ',
                ),
                const SizedBox(
                  height: 15,
                ),
                GreenButton(
                  title: 'Get Data',
                  onPressed: () async {
                    Item? item = await EncryptDataServices().getEncryptedData();
                    print(item?.encryptedData.toString());
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
