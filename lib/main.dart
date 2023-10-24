import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xirfadle_app/models/service_model.dart';
import 'package:xirfadle_app/providers/cart_provider.dart';
import 'package:xirfadle_app/providers/orders_provider.dart';
import 'package:xirfadle_app/providers/service_provider.dart';
import 'package:xirfadle_app/screens/auth/login.dart';
import 'package:xirfadle_app/screens/btm_bar.dart';
import 'package:xirfadle_app/screens/cart/cart.dart';
import 'package:xirfadle_app/screens/cart/cart_widget.dart';
import 'package:xirfadle_app/screens/cart/empty_cart_widget.dart';
import 'package:xirfadle_app/screens/categories.dart';
import 'package:xirfadle_app/screens/product_details_screen.dart';

void main() {
  //  code kan waxa uu ka dhigaya app ka mid ku shaqeeya potrait mode keliya
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('an Error Occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => ServiceProvider(),
                  child: MyApp(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                  child: MyApp(),
                ),
                ChangeNotifierProvider(
                  create: (_) => OrdersProvider(),
                  child: MyApp(),
                ),
              ],
              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter demo',
                  // home: ProductDetails(),
                  home: bottombarscreen(),
                  // home: LoginPage(),
                  routes: {
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    // CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                  },
                );
              });
        });
  }
}
