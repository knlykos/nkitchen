import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  int sequence;

  CategoryModel({this.id, this.name, this.image, this.sequence});

  factory CategoryModel.fromFirestore(
    DocumentSnapshot doc,
  ) {
    Map data = doc.data;
    return CategoryModel(
        id: doc.documentID,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        sequence: data['sequence'] ?? 0);
  }
}
