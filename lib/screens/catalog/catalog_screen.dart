import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  final Category category;

  const CatalogScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();

    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.15,
            ),
            itemCount: categoryProducts.length,
            itemBuilder: (context, index) {
              return ProductCard.catalog(
                product: categoryProducts[index],
                widthFactor: 2.2,
              );
            }),
      ),
    );
  }
}
