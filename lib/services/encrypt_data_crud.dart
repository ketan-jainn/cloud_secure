import 'dart:developer';

import 'package:cloud_secure/models/encrypt_data_model.dart';
import 'package:http/http.dart' as http;

class EncryptDataServices {
  Future<Item?> getEncryptedData() async {
    var getURL = Uri.parse(
        "https://lxk58gv3gg.execute-api.us-east-1.amazonaws.com/data/1");
    final response = await http.get(getURL);
    if (response.statusCode == 200) {
      Item item = itemFromJson(response.body);

      return item;
    } else {
      return null;
    }
  }

  void sendData(Item data) async {
    var getURL = Uri.parse(
        "https://lxk58gv3gg.execute-api.us-east-1.amazonaws.com/data");
    var body = itemToJson(data);
    final response = await http.put(
      getURL,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    try {
      if (response.statusCode == 200) {
        itemFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
