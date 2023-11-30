import 'package:banknote/src/app/data/models/gift.dart';
import 'package:banknote/src/app/data/models/news.dart';
import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/presentation/home/Chat/chatPage.dart';
import 'package:banknote/src/presentation/home/Setting/setting_page.dart';
import 'package:banknote/src/presentation/home/gifts/gifts_page.dart';
import 'package:banknote/src/presentation/home/news/news.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/providers/notification_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';
import '../../auth/widget/arrow_back_cont.dart';

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
      body:  PagesBackground(
        child: Stack(children: [
          // Image.asset(
          //   "assets/images/Screen.jpg",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Center(
                    child: Text(
                      tr('notification'),
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(tr('recent'),
                      Text(tr('recent'),
                          style: TextStyle(fontSize: 22, color: Colors.white)),
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
                                  style: TextStyle(color: p1, fontSize: 16),
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
                            // return Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Image.asset("assets/icon/recivmessage.png"),
                            //           Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Text(notificationProvider
                            //                       .notificationList[index]
                            //                       .title ??
                            //                   ''),
                            //               SizedBox(
                            //                 width: 100,
                            //                 child: Text(
                            //                   notificationProvider
                            //                       .notificationList[index]
                            //                       .body ?? '',
                            //                   style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis, ),
                            //                   textDirection: GlobalMethods.rtlLang(notificationProvider
                            //                       .notificationList[index]
                            //                       .body??'r')
                            //                       ? TextDirection.ltr
                            //                       : TextDirection.ltr,
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //           // const Text(
                            //           //   "2m ago",
                            //           //   style: TextStyle(color: Colors.grey, fontSize: 10),
                            //           // )
                            //         ]),
                            //     const SizedBox(
                            //       height: 10,
                            //     ),
                            //     const Divider(
                            //       height: 10,
                            //       color: Colors.grey,
                            //     )
                            //   ],
                            // );

                            return ListTile(
                              onTap: (){
                                if(notificationProvider.notificationList[index]
                                    .type == 'news'){
                                      GlobalMethods.navigate(
                                          context,
                                          NewsPage(newsModel: NewsModel(newsTxt: notificationProvider.notificationList[index].body),
                                              ));
                                    }
                                else if(notificationProvider.notificationList[index]
                                    .type == 'gifts'){
                                      GlobalMethods.navigate(
                                          context,
                                          GiftsPage(
                                            giftModel: GiftModel(giftTxt: notificationProvider.notificationList[index].body),
                                          ));
                                    }
                                else if(notificationProvider.notificationList[index]
                                    .type == 'message'){
                                      GlobalMethods.navigate(
                                          context,
                                          const ChatPage());
                                    }
                                  },
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(notificationProvider
                                                      .notificationList[index]
                                                      .title ??
                                                  '', textAlign: GlobalMethods.rtlLang(notificationProvider
                                    .notificationList[index]
                                    .title ??
                                    'q')
                                    ? TextAlign.end
                                    : TextAlign.start, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,
                                fontSize: 19),),
                              ),
                              subtitle: Text(notificationProvider
                                  .notificationList[index]
                                  .body ?? '', textAlign: GlobalMethods.rtlLang(notificationProvider
                                  .notificationList[index]
                                  .body ??
                                  'q',)
                                  ? TextAlign.end
                                  : TextAlign.start, style: const TextStyle(overflow: TextOverflow.ellipsis,
                                  color: Colors.white, fontSize: 16),),
                            leading: Image.asset("assets/icon/notification (2).png"),

                            );
                          });
                    }),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
