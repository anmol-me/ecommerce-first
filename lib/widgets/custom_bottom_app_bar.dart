import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.iconColor,
  });

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.home, color: iconColor),
          ),
          IconButton(
            onPressed: () {
              context.push('/cart');
            },
            icon: Icon(Icons.shopping_cart, color: iconColor),
          ),
          IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.person, color: iconColor),
          ),
        ],
      ),
    );
  }
}
