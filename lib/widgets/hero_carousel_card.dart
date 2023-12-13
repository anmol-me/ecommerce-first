import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';

class HeroCarouselCard extends StatelessWidget {
  final Category? category;
  final Product? product;

  const HeroCarouselCard({
    super.key,
    this.category,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product == null) {
          context.push('/catalog', extra: category);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
        // decoration: const BoxDecoration(color: Colors.amber),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              Image.network(
                product == null ? category!.imageUrl : product!.imageUrl,
                fit: BoxFit.cover,
                width: 1000,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      product == null ? category!.name : '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
