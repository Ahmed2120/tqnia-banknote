import 'package:banknote/src/app/data/models/user_model.dart';
import 'package:banknote/src/app/providers/auth_provider.dart';
import 'package:banknote/src/app/utils/color.dart';
import 'package:banknote/src/presentation/home/Setting/setting_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/data/models/news.dart';
import '../../../app/providers/news_provider.dart';
import '../../../app/providers/notification_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';
import '../../auth/widget/arrow_back_cont.dart';

class NewsPage extends StatefulWidget {
  NewsPage({super.key, this.newsModel});
  NewsModel? newsModel;


  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        if(widget.newsModel != null )_getNews();

      });

  }

  _getNews() async {
    try {
      await context.read<NewsProvider>().getNews();
    } catch (e) {
      showCustomSnackBar(readableError(e), context, isError: true);
    }
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
            height: MediaQuery.of(context).size.height / 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Center(child: Image.asset("assets/images/logo.png")),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  ArrowBackContainer(
                    onpress: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Text(
                      tr('news'),
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Consumer<NewsProvider>(
                    builder: (context, newsProvider, _) {
                      return widget.newsModel == null ? Expanded(
                        child: newsProvider.news_load ? const Center(child: CircularProgressIndicator(),) : ListView(
                          children: [
                            Text(newsProvider.news!.newsTxt??'' ,style: const TextStyle(height: 2.5, color: Colors.white, fontSize: 16))
                          ],
                        ),
                      ) : Expanded(
                        child: ListView(
                          children: [
                            Text(widget.newsModel!.newsTxt??'' ,style: const TextStyle(height: 2.5), textAlign: GlobalMethods.rtlLang(widget.newsModel!.newsTxt??'q' ,)
                                ? TextAlign.end
                                : TextAlign.start,)
                          ],
                        ),
                      );
                    }
                  )
                ]),
          ),
        ]),
      ),
    );
  }
}
