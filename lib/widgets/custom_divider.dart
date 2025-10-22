import 'package:cine_bot/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 60, color: lightGrey.withValues(alpha: 0.2));
  }
}
