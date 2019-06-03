import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider with ChangeNotifier {
  String _image;
  String _name;

  set image(String image) {
    this._image = _image;
    notifyListeners();
  }

  get image {
    return this._image;
  }

  set name(String name) {
    this._name = name;
    notifyListeners();
  }

  get name {
    return this._name;
  }
}
