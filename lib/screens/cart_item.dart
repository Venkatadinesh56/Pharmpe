import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String imgurl1;
  final String Quantity; // Convert Quantity to String
  final String mrp; // Convert mrp to String

  CartItem({
    required this.name,
    required this.imgurl1,
    required dynamic Quantity,
    required dynamic mrp,
  })  : Quantity = Quantity.toString(),
        mrp = mrp.toString();

  // Factory constructor to handle JSON parsing
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      imgurl1: json['imgurl1'],
      Quantity: json['Quantity'],
      mrp: json['mrp'],
    );
  }
}
