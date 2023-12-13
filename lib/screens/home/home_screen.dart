import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<String> imageList = [
    //   "https://plus.unsplash.com/premium_photo-1683910767532-3a25b821f7ae?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //   "https://images.unsplash.com/photo-1664462114317-c1a7eead5ea6?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //   "https://images.unsplash.com/photo-1626808642875-0aa545482dfb?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //   "https://plus.unsplash.com/premium_photo-1661849963038-7a735f000ae0?q=80&w=1830&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //   "https://images.unsplash.com/photo-1586810724476-c294fb7ac01b?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    // ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Amazon Forest'),
      bottomNavigationBar: const CustomBottomBar(iconColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      height: 280,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: state.categories.map((e) {
                      return HeroCarouselCard(category: e);
                    }).toList(),
                  );
                } else {
                  return const Text('Something went wrong.');
                }
              },
            ),
            const SectionTitle(title: 'RECOMMENDED'),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.isRecommended)
                        .toList(),
                  );
                } else {
                  return const Text('Something went wrong.');
                }
              },
            ),
            const SectionTitle(title: 'MOST POPULAR'),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.isPopular)
                        .toList(),
                  );
                } else {
                  return const Text('Something went wrong.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
