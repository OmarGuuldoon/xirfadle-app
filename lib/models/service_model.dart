import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ServiceModel with ChangeNotifier {
  final String id, title, imageUrl;
  ServiceModel({required this.id, required this.title, required this.imageUrl});
}
