import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:xirfadle_app/components/firebase_constants.dart';
import 'package:xirfadle_app/components/global_methods.dart';
import 'package:xirfadle_app/models/cart_model.dart';
import 'package:xirfadle_app/models/service_model.dart';
import 'package:xirfadle_app/providers/cart_provider.dart';
import 'package:xirfadle_app/screens/btm_bar.dart';
import 'package:xirfadle_app/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/service_provider.dart';
import '../widgets/textfield_widget.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);
  // final String userId = '';
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

final _UserInfo = GlobalKey<FormState>();

class _ProductDetailsState extends State<ProductDetails> {
  late CartProvider cartProvider;
  @override
  void initState() {
    super.initState();
    // Create an instance of CartProvider using the stored user ID
    // cartProvider = CartProvider(widget.userId);
    // Fetch the user's cart data
  }

  Widget build(BuildContext context) {
    double _size = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    final serviceId = ModalRoute.of(context)!.settings.arguments as String;
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final getCurrentService = ServiceProvider().FindServiceById(serviceId);
    final cartModel = Provider.of<ServiceProvider>(context);

    bool? _isIncart =
        cartProvider.getCartItem.containsKey(getCurrentService.id);
    ServiceModel currentService = serviceProvider.FindServiceById(serviceId);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
                Navigator.canPop(context) ? Navigator.pop(context) : null,
            child: Icon(
              IconlyLight.arrowLeft2,
              color: Colors.black87,
              size: 24,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: FancyShimmerImage(
              imageUrl: '',
              errorWidget: Image.network(getCurrentService.imageUrl),
              boxFit: BoxFit.scaleDown,
              width: _size * 1,
              // height: screenHeight * .4,
            ),
          ),
          TextWidget(
            text: '${getCurrentService.title}',
            color: Colors.grey.shade700,
            textSize: 25,
            isTitle: true,
          ),
          Text(
            'hadda dalbo oo hadda hel!',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          Expanded(
            child: Form(
              key: _UserInfo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _isIncart
                        ? null
                        : () async {
                            final User? user = authInstance.currentUser;
                            if (user == null) {
                              GlobalMethods.errorDialog(
                                  subtitle: 'fadlan isdiwaangeli ',
                                  context: context);
                              return;
                            } else {
                              await GlobalMethods.addToCart(
                                  serviceId: getCurrentService.id,
                                  context: context);
                              await cartProvider.fetchCart();
                            }
                          },
                    child: Container(
                      padding: EdgeInsets.all(25.0),
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: _isIncart ? Colors.green : Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          _isIncart
                              ? 'dalabka waa la gudbiyey '
                              : 'Hadda Dalbo!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
