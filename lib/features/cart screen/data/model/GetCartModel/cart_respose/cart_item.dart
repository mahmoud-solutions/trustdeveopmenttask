import 'package:trustdeveopmenttask/features/cart%20screen/data/model/GetCartModel/cart_respose/addon.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/domain/entity/cartItemEntity/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.productId,
    required super.productName,
    required super.productNameEn,
    required super.productNameAr,
    required super.quantity,
    required super.price,
    required super.addonPrice,
    required super.image,
    required super.addons,
    required super.points,
    required super.total,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['product_id'],
        productName: json['product_name'],
        productNameEn: json['product_name_en'],
        productNameAr: json['product_name_ar'],
        quantity: json['quantity'],
        price: json['price'].toString(),
        addonPrice: json['addon_price'],
        image: json['image'],
        addons: (json['addons'] as List<dynamic>?)
                ?.map((e) => AddonByCategoryModel.fromJson(e))
                .toList() ??
            [],
        points: json['points'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'product_name_en': productNameEn,
        'product_name_ar': productNameAr,
        'quantity': quantity,
        'price': price,
        'addon_price': addonPrice,
        'image': image,
        'addons':
            addons.map((e) => (e as AddonByCategoryModel).toJson()).toList(),
        'points': points,
        'total': total,
      };
}
