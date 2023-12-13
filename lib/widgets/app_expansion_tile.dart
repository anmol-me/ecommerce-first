import 'package:flutter/material.dart';

class AppExpansionTile extends StatelessWidget {
  final String title;
  final String description;
  final bool isExpanded;

  const AppExpansionTile({
    super.key,
    required this.title,
    required this.description,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.black.withAlpha(40)),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            ListTile(
              title: Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// "The little red fox jumped many times. And I don't know on what charges he was arrested."