import 'package:flutter/material.dart';

import '../blocs/blocs.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            children: [
              const Divider(thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUBTOTAL',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      '\$${state.cart.subtotalString}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DELIVERY FEE',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      '\$${state.cart.deliveryFeeString}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    // alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'TOTAL',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '\$${state.cart.totalString}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
