import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.push('/wishlist');
          },
          icon: const Icon(Icons.favorite),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
