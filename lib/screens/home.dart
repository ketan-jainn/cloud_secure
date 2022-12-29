import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_secure/components/green_button.dart';
import 'package:cloud_secure/models/encrypt_data_model.dart';
import 'package:cloud_secure/services/encrypt_data_crud.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/custom_text_box.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final plainTextController = TextEditingController();
  final encryptedTextController = TextEditingController();
  final decryptedTextController = TextEditingController();
  final dataFromCloud = TextEditingController();

  Future<String> encryptData(String plainText) async {
    dynamic publicPem = await rootBundle.loadString('assets/public.pem');
    dynamic publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;

    dynamic privatePem = await rootBundle.loadString('assets/private.pem');
    dynamic privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;

    Encrypter encrypter;
    Encrypted encrypted;

    encrypter = Encrypter(
      RSA(
        publicKey: publicKey,
        privateKey: privKey,
        encoding: RSAEncoding.OAEP,
      ),
    );
    encrypted = encrypter.encrypt(plainText);

    return encrypted.base64;
  }

  Future<String> decryptData(String plainText) async {
    dynamic publicPem = await rootBundle.loadString('assets/public.pem');
    dynamic publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;

    dynamic privatePem = await rootBundle.loadString('assets/private.pem');
    dynamic privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;

    Encrypter encrypter;
    String decrypted;

    encrypter = Encrypter(
      RSA(
        publicKey: publicKey,
        privateKey: privKey,
        encoding: RSAEncoding.OAEP,
      ),
    );

    decrypted = encrypter.decrypt(Encrypted.fromBase64(plainText));
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
                    // Item? item;
                    // item!.encryptedData = encryptedData!;

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
                  textEditingController: dataFromCloud,
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
                    dataFromCloud.text = (item?.encryptedData).toString();
                    String decryptedData =
                        await decryptData((item?.encryptedData).toString());
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
