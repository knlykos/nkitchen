import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductsProvider with ChangeNotifier {
  String _id;
  String _code;
  String _description;
  num _price;

  set id(String id) {
    this._id = id;
  }

  set code(String code) {
    this._code = code;
  }

  set description(String description) {
    this._description = description;
  }

  set price(num price) {
    this._price = price;
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
    ChangeNotifier();
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
