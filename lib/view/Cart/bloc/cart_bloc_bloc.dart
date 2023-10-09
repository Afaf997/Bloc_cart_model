import 'package:bloc/bloc.dart';
import 'package:cart_project/Data/cart_item.dart';
import 'package:cart_project/view/Home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBlocBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBlocBloc() : super(CartBlocInitial()) {
    on<CartInitialEvent>((event, emit) {
      emit(CartSuccessState(cartItems:cartItems));
      on<CartRemoveFromCartEvent>((event, emit){
        cartItems.remove(event.productDataModel);
        emit(CartSuccessState(cartItems: cartItems));
      } );
    });
  }
}
