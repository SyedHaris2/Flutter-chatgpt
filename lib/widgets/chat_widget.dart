import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/widgets/text_widget.dart';

import '../constants/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:like_button/like_button.dart';

class ChatWidget extends StatelessWidget {
  final String msg;
  final int chatIndex;
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          //   color: chatIndex == 0 ? const Color(0xff16171B) :  const Color(0xffB785F5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                 // chatIndex == 0 ? 'assets/person.png' : 'assets/chat_logo.png',
                  chatIndex == 0 ? 'assets/person.png' : 'assets/speech.png',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: chatIndex == 0
                        ? TextWidget(label: msg)
                        : DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                repeatForever: false,
                                displayFullTextOnTap: true,
                                totalRepeatCount: 1,
                                animatedTexts: [TyperAnimatedText(msg.trim())]),
                          )),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LikeButton(
                            size: 20,
                             likeCount: Random().nextInt(100),
                            countPostion: CountPostion.bottom,
                            likeBuilder: (isTapped) {
                              return Icon(
                                Icons.thumb_up_outlined,
                                color: isTapped
                                    ? Colors.blue
                                    : Colors.white,
                              );
                            },
                          ),
                        const  SizedBox(
                            width: 5,
                          ),
                           LikeButton(
                            size: 20,
                            likeCount: 0,
                            
                            countPostion: CountPostion.bottom,
                            likeBuilder: (isTapped) {
                              return Icon(
                                Icons.thumb_down_outlined,
                                color: isTapped
                                    ? Colors.blue
                                    : Colors.white,
                              );
                            },
                          ),
                          // Icon(
                          //   Icons.thumb_up_outlined,
                          //   color: Colors.white,
                          // ),
                          // Icon(
                          //   Icons.thumb_down_outlined,
                          //   color: Colors.white,
                          // ),
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
