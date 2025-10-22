import 'package:cine_bot/l10n/app_localizations.dart';
import 'package:cine_bot/utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';

class UserBubble extends StatelessWidget {
  final Message message;
  const UserBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final Radius borderRadius = Radius.circular(12);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(AppLocalizations.of(context)!.me, style: TextStyle(color: lightGrey)),
              SizedBox(height: 5),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: borderRadius,
                    bottomRight: borderRadius,
                    topLeft: borderRadius,
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/img/user.png'),
          ),
        ],
      ),
    );
  }
}
