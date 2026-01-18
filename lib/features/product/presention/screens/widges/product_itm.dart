import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trustdeveopmenttask/core/routing/app_router.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/data/repo/cart_repo_implimition.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/domain/entity/AddToCartEntity/add_to_cart_entity.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/presention/AddToCartCubit/cubit/addto_cart_cubit.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/presention/AddToCartCubit/cubit/addto_cart_state.dart';
import 'package:trustdeveopmenttask/features/product/domain/entity/product_entities.dart';
import 'package:trustdeveopmenttask/features/product/presention/cubit/gest_cubit.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;
  final String? image;
  final ProductEntity productEntity;

  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    this.image,
    required this.productEntity,
  });

  void _addToCart(BuildContext context) {
    final guestId = context.read<GuestIdCubit>().guestId;

    if (guestId == null || guestId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('جاري تحميل معلومات الجلسة...')),
      );
      context.read<GuestIdCubit>().loadGuestId();
      return;
    }

    final addToCartEntity = AddToCartEntity(
      productId: productEntity.id,
      quantity: 1,
      addons: null,
    );

    context.read<AddTOCartCubit>().addToCart(addToCartEntity, guestId);
  }

  @override
  Widget build(BuildContext context) {
    const fallbackImage = 'https://via.placeholder.com/80';

    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        AppRouter.prodactDetailsScreen,
        extra: productEntity,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            BlocConsumer<AddTOCartCubit, AddToCartState>(
              listener: (context, state) {
                if (state is AddToCartSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تمت الإضافة للسلة بنجاح ✓'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is AddToCartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('خطأ: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: state is AddToCartLoading
                      ? null
                      : () => _addToCart(context),
                  icon: state is AddToCartLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$price جنيه',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image != null && image!.isNotEmpty ? image! : fallbackImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network(
                  fallbackImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
