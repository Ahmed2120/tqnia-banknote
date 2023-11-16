import 'dart:io';

import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/providers/auth_provider.dart';
import '../../../app/providers/chat_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';
import 'widget/chat_service_cont.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  UserModel? user;

  final _msgController = TextEditingController();

  bool _showEmoji = false;

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<ChatProvider>(context, listen: false)
      //     .changeUnreadNoti(false);
      user = Provider.of<AuthProvider>(context, listen: false).currentUser;
      try {
        Provider.of<ChatProvider>(context, listen: false).initialize(user!.id!);
        Provider.of<ChatProvider>(context, listen: false).getMessages();
      } catch (e) {
        showCustomSnackBar(readableError(e), context, isError: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dHeight = MediaQuery.of(context).size.height;
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return WillPopScope(
      onWillPop: (){
        if(_showEmoji){
          setState(() {
            _showEmoji = !_showEmoji;
          });
          return Future.value(false);
        }else{
          return Future.value(true);
        }
      },
      child:  PagesBackground(
        child: Stack(
          children: [
            // Image.asset(
            //   "assets/images/Screen.jpg",
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Center(child: Image.asset("assets/images/logodark.png")),
                  Text(
                    e.tr('chat'),
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  const ChatServicCont(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(child:
                      Consumer<ChatProvider>(builder: (context, chatProvider, _) {
                      if(chatProvider.messageList.isNotEmpty)  {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _scrollToBottom());
                    }
                    return chatProvider.msgLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      controller: _scrollController,
                            itemCount: chatProvider.messageList.length,
                            itemBuilder: (context, index) =>
                                chatProvider.messageList[index].receiver == user?.id
                                    ? receiverContainer(
                                        chatProvider.messageList[index].message!)
                                    : senderContainer(
                                        chatProvider.messageList[index].message!),
                          );
                  })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          onTap: (){
                            _showEmoji = false;
                            setState(() {});
                          },
                          controller: _msgController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.attach_file_outlined,
                              size: 30,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                _showEmoji = true;
                                setState(() {});
                                },
                                child: Image.asset('assets/icon/Emoji.png')),
                            filled: true,
                            fillColor: const Color(0xFFF9F9F9),
                            hintText: e.tr('type_message'),
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Consumer<ChatProvider>(builder: (context, chatProvider, _) {
                        return chatProvider.sendMsgLoading ? CircularProgressIndicator() : InkWell(
                          child: Image.asset('assets/icon/send.png'),
                          onTap: ()
                          async{
                            try{
                                    if (_msgController.text.trim().isNotEmpty) {
                                      final isSuccess = await chatProvider
                                          .sendMessage(_msgController.text);
                                      if (isSuccess) {
                                        _msgController.clear();
                                        if(_showEmoji){
                                          _showEmoji = false;
                                          setState(() {});

                                        }
                                        else{
                                          FocusScope.of(context).unfocus();
                                        }
                                        _scrollToBottom();
                                      }
                                    }
                                  }catch(e){
                              if(!mounted) return;
                              showCustomSnackBar(readableError(e), context, isError: true);
                            }
                                });
                      })
                    ],
                  ),
                  if(_showEmoji) SizedBox(
                    height: dHeight * 0.29,
                    child: EmojiPicker(

                      textEditingController: _msgController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                      config: Config(
                        columns: 7,
                        bgColor: Colors.white,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget senderContainer(String txt) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: Color(0xFF63A987),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(
                  txt,
                  style: const TextStyle(color: Colors.white),
                  textDirection: GlobalMethods.rtlLang(txt)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
          ],
        ),
      ),
    );
  }

  Widget receiverContainer(String txt) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(
                  txt,
                  style: const TextStyle(color: Colors.black),
                  textDirection: GlobalMethods.rtlLang(txt)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
          ],
        ),
      ),
    );
  }
}
