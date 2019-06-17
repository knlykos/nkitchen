import 'package:cloud_firestore/cloud_firestore.dart';

import './order_details_model.dart';

class OrderModel {
  String id;
  DateTime orderDate;
  num table;
  List<OrderDetailsModel> orderDetailsModel;

  OrderModel({this.id, this.orderDate, this.table, this.orderDetailsModel});

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return OrderModel(
        id: doc.documentID ?? '',
        orderDate: data['orderDate'] ?? '',
        table: data['table'] ?? 0,
        orderDetailsModel: data['']);
  }
}
