import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nkitchen/models/product_model.dart';

class ProductServices {
  final Firestore _db = Firestore.instance;

  Stream<List<ProductModel>> streamProducts() {
    var ref = this._db.collection('products').orderBy('code');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }
}
