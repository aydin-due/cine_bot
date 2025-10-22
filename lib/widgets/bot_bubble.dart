import 'package:cine_bot/utils/app_theme.dart';
import 'package:cine_bot/utils/constants.dart';
import 'package:cine_bot/widgets/faded_image.dart';
import 'package:cine_bot/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';

class BotBubble extends StatelessWidget {
  final Message? message;
  final String? poster;
  final bool isTyping;
  const BotBubble({super.key, this.message, this.isTyping = false, this.poster});

  @override
  Widget build(BuildContext context) {
    final Radius borderRadus = Radius.circular(12);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/img/bot.png'),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cinebot, style: TextStyle(color: lightGrey)),
              SizedBox(height: 5),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: borderRadus,
                    bottomRight: borderRadus,
                    topRight: borderRadus,
                  ),
                ),
                child: isTyping
                    ? TypingIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message?.text ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                          if (poster != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: FadedImage(image: poster ?? ''),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
