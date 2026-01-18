import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/domain/UseCase/addToCart/add_to_cart_usecase.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/domain/entity/AddToCartEntity/add_to_cart_entity.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/presention/AddToCartCubit/cubit/addto_cart_state.dart';

class AddTOCartCubit extends Cubit<AddToCartState> {
  final AddProductToCartUseCase addToCartUseCase;

  AddTOCartCubit(this.addToCartUseCase) : super(AddToCartInitial());

  Future<void> addToCart(AddToCartEntity entity, String guestId) async {
    emit(AddToCartLoading());
    try {
      await addToCartUseCase(entity, guestId);
      emit(AddToCartSuccess());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }
}
