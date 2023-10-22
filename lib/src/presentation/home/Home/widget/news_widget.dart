import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../main.dart';
import '../../../../app/utils/color.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.onTap,
    required this.newsText,
    required this.loading,
  });

  final Function onTap;
  final String? newsText;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final dSizeWidth = MediaQuery.of(context).size.width;

    return Container(
      width: dSizeWidth < 570 ? 180 : dSizeWidth * 0.3,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: loading
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotateMultiple,
                  colors: [p7],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  newsText ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                InkWell(
                  onTap: () => onTap(),
                  child: Align(
                      alignment: NavigationService
                                  .currentContext.locale.languageCode ==
                              'en'
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Text(
                        tr('show_more'),
                        style: TextStyle(color: p1),
                      )),
                ),
              ],
            ),
    );
  }
}
