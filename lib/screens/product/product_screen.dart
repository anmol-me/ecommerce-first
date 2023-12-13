import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final header = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white,
        );

    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context
                        .read<WishlistBloc>()
                        .add(AddProductToWishlist(product));

                    const snackBar = SnackBar(
                        content: Text('Product added to your wishlist!'));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Add to cart',
                  style: Theme.of(context).textTheme.labelLarge,
                ))
          ],
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              height: 280,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [
              HeroCarouselCard(product: product),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withAlpha(50),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.bottomCenter,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.black,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: header,
                      ),
                      Text(
                        product.price.toString(),
                        style: header,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppExpansionTile(
            title: 'Product Information',
            description: product.description,
            isExpanded: true,
          ),
          AppExpansionTile(
            title: 'Delivery Information',
            description: product.description,
          ),
        ],
      ),
    );
  }
}
