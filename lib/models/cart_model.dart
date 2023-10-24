import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  final String id, serviceId;
  CartModel({required this.id, required this.serviceId});
}
