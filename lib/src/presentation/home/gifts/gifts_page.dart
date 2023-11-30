import 'package:banknote/src/app/data/models/gift.dart';
import 'package:banknote/src/app/providers/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/data/dio/exception/dio_error_extention.dart';
import '../../../app/providers/gift_provider.dart';
import '../../../app/utils/global_methods.dart';
import '../../../app/widgets/custom_snackbar.dart';
import '../../../app/widgets/pages_background.dart';
import '../../auth/widget/arrow_back_cont.dart';

class GiftsPage extends StatefulWidget {
  GiftsPage({super.key, this.giftModel});
GiftModel? giftModel;

  @override
  State<GiftsPage> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

     if(widget.giftModel != null) _getGift();

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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Center(child: CircleAvatar(
                      backgroundColor: Colors.black38,
                      radius: 50,
                      child: Image.asset("assets/images/logodark.png"))),

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
                    tr('gifts'),
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Consumer<GiftProvider>(
                    builder: (context, giftProvider, _) {
                      return widget.giftModel == null ? Expanded(
                        child: giftProvider.gift_load ? const Center(child: CircularProgressIndicator(),) : ListView(
                          children: [
                            Text(giftProvider.gift!.giftTxt??'' ,style: const TextStyle(height: 2.5, fontSize: 16, color: Colors.white), textAlign: GlobalMethods.rtlLang(giftProvider.gift!.giftTxt??'q' ,)
                            ? TextAlign.end
                            : TextAlign.start )
                          ],
                        ),
                      ) : Expanded(
                        child: ListView(
                          children: [
                            Text(widget.giftModel!.giftTxt??'' ,style: const TextStyle(height: 2.5), textAlign: GlobalMethods.rtlLang(widget.giftModel!.giftTxt??'q' ,)
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
