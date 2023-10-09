import 'package:cart_project/view/Cart/bloc/cart_bloc_bloc.dart';
import 'package:cart_project/view/Cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBlocBloc cartblocbloc = CartBlocBloc();
  @override
  void initState() {
   cartblocbloc.add(CartInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart Items"),
      ),
      body: BlocConsumer<CartBlocBloc, CartBlocState>(
        bloc: cartblocbloc,
        listener: (context, state) {
         
        },
        listenWhen: (previous, current) => current is CartActionState ,
        buildWhen: (previous, current) => current is !CartActionState,
        builder: (context, state) {
            switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                     blocCart:cartblocbloc,
                        productDataModel: successState.cartItems[index]);
                  });

            default:
          }
          return Container();
        },
      ),
    );
  }
}
