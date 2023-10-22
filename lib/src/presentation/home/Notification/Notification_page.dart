import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/presentation/home/Setting/setting_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/providers/notification_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false)
          .changeUnreadNoti(false);
      user = Provider.of<AuthProvider>(context, listen: false).currentUser;
      try{
        Provider.of<NotificationProvider>(context, listen: false)
            .getNotification(user!.id!);
      } catch (e) {
        showCustomSnackBar(readableError(e), context, isError: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "assets/images/Screen.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/logodark.png")),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Text(
                  tr('notification'),
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr('recent'),
                        style: TextStyle(fontSize: 20, color: p4)),
                    Consumer<NotificationProvider>(
                        builder: (context, notificationProvider, _) {
                      return notificationProvider.deleteNotificationLoad
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () async {
                                try {
                                  final deleteMsg = await notificationProvider
                                      .deleteNotification(user!.id!);

                                  if (!mounted) return;
                                  showCustomSnackBar(deleteMsg, context,
                                      isError: false);

                                } catch (e) {
                                  print(e);
                                  showCustomSnackBar(readableError(e), context,
                                      isError: true);
                                }
                              },
                              child: Text(
                                tr('clear_all'),
                                style: TextStyle(color: p1),
                              ),
                            );
                    })
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Expanded(
                  child: Consumer<NotificationProvider>(
                      builder: (context, notificationProvider, _) {
                    return notificationProvider.notificationLoad
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                        itemCount: notificationProvider.notificationList.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/icon/recivmessage.png"),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(notificationProvider
                                                .notificationList[index]
                                                .title ??
                                            ''),
                                        // Text(
                                        //   "Tap to see the message",
                                        //   style: TextStyle(color: Colors.grey),
                                        // )
                                      ],
                                    ),
                                    // const Text(
                                    //   "2m ago",
                                    //   style: TextStyle(color: Colors.grey, fontSize: 10),
                                    // )
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 10,
                                color: Colors.grey,
                              )
                            ],
                          );
                        });
                  }),
                ),
              ]),
        ),
      ]),
    );
  }
}
