// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    Item({
        required this.id,
        required this.encryptedData,
    });

    String id;
    String encryptedData;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        encryptedData: json["encryptedData"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "encryptedData": encryptedData,
    };
}
