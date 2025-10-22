import 'package:flutter/material.dart';

class FadedImage extends StatelessWidget {
  const FadedImage({
    super.key,
    required this.image,
    this.height,
    this.width,
  });

  final String image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/default.jpg'),
              image: NetworkImage(image),
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          );
  }
}
