import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xirfadle_app/models/service_model.dart';
import 'package:xirfadle_app/providers/service_provider.dart';
import 'package:xirfadle_app/widgets/categories_widget.dart';
import 'package:xirfadle_app/widgets/text_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // List<Map<String, dynamic>> catInfo = [
  //   {
  //     'imgPath': 'assets/images/alxan1.png',
  //     'catText': 'Alxan',
  //   },
  //   {
  //     'imgPath': 'assets/images/carpenter.png',
  //     'catText': 'Faaradle',
  //   },
  //   {
  //     'imgPath': 'assets/images/mini_truck.png',
  //     'catText': 'Xaabsade',
  //   },
  //   {
  //     'imgPath': 'assets/images/nadaafad.png',
  //     'catText': 'Nadaafad',
  //   },
  //   {
  //     'imgPath': 'assets/images/ranjiile.png',
  //     'catText': 'Ranjiile',
  //   },
  //   {
  //     'imgPath': 'assets/images/tuubeyste.png',
  //     'catText': 'Tuubeyste',
  //   },
  // ];

  void initState() {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.fetchService();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    List<ServiceModel> allservices = serviceProvider.getServices;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 5,
        title: TextWidget(
          text: 'Our Services',
          color: Colors.black87,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 225 / 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(allservices.length, (index) {
            return ChangeNotifierProvider.value(
              value: allservices[index],
              child: CategoriesWidget(
                catText: allservices[index].title,
                image: allservices[index].imageUrl,
                color: Colors.black87,
              ),
            );
          }),
        ),
      ),
    );
  }
}
