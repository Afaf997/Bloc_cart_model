import 'package:bloc/bloc.dart';
import 'package:cart_project/Data/cart_item.dart';
import 'package:cart_project/Data/grocery_data.dart';
import 'package:cart_project/Data/wishlist_item.dart';
import 'package:cart_project/view/Home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()){
    on<HomeInitialEvent>((event, emit)async {
      emit(HomeLoadingState());
     await Future.delayed(const Duration(seconds: 3));
      emit(HomeLoadedSuccessState(
         products: GroceryData.groceryProducts
        .asMap()
        .entries
        .map((entry) => ProductDataModel(
              id: (entry.key + 1).toString(), // Adding 1 to the index to create an ID
              name: entry.value['name'] ?? '', // Handle missing 'name'
              description: entry.value['description'] ?? '', // Handle missing 'description'
              price: entry.value['price']?.toDouble() ?? 0.0, // Handle missing 'price'
              imageUrl: entry.value['imageUrl'] ?? '', // Handle missing 'imageURL'
            ))
        .toList(),
  ));
      //  e is representing 1 map(id to image)
    });
    on<HomeProductWishlistButtonClickedEvent>((event, emit) {
        wishlistItems.add(event.clickedProduct);
        emit(HomeProductedItemWishlistedActionState());
    });
    on<HomeProductCartButtonClickedEvent>((event, emit) {
      cartItems.add(event.clickedProduct);
       emit(HomeProductedItemCartedActionState());
    });
    on<HomeWishlistButtonNavigateEvent>((event, emit) {
      print("wishlist navigate clicked");
      emit(HomeNavigateToWishlistPageActionState());
    });
    on<HomeCartButtonNavigateEvent>((event, emit) {
      print("cart navigator clicked");
      emit(HomeNavigateToCartPageActionState());
    });
  }
}
