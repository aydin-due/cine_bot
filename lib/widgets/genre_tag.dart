import 'package:cine_bot/utils/app_theme.dart';
import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  const GenreTag({super.key, required this.genre});
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: lightGrey, width: .5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        genre.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: lightGrey),
      ),
    );
  }
}
