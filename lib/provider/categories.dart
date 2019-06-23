import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nkitchen/models/category_model.dart';

class CategoriesProvider with ChangeNotifier {
  final Firestore _db = Firestore.instance;
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

  Stream<List<CategoryModel>> getStreamCategories() {
    var ref = this._db.collection('categories').orderBy('sequence');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => CategoryModel.fromFirestore(doc)).toList());
  }
}
