import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String code;
  String description;
  String category;
  num price;
  String image;
  String longDescription;
  num rating;

  ProductModel(
      {this.id,
      this.code,
      this.description,
      this.category,
      this.price,
      this.image,
      this.longDescription,
      this.rating});

  factory ProductModel.fromFirestore(
    DocumentSnapshot doc,
  ) {
    Map data = doc.data;
    return ProductModel(
            id: doc.documentID ?? '',
            code: data['code'] ?? '',
            description: data['description'] ?? '',
            category: data['category'] ?? '',
            price: data['price'] ?? 0.0,
            image: data['image'] ?? '',
            longDescription: data['long_description'] ?? '',
            rating: data['rating']) ??
        0.0;
  }
}
