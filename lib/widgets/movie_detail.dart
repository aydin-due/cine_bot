import 'package:cine_bot/utils/app_theme.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: lightGrey),
          ),
          TextSpan(text: value, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
