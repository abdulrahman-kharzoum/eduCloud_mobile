import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/models/message.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class messageCardWidget extends StatefulWidget {
  const messageCardWidget({super.key, required this.messages});
  final ChatMessage messages;

  @override
  State<messageCardWidget> createState() => _messageCardWidgetState();
}

// ignore: camel_case_types
class _messageCardWidgetState extends State<messageCardWidget> {
  // ignore: deprecated_member_use
  Locale appLocale = window.locale;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return widget.messages.whoSent == '1'
        ? sendShape(mediaQuery: mediaQuery, widget: widget)
        : getShape(mediaQuery: mediaQuery, widget: widget);
  }
}

// ignore: camel_case_types
class sendShape extends StatelessWidget {
  const sendShape({
    super.key,
    required this.mediaQuery,
    required this.widget,
  });

  final Size mediaQuery;
  final messageCardWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(
                  color: const Color.fromARGB(255, 176, 243, 101),
                ),
                borderRadius: context.locale.toString() == 'en'
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )),
            padding: EdgeInsets.all(mediaQuery.width * 0.04),
            margin: EdgeInsets.symmetric(
                vertical: mediaQuery.height * .01,
                horizontal: mediaQuery.width * .04),
            child: Column(
              crossAxisAlignment: context.locale.toString() == 'en'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  widget.messages.text,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                Padding(
                  padding: context.locale.toString() == 'en'
                      ? EdgeInsets.only(right: mediaQuery.width * 0)
                      : EdgeInsets.only(left: mediaQuery.width * 0),
                  child: Text(
                    widget.messages.date,
                    style: const TextStyle(fontSize: 9, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class getShape extends StatelessWidget {
  const getShape({
    super.key,
    required this.mediaQuery,
    required this.widget,
  });

  final Size mediaQuery;
  final messageCardWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 111, 178, 237),
                border: Border.all(
                  color: const Color.fromARGB(255, 76, 125, 198),
                ),
                borderRadius: context.locale.toString() == 'en'
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
            padding: EdgeInsets.all(mediaQuery.width * 0.04),
            margin: EdgeInsets.symmetric(
                vertical: mediaQuery.height * .01,
                horizontal: mediaQuery.width * .04),
            child: Column(
              crossAxisAlignment: context.locale.toString() == 'en'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  widget.messages.text,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
                Padding(
                  padding: context.locale.toString() == 'en'
                      ? EdgeInsets.only(left: mediaQuery.width * 0)
                      : EdgeInsets.only(right: mediaQuery.width * 0),
                  child: Text(
                    widget.messages.date,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 9, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
