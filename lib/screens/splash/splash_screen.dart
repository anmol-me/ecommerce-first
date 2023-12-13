import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/blocs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 1),
          () => context.go('/'),
    );

    return BlocListener<AuthBloc, AuthState>(
      // listenWhen: (previous, current) => previous.authUser != current.authUser,
      listener: (context, state) {
        print('Splash screen Auth Listener');
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/images/logo.jpg'),
                width: 125,
                height: 125,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                'Zero To Unicorn',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}