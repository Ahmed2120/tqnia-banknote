import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../app/utils/color.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key, required this.onTap, required this.newsText,
  });

  final Function onTap;
  final String newsText;

  @override
  Widget build(BuildContext context) {
    final dSizeWidth = MediaQuery.of(context).size.width;

    return Container(
      width: dSizeWidth < 570 ? 180 : dSizeWidth * 0.3,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(newsText, overflow: TextOverflow.ellipsis, maxLines: 3,),
          InkWell(
            onTap: ()=> onTap(),
            child: Align(
              alignment: Alignment.topRight,
                child: Text(tr('show_more'), style: TextStyle(color: p1),)),
          ),
        ],
      ),
    );
  }
}