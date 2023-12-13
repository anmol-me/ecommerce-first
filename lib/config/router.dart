import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/checkout/checkout_screen.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/screens/product/product_screen.dart';
import 'package:ecommerce_app/screens/splash/splash_screen.dart';
import 'package:ecommerce_app/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../screens/catalog/catalog_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => const MaterialPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/catalog',
      pageBuilder: (context, state) {
        final category = state.extra as Category;
        return MaterialPage(
        child: CatalogScreen(category: category),
      );
      },
    ),
    GoRoute(
      path: '/product',
      pageBuilder: (context, state) {
        final product = state.extra as Product;
        return MaterialPage(
        child: ProductScreen(product: product),
      );
      },
    ),
    GoRoute(
      path: '/wishlist',
      pageBuilder: (context, state) => const MaterialPage(
        child: WishlistScreen(),
      ),
    ),
    GoRoute(
      path: '/cart',
      pageBuilder: (context, state) => const MaterialPage(
        child: CartScreen(),
      ),
    ),
    GoRoute(
      path: '/checkout',
      pageBuilder: (context, state) => const MaterialPage(
        child: CheckoutScreen(),
      ),
    ),
  ],
);
