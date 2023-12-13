import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/blocs.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/checkout');
              },
              child: Text(
                'GO TO CHECKOUT',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is CartLoaded) {
            Map cart = state.cart.productQuantity(state.cart.products);

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.cart.freeDeliveryString,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.go('/');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add More Items',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  cart.keys.isEmpty
                      ? const Expanded(
                          child: Center(child: Text('Cart is empty')))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: cart.keys.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard.cart(
                                product: cart.keys.elementAt(index),
                                quantity: cart.values.elementAt(index),
                              );
                            },
                          ),
                        ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: OrderSummary(),
                  ),
                ],
              ),
            );
          }
          return const Text('Something went wrong');
        },
      ),
    );
  }
}
