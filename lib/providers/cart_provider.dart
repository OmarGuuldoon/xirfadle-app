import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:xirfadle_app/components/firebase_constants.dart';
import 'package:xirfadle_app/components/global_methods.dart';
import 'package:xirfadle_app/models/cart_model.dart';
import 'package:flutter_device_identifier/flutter_device_identifier.dart';
import 'package:xirfadle_app/models/service_model.dart';

class CartProvider with ChangeNotifier {
  CartProvider() {}
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItem {
    return _cartItems;
  }

  // void addServiceToCart({
  //   required String serviceId,
  // }) {
  //   _cartItems.putIfAbsent(serviceId,
  //       () => CartModel(id: DateTime.now().toString(), serviceId: serviceId));
  //   notifyListeners();
  // }

  Future<void> removeOneItem(
      {required String serviceId, required String cartId}) async {
    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'serviceId': serviceId,
        }
      ]),
    });
    _cartItems.remove(serviceId);
    await fetchCart();
    print('one item is not removed');
    notifyListeners();
  }

  Future<void> clearOnlineCart() async {
    await userCollection.doc(user!.uid).update({
      'userCart': [],
    });
  }

  final User? user = authInstance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (user == null) {
      return;
    }
    final leng = userDoc.get('userCart').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
        userDoc.get('userCart')[i]['serviceId'],
        () => CartModel(
          id: userDoc.get('userCart')[i]['cartId'],
          serviceId: userDoc.get('userCart')[i]['serviceId'],
        ),
      );
    }
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
