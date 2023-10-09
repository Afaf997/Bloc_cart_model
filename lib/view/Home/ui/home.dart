import 'package:cart_project/view/Cart/ui/cart.dart';
import 'package:cart_project/view/Home/bloc/home_bloc_bloc.dart';
import 'package:cart_project/view/Home/ui/product_tile_widget.dart';
import 'package:cart_project/view/Wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
 const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeblocBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBlocBloc homeblocBloc = HomeBlocBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      bloc: homeblocBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const wishlistPage()));
        }else if(state is HomeProductedItemCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Carted")));
        }else if(state is HomeProductedItemWishlistedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Wishlisted")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              backgroundColor: Color.fromARGB(255, 235, 234, 234),
              body: Center(
                child: CircularProgressIndicator(
                ),
              ),
            );

          case HomeLoadedSuccessState:
          final successState=state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                centerTitle: true,
                title: Text("Fruits Market"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeblocBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {
                        homeblocBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.builder(
                itemCount:successState.products.length ,
                itemBuilder: (context,index){
                  return ProductTileWidget(
                    homeBlocBloc: homeblocBloc,
                    productdatamodel:successState.products[index]);
                }),
            );
          case HomeErrorState:
          return const Scaffold(
            body: Center(child: Text("Error")),
          );
          default:
          return const SizedBox();
        }
      },
    );
  }
}
