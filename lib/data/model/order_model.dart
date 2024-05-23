// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'drugs_model/product.dart';
import 'location_model.dart';
import 'user_model.dart';

enum Status {
  pending('pending'),
  underway('underway'),
  delivered('delivered');

  const Status(this.type);
  final String type;
}

extension ConvertStatus on String {
  Status toEnum() {
    switch (this) {
      case "pending":
        return Status.pending;
      case "underway":
        return Status.underway;
      case "delivered":
        return Status.delivered;

      default:
        return Status.pending;
    }
  }
}

class OrderModel {
  final String? id;
  final UserModel userInfo;
  final LocationModel userLocation;
  final List<Product> listProduct;
  final Status? status;

  OrderModel({
    this.id,
    required this.userInfo,
    required this.userLocation,
    required this.listProduct,
    this.status,
  });

  OrderModel copyWith({
    String? id,
    UserModel? userInfo,
    LocationModel? userLocation,
    List<Product>? listProduct,
    Status? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userInfo: userInfo ?? this.userInfo,
      userLocation: userLocation ?? this.userLocation,
      listProduct: listProduct ?? this.listProduct,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userInfo': userInfo.toMap(),
      'userLocation': userLocation.toMap(),
      'listProduct': listProduct.map((x) => x.toMap()).toList(),
      'status': status?.type,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      userInfo: UserModel.fromMap(map['userInfo'] as Map<String, dynamic>),
      userLocation:
          LocationModel.fromMap(map['userLocation'] as Map<String, dynamic>),
      listProduct: List<Product>.from(
        (map['listProduct'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] != null ? (map['status'] as String).toEnum() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, userInfo: $userInfo, userLocation: $userLocation, listProduct: $listProduct, status: $status)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userInfo == userInfo &&
        other.userLocation == userLocation &&
        listEquals(other.listProduct, listProduct) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userInfo.hashCode ^
        userLocation.hashCode ^
        listProduct.hashCode ^
        status.hashCode;
  }
}
