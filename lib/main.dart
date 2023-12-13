import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/config/router.dart';
import 'package:ecommerce_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';

import 'repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishlistEvent())),
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
            LoadCategories(),
          ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
        BlocProvider(
          create: (_) => PaymentBloc()..add(LoadPaymentMethod()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            paymentBloc: context.read<PaymentBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider().theme(),
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
      ),
    );
  }
}
