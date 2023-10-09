import 'package:cart_project/view/Home/bloc/home_bloc_bloc.dart';
import 'package:cart_project/view/Home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productdatamodel;
  final HomeBlocBloc homeBlocBloc;
  const ProductTileWidget({super.key, required this.productdatamodel, required this.homeBlocBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productdatamodel.imageUrl))),
          ),
          const SizedBox(height: 20,),
         Text(
            productdatamodel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productdatamodel.description),const SizedBox(height: 20,),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs. "+productdatamodel.price.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBlocBloc.add(HomeProductWishlistButtonClickedEvent(
                          clickedProduct: productdatamodel,
                        ));
                      },
                      icon: const Icon(Icons.favorite_outline_outlined)),
                  IconButton(
                      onPressed: () {
                        homeBlocBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productdatamodel,
                        ));
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
