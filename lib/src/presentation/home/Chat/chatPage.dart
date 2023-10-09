import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';

import '../../../app/utils/global_methods.dart';
import 'widget/chat_service_cont.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/Screen.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
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
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              const ChatServicCont(),
              const SizedBox(height: 10,),
              Expanded(child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index)=> senderContainer('Why did the expedition turning around?5:09 Pm'),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.attach_file_outlined,
                          size: 30,
                        ),
                        suffixIcon: Image.asset('assets/icon/Emoji.png'),
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
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  InkWell(child: Image.asset('assets/icon/send.png'))
                ],
              ),
            ],
          ),
        ),
      ],
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
