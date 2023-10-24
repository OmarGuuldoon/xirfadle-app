import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderModel with ChangeNotifier {
  final String orderId, userId, serviceId, userName, imageUrl;
  final Timestamp orderDate;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.serviceId,
      required this.userName,
      required this.imageUrl,
      // required this.phone,
      required this.orderDate});
}
