import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int? quantity;
  final double widthFactor;
  final double height;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final bool isSummary;
  final Color iconColor;
  final Color fontColor;
  final double leftPosition;

  const ProductCard.catalog({
    super.key,
    required this.product,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 150,
    this.isCatalog = true,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = false,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
    this.leftPosition = 5,
  });

  const ProductCard.wishlist({
    super.key,
    required this.product,
    this.quantity,
    this.widthFactor = 1.1,
    this.height = 150,
    this.isCatalog = false,
    this.isWishlist = true,
    this.isCart = false,
    this.isSummary = false,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
    this.leftPosition = 5,
  });

  const ProductCard.cart({
    super.key,
    required this.product,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = true,
    this.isSummary = false,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
    this.leftPosition = 5,
  });

  const ProductCard.summary({
    super.key,
    required this.product,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = true,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
    this.leftPosition = 5,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double adjWidth = width / widthFactor;

    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist) {
          context.push('/product', extra: product);
        }
      },
      child: isCart || isSummary
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  ProductImage(
                    adjWidth: 100,
                    height: height,
                    product: product,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProductInformation(
                      product: product,
                      fontColor: fontColor,
                      quantity: quantity,
                      isOrderSummary: isSummary ? true : false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ProductActions(
                    product: product,
                    isCatalog: isCatalog,
                    isWishlist: isWishlist,
                    isCart: isCart,
                    iconColor: iconColor,
                    quantity: quantity,
                  )
                ],
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ProductImage(
                  adjWidth: adjWidth,
                  height: height,
                  product: product,
                ),
                ProductBackground(
                  adjWidth: adjWidth,
                  widgets: [
                    ProductInformation(
                      product: product,
                      fontColor: fontColor,
                    ),
                    ProductActions(
                      product: product,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.adjWidth,
    required this.height,
    required this.product,
  });

  final double adjWidth;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adjWidth,
      height: height,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    super.key,
    required this.product,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
  });

  final Product product;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 85,
              child: Text(
                product.name,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: fontColor),
              ),
            ),
            Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: fontColor),
            ),
          ],
        ),
        isOrderSummary
            ? Text(
          'Qty. $quantity',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: fontColor),
        )
            : const SizedBox(),
      ],
    );
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions({
    super.key,
    required this.product,
    required this.isCatalog,
    required this.isWishlist,
    required this.isCart,
    required this.iconColor,
    this.quantity,
  });

  final Product product;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (state is CartLoaded) {
          IconButton addProduct = IconButton(
            icon: Icon(
              Icons.add_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to your Cart!'),
                ),
              );
              context.read<CartBloc>().add(AddProduct(product));
            },
          );

          IconButton removeProduct = IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from your Cart!'),
                ),
              );
              context.read<CartBloc>().add(RemoveProduct(product));
            },
          );

          IconButton removeFromWishlist = IconButton(
            icon: Icon(
              Icons.delete,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from your Wishlist!'),
                ),
              );
              context
                  .read<WishlistBloc>()
                  .add(RemoveProductFromWishlist(product));
            },
          );

          Text productQuantity = Text(
            '$quantity',
            style: Theme.of(context).textTheme.headline4,
          );

          if (isCatalog) {
            return Row(children: [addProduct]);
          } else if (isWishlist) {
            return Row(children: [addProduct, removeFromWishlist]);
          } else if (isCart) {
            return Row(children: [removeProduct, productQuantity, addProduct]);
          } else {
            return const SizedBox();
          }
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}

class ProductBackground extends StatelessWidget {
  const ProductBackground({
    super.key,
    required this.adjWidth,
    required this.widgets,
  });

  final double adjWidth;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adjWidth - 10,
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
      child: Container(
        width: adjWidth - 20,
        height: 70,
        margin: const EdgeInsets.only(bottom: 5),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...widgets],
          ),
        ),
      ),
    );
  }
}
/*
Stack(
        children: [
          SizedBox(
            width: adjWidth,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: leftPosition,
            child: Container(
              width: adjWidth - 5 - leftPosition,
              height: 80,
              decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: adjWidth - 15 - leftPosition,
              height: 70,
              decoration: const BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          '₹ ${product.price * 4.clamp(0, 4)}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                        isWishlist
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
 */
