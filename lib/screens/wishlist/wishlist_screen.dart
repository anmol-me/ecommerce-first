import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Wishlist'),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.4,
                ),
                itemCount: state.wishlist.products.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: ProductCard.wishlist(
                      product: state.wishlist.products[index],
                      widthFactor: 1.1,
                      leftPosition: 100,
                      isWishlist: true,
                    ),
                  );
                });
          }

          return const Text('Something went wrong');
        },
      ),
    );
  }
}
