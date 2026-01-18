import 'package:trustdeveopmenttask/features/cart%20screen/domain/entity/cartResponseEntity/cart_response_entity.dart';

import 'cart_item.dart';

class CartResponseModel extends CartResponseEntity {
  CartResponseModel({
    required super.cartItems,
    required super.totalPrice,
    required super.vat,
    required super.totalPriceWithTax,
    required super.totalItems,
    required super.totalPoints,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        cartItems: (json['cart_items'] as List<dynamic>)
            .map((e) => CartItemModel.fromJson(e))
            .toList(),
        totalPrice: json['total_price'],
        vat: json['VAT'],
        totalPriceWithTax: json['total_price_with_tax'],
        totalItems: json['total_items'],
        totalPoints: json['total_points'],
      );

  Map<String, dynamic> toJson() => {
        'cart_items':
            cartItems.map((e) => (e as CartItemModel).toJson()).toList(),
        'total_price': totalPrice,
        'VAT': vat,
        'total_price_with_tax': totalPriceWithTax,
        'total_items': totalItems,
        'total_points': totalPoints,
      };
}
