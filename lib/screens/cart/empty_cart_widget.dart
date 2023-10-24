import 'package:flutter/material.dart';
import 'package:xirfadle_app/screens/btm_bar.dart';
import 'package:xirfadle_app/screens/product_details_screen.dart';

import '../../components/global_methods.dart';
import '../../widgets/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText})
      : super(key: key);
  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    final Color color = Colors.black87;
    double _size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: _size * 0.4,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Whoops!',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(text: title, color: Colors.cyan, textSize: 20),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(text: subtitle, color: Colors.cyan, textSize: 20),
                SizedBox(
                  height: _size * 0.1,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: color,
                      ),
                    ),
                    primary: Theme.of(context).colorScheme.secondary,
                    // onPrimary: color,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const bottombarscreen(),
                      ),
                    );
                  },
                  child: TextWidget(
                    text: buttonText,
                    textSize: 20,
                    color: Colors.grey.shade300,
                    isTitle: true,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
