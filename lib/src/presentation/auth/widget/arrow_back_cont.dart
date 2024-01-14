import 'package:banknote/src/app/utils/color.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';

import '../../../../main.dart';

class ArrowBackContainer extends StatelessWidget {
  const ArrowBackContainer({super.key, required this.onpress});

  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration:
            BoxDecoration(color: p7, borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.arrow_forward_ios_sharp,
          size: 25,
          color: Colors.white,
          textDirection: context.locale.languageCode == 'en' ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
    );
  }
}
