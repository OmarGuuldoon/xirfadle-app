import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  List<ServiceModel> get getServices {
    return _services;
  }

  static List<ServiceModel> _services = [];
  ServiceModel FindServiceById(String serviceId) {
    return _services.firstWhere((element) => element.id == serviceId);
  }

  Future<void> fetchService() async {
    await FirebaseFirestore.instance
        .collection('services')
        .get()
        .then((QuerySnapshot ServiceSnapshot) {
      _services = [];
      ServiceSnapshot.docs.forEach((element) {
        _services.insert(
          0,
          ServiceModel(
            id: element.get('id'),
            title: element.get('title'),
            imageUrl: element.get('imageUrl'),
          ),
        );
      });
    });
    notifyListeners();
  }
  // static final List<ServiceModel> _services = [
  //   ServiceModel(id: '1', title: 'Alxan', imageUrl: 'assets/images/alxan1.png'),
  //   ServiceModel(
  //       id: '2', title: 'Faaradle', imageUrl: 'assets/images/carpenter.png'),
  //   ServiceModel(
  //       id: '3', title: 'Xaabsade', imageUrl: 'assets/images/mini_truck.png'),
  //   ServiceModel(
  //       id: '4', title: 'Ranjiile', imageUrl: 'assets/images/ranjiile.png'),
  //   ServiceModel(
  //       id: '5', title: 'Nadaafad', imageUrl: 'assets/images/nadaafad.png'),
  //   ServiceModel(
  //       id: '6', title: 'Tuubeyste', imageUrl: 'assets/images/tuubeyste.png'),
  // ];
}
