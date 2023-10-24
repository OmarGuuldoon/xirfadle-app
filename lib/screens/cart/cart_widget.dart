import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';
import 'package:xirfadle_app/components/global_methods.dart';
import 'package:xirfadle_app/models/cart_model.dart';
import 'package:xirfadle_app/providers/service_provider.dart';
import 'package:xirfadle_app/screens/product_details_screen.dart';
import 'package:xirfadle_app/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../providers/cart_provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    double _size = MediaQuery.of(context).size.width;
    final cartModel = Provider.of<CartModel>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final getCurrentService =
        serviceProvider.FindServiceById(cartModel.serviceId);
    final cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        //   GlobalMethods.navigateTo(
        //       ctx: context, routeName: ProductDetails.routeName);
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.serviceId);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: _size * 0.25,
                    width: _size * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              getCurrentService.imageUrl,
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  TextWidget(
                      text: getCurrentService.title,
                      color: Colors.black87,
                      textSize: 20),
                  IconButton(
                    onPressed: () async {
                      await GlobalMethods.showdeletedailog(
                          title: 'Ka laabo',
                          subtitle: 'Ma hubtaa in aad ka laabatid adeeggan',
                          fct: () async {
                            await cartProvider.removeOneItem(
                                cartId: cartModel.id,
                                serviceId: cartModel.serviceId);
                          },
                          context: context);
                    },
                    icon: Icon(IconlyBold.delete),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
