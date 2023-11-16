import 'package:banknote/src/app/data/models/gift.dart';
import 'package:banknote/src/app/providers/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/providers/gift_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';

class GiftsPage extends StatefulWidget {
  const GiftsPage({super.key});


  @override
  State<GiftsPage> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      _getGift();

    });

  }

  _getGift() async {
    try {
      await context.read<GiftProvider>().getGift();
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
                    tr('gifts'),
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Consumer<GiftProvider>(
                    builder: (context, giftProvider, _) {
                      return giftProvider.gift_load ? Center(child: CircularProgressIndicator(),) : Expanded(
                        child: ListView(
                          children: [
                            Text(giftProvider.gift!.giftTxt??'' ,style: const TextStyle(height: 2.5), textAlign: GlobalMethods.rtlLang(giftProvider.gift!.giftTxt??'q' ,)
                            ? TextAlign.end
                            : TextAlign.start )
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
