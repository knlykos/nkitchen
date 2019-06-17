import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nkitchen/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  String _id;
  String _code;
  String _description;
  num _price;
  String _image;
  num _rate = 0.0;
  List<ProductsProvider> _productList;
  final Firestore _db = Firestore.instance;
  ProductModel _productModel;

  set productModel(ProductModel productModel) {
    this._productModel = productModel;
    notifyListeners();
  }

  set id(String id) {
    this._id = id;
    notifyListeners();
  }

  set code(String code) {
    this._code = code;
  }

  set description(String description) {
    this._description = description;
    notifyListeners();
  }

  set price(num price) {
    this._price = price;
    notifyListeners();
  }

  set image(String image) {
    this._image = image;
    notifyListeners();
  }

  set rate(num rate) {
    this._rate = rate;
    notifyListeners();
  }

  get id {
    return this._id;
  }

  get code {
    return this._code;
  }

  get description {
    return this._description;
  }

  get price {
    return _price;
  }

  get image {
    return _image;
  }

  num get rate {
    return _rate;
  }

  ProductModel get productModel {
    return _productModel;
  }

  Stream<List<ProductModel>> streamProducts() {
    var ref = this._db.collection('products').orderBy('code');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }

  getProducts() {
    // this._productList = Firestore.instance
    //                 .collection('products')
    //                 .orderBy('code')
    //                 .snapshots();
  }

  Future<void> addProducts({code: String, description: String, price: num}) {
    print(code);
    print(description);
    print(price);
    var id = Firestore.instance.collection('products').document().documentID;

    Firestore.instance.collection('products').document(id);
    Map<String, dynamic> data = {
      'code': code,
      'description': description,
      'price': price
    };
    return Firestore.instance.collection('products').document(id).setData(data);
  }

  setProduct({id: String, code: String, description: String, price: num}) {
    this._id = id;
    this._code = code;
    this._description = description;
    this._price = price;
    notifyListeners();
  }

  Future<void> updateProduct() {
    Map<String, dynamic> data = {
      'code': this._code,
      'description': this._description,
      'price': this._price
    };

    return Firestore.instance
        .collection('products')
        .document(this._id)
        .updateData(data);
  }
}
