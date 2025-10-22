import 'package:cine_bot/models/cast.dart';
import 'package:cine_bot/widgets/faded_image.dart';
import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  const CastCard({super.key, required this.cast});
  final Cast? cast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          FadedImage(image: cast?.profileImage ?? '', height: 140, width: 100),
          const SizedBox(height: 5),
          Text(
            cast?.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
