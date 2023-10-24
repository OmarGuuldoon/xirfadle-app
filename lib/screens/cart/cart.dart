import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:xirfadle_app/components/global_methods.dart';
import 'package:xirfadle_app/providers/cart_provider.dart';
import 'package:xirfadle_app/providers/service_provider.dart';
import 'package:xirfadle_app/screens/cart/cart_widget.dart';
import 'package:xirfadle_app/screens/cart/empty_cart_widget.dart';
import 'package:xirfadle_app/widgets/text_widget.dart';

import '../../components/firebase_constants.dart';
import '../../providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.black87;
    double _size = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList = cartProvider.getCartItem.values.toList();
    return cartItemList.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/cart.png',
            title: 'wax dalab ah ma aadan soo gudbisan',
            subtitle: 'fadlan macmiil soo gudbiso dalab mahadsanid',
            buttonText: 'hadda dalbo ')
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: 'Cart(${cartItemList.length})',
                color: Colors.grey.shade700,
                isTitle: true,
                textSize: 22,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.showdeletedailog(
                        title: 'Ka laabo',
                        subtitle:
                            'Ma hubta in aad ka laabatid dhamaan adeegyada',
                        fct: () async {
                          await cartProvider.clearOnlineCart();
                          cartProvider.clearLocalCart();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _checkout(ctx: context),
                Expanded(
                    child: ListView.builder(
                        itemCount: cartItemList.length,
                        itemBuilder: (
                          ctx,
                          index,
                        ) {
                          return ChangeNotifierProvider.value(
                              value: cartItemList[index], child: CartWidget());
                        })),
              ],
            ),
          );
  }

  Widget _checkout({required BuildContext ctx}) {
    final Color color = Colors.black87;
    double _size = MediaQuery.of(ctx).size.width;
    final cartProvider = Provider.of<CartProvider>(ctx);
    final serviceProvider = Provider.of<ServiceProvider>(ctx);
    final ordersProvider = Provider.of<OrdersProvider>(ctx);
    double total = 0.0;
    cartProvider.getCartItem.forEach((key, value) {
      final getCurrProduct = serviceProvider.FindServiceById(value.serviceId);
    });
    return SizedBox(
      width: double.infinity,
      //height: size.height * 0.1,
      // color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                User? user = authInstance.currentUser;
                final orderId = const Uuid().v4();
                final serviceProvider =
                    Provider.of<ServiceProvider>(ctx, listen: false);

                cartProvider.getCartItem.forEach((key, value) async {
                  final getCurrentservice = serviceProvider.FindServiceById(
                    value.serviceId,
                  );
                  try {
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(orderId)
                        .set({
                      'orderId': orderId,
                      'userId': user!.uid,
                      'serviceId': value.serviceId,
                      'imageUrl': getCurrentservice.imageUrl,
                      // 'phone': user.phoneNumber.toString(),
                      'name': user.displayName,
                      'orderDate': Timestamp.now(),
                    });
                    await cartProvider.clearOnlineCart();
                    cartProvider.clearLocalCart();
                    ordersProvider.fetchOrders();
                    await Fluttertoast.showToast(
                      msg: "Your order has been placed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  } catch (error) {
                    GlobalMethods.errorDialog(
                        subtitle: error.toString(), context: ctx);
                  } finally {}
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: ' Xaqiiji ',
                  textSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
