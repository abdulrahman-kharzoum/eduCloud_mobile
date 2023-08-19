import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

import '../../common_widgets/BackgroundPaint.dart';
import '../../models/message.dart';
import '../../routing/app_router.dart';
import '../../widgets/chat_screen_widgets/center_chat_widget.dart';
import '../../widgets/chat_screen_widgets/message_card_widget.dart';
import '../../widgets/super_header_widget.dart';

// ignore: camel_case_types
class superChatScreen extends StatefulWidget {
  static const String routeName = '/supersugg';

  const superChatScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _superChatScreenState createState() => _superChatScreenState();
}

// ignore: camel_case_types
class _superChatScreenState extends State<superChatScreen>
    with SingleTickerProviderStateMixin {
  // ignore: deprecated_member_use
  Locale appLocale = window.locale;
  final List<dynamic> _messages = [];
  List<String> _messageText = [];
  List<String> _whoSent = [];
  List<String> _dateSent = [];
  Map<String, dynamic> studentData = {};

  final TextEditingController _messageController = TextEditingController();
  late PusherChannelsFlutter pusher;
  late PusherChannel myChannel;
  ScrollController _scrollController = ScrollController();
  late SharedPreferences storage;

  Future<void> getData() async {
    print(Model.StudentId);
  }

  @override
  void initState() {
    super.initState();
    getChatData();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    _initPusher();
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
      await Provider.of<Apis>(context, listen: false).sendComplaintSup(
          message: _message, date: _date, id: Model.StudentId.toString());
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
    pusher.unsubscribe(
        channelName:
            "private-employee-${Apis.supervisorContactsData['employee_id']}");
    _messageController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  Future<void> getChatData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      setState(() {
        for (int i = 0;
            i < Apis.supervisorContactsData['conversations'].length;
            i++) {
          if (Model.StudentId ==
              Apis.supervisorContactsData['conversations'][i]['student_id']) {
            studentData = Apis.supervisorContactsData['conversations'][i];
          }
        }
      });

      await Provider.of<Apis>(context, listen: false)
          .supervisorChat(Model.StudentId.toString());
      print(Apis.supervisorChatData);
      setState(() {
        for (int i = 0; i < Apis.supervisorChatData['data'].length; i++) {
          if (Apis.supervisorChatData['data'][i]['complaint'] == false) {
            _messages.add(
              ChatMessage(
                  Apis.supervisorChatData['data'][i]['body'],
                  '1',
                  Apis.supervisorChatData['data'][i]['date_time']
                      .toString()
                      .substring(0, 10)),
            );
          } else {
            _messages.add(
              ChatMessage(
                  Apis.supervisorChatData['data'][i]['body'],
                  '2',
                  Apis.supervisorChatData['data'][i]['date_time']
                      .toString()
                      .substring(0, 10)),
            );
          }
        }
        print(_messageText);
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
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
              event.eventName == 'new_student_complaint'
                  ? _messages.add(
                      ChatMessage(jsonDecode(event.data)['complaint']['body'],
                          '2', DateFormat.jm().format(DateTime.now())),
                    )
                  : print('hello');
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent + 100);
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
        channelName:
            'private-employee-${Apis.supervisorContactsData['employee_id']}',
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
              print(Model.StudentId);
              print(Apis.supervisorChatData);
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
              Navigator.of(context).pushNamed(AppRouter.supervisorContacts);
            }),
        title: Container(
          margin: context.locale.toString() == 'en'
              ? EdgeInsets.only(
                  left: screenWidth / 100, bottom: screenHight / 100)
              : EdgeInsets.only(
                  right: screenWidth / 100, bottom: screenHight / 100),
          child: supervisorHeaderWidget(
            titleColor: Colors.white,
            StudentName: studentData['full_name'] ?? 'Studetn',
            classGrade: studentData['g_class'] ?? {},
            grade: studentData['grade'] ?? {},
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :
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
                                  padding:
                                      EdgeInsets.only(top: screenHight / 100),
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
