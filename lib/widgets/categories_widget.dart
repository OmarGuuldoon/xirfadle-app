import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xirfadle_app/components/global_methods.dart';
import 'package:xirfadle_app/providers/service_provider.dart';
import 'package:xirfadle_app/screens/product_details_screen.dart';
import 'package:xirfadle_app/widgets/text_widget.dart';

import '../models/service_model.dart';

class CategoriesWidget extends StatefulWidget {
  CategoriesWidget(
      {Key? key,
      // required this.catText,
      // required this.image,
      required this.color,
      required this.catText,
      required this.image})
      : super(key: key);

  final String catText, image;
  final Color color;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    final serviceModel = Provider.of<ServiceModel>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return InkWell(
      onTap: () {
        // GlobalMethods.navigateTo(
        // //     ctx: context, routeName: ProductDetails.routeName);
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: serviceModel.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.color.withOpacity(0.3), width: 2),
        ),
        child: Column(
          children: [
            Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.fill),
              ),
            ),
            TextWidget(
                text: widget.catText, color: Colors.black87, textSize: 20),
          ],
        ),
      ),
    );
  }
}
