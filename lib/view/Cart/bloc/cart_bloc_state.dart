part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartBlocState {}
abstract class CartActionState extends CartBlocState{}

final class CartBlocInitial extends CartBlocState {}

class CartSuccessState extends CartBlocState{
 List<ProductDataModel>cartItems;

 CartSuccessState({required this.cartItems});
 
}
