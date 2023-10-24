import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:xirfadle_app/models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      // _orders.clear();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            serviceId: element.get('serviceId'),
            // phone: element.get('phone'),
            userName: element.get('name'),
            imageUrl: element.get('imageUrl'),
            orderDate: element.get('orderDate'),
          ),
        );
      });
    });
    notifyListeners();
  }
}
