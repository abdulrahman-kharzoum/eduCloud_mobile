import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/head_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

import '../common_widgets/BackgroundPaint.dart';
import '../models/message.dart';
import '../widgets/chat_screen_widgets/center_chat_widget.dart';
import '../widgets/chat_screen_widgets/message_card_widget.dart';

// ignore: camel_case_types
class SuggestionScreen extends StatefulWidget {
  static const String routeName = '/suggestion-screen';

  const SuggestionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

// ignore: camel_case_types
class _SuggestionScreenState extends State<SuggestionScreen> {
  // ignore: deprecated_member_use
  Locale appLocale = window.locale;
  final List<dynamic> _messages = [];
  List<String> _messageText = [];
  List<String> _whoSent = [];
  List<String> _dateSent = [];

  final TextEditingController _messageController = TextEditingController();
  late PusherChannelsFlutter pusher;
  late PusherChannel myChannel;
  ScrollController _scrollController = ScrollController();
  late SharedPreferences storage;

  @override
  void initState() {
    super.initState();
    loadMessages();
    //to get the end of messages list using controller
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    _initPusher();
  }

  //Load messages from shared preferences and give to messages list to show it
  //Call it in initState
  Future<void> loadMessages() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    setState(() {});
    try {
      List<String> loadedMessagesList =
          await storage.getStringList('messages') ?? [];
      ;
      List<String> loadedDateList = await storage.getStringList('date') ?? [];
      ;
      List<String> loadedWhoSentList =
          await storage.getStringList('whosent') ?? [];
      ;
      print(loadedMessagesList);
      print(loadedDateList);
      print(loadedWhoSentList);
      setState(() {
        _messageText = loadedMessagesList;
        _dateSent = loadedDateList;
        _whoSent = loadedWhoSentList;
        if (_messageText.isNotEmpty)
          // ignore: curly_braces_in_flow_control_structures
          for (int i = 0; i < _messageText.length; i++) {
            _messages
                .add(ChatMessage(_messageText[i], _whoSent[i], _dateSent[i]));
          }
      });
    } catch (e) {
      print(e);
    }
  }

  //Save messageText,date,howSent in shared preferences
  //Call it when press send bottom
  Future<void> saveMessages() async {
    storage = await SharedPreferences.getInstance();
    try {
      print('save');
      await storage.setStringList('messages', _messageText);
      await storage.setStringList('date', _dateSent);
      await storage.setStringList('whosent', _whoSent);
      print('done');
    } catch (e) {
      print(e);
    }
  }

  //Add message to messages list for chat
  //Call it when press send bottom
  Future<void> send(String _message, String _date) async {
    try {
      print(
          '---------------------------------------------------------asdfasdfas');
      await pusher
          .trigger(
            PusherEvent(
                channelName: 'private-student-1',
                eventName: 'client-new-notification',
                data: _date),
          )
          .onError((error, stackTrace) => print(error));
      await Provider.of<Apis>(context, listen: false)
          .sendComplaint(message: _message, date: _date);
      _messageText.add(_message);
      _dateSent.add(_date);
      _whoSent.add('1');
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    pusher.disconnect();
    pusher.unsubscribe(channelName: "private-student-1");
    _messageController.dispose();
    super.dispose();
  }

//Pusher initialization with functions for pusher
  Future<void> _initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
          apiKey: '669937dceb19e6086cd4',
          cluster: 'mt1',
          onConnectionStateChange: onConnectionStateChange,
          onError: onError,
          onSubscriptionSucceeded: onSubscriptionSucceeded,
          onEvent: (event) {
            print(event);
            setState(() {
              _messageText.add(jsonDecode(event.data)['reply']['body']);
              _whoSent.add('2');
              _dateSent.add(DateFormat.jm().format(DateTime.now()));
              event.eventName == 'new_reply'
                  ? _messages.add(
                      ChatMessage(jsonDecode(event.data)['reply']['body'], '2',
                          DateFormat.jm().format(DateTime.now())),
                    )
                  : print('hello');
              saveMessages();
            });
          },
          onSubscriptionError: onSubscriptionError,
          onDecryptionFailure: onDecryptionFailure,
          onMemberAdded: onMemberAdded,
          onMemberRemoved: onMemberRemoved,
          onSubscriptionCount: onSubscriptionCount,
          authEndpoint: "http://127.0.0.1:8000/broadcasting/auth",
          onAuthorizer: onAuthorizer);
      await pusher.subscribe(
        channelName: 'private-student-1',
      );
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  getSignature(String value) {
    var key = utf8.encode('61da591e6d4984e182d4');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "669937dceb19e6086cd4:${getSignature("$socketId:$channelName")}",
    };
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    print(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    print("Me ======: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  Widget build(BuildContext context) {
    @override
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 8),
                    Text('Clear the Chat'),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              storage = await SharedPreferences.getInstance();
              setState(() {
                _messages.clear();
                _messageText.clear();
                _dateSent.clear();
                _whoSent.clear();
              });

              await storage.remove('messages');
              await storage.remove('date');
              await storage.remove('whosent');
              print('clear');
            },
          ),
        ],
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              saveMessages();
              Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
            }),
        title: Container(
          margin: context.locale.toString() == 'en'
              ? EdgeInsets.only(
                  left: screenWidth / 100, bottom: screenHight / 100)
              : EdgeInsets.only(
                  right: screenWidth / 100, bottom: screenHight / 100),
          child: headProfileWidget(
              icon: const Icon(
                CupertinoIcons.person,
                size: 25,
              ),
              circleColor: AppColors.secondaryColor,
              screenHight: screenHight,
              screenWidth: screenWidth,
              nameColor: Colors.white),
        ),
      ),
      body:
          //No need for this future builder
          FutureBuilder(
        builder: (context, snapshot) {
          return Stack(
            children: [
              //custom paint for background
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomPaint(
                      size: Size(
                          screenWidth,
                          (screenWidth * 2.1434668500180276)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: Background(),
                    ),
                  ],
                ),
              ),
              //column show the messages list and text fild
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      builder: (context, snapshot) {
                        if (_messages.isNotEmpty) {
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: _messages.length,
                            padding: EdgeInsets.only(top: screenHight / 100),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return messageCardWidget(
                                  messages: _messages[index]);
                            },
                          );
                        } else {
                          //this show widget if chat messages list is empty
                          return showWidgetCenter(
                              screenHight: screenHight,
                              screenWidth: screenWidth);
                        }
                      },
                    ),
                  ),
                  _chatInput(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

//chat input has text fild and send bottom
//and i use save and send function
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 90),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: '     ${LocaleKeys.typesomething.tr()}    ',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              send(
                _messageController.text,
                DateFormat.jm().format(DateTime.now()),
              );
              if (_messageController.text.isNotEmpty) {
                setState(() {
                  _messages.add(
                    ChatMessage(_messageController.text, '1',
                        DateFormat.jm().format(DateTime.now())),
                  );
                  saveMessages();
                  _messageController.clear();
                });
              }
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent + 100);
            },
            minWidth: 0,
            padding: context.locale.toString() == 'en'
                ? const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10)
                : const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 5),
            shape: const CircleBorder(),
            color: AppColors.mainColor,
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
