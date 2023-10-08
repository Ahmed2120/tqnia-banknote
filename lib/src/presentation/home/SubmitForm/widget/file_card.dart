import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class FileCard extends StatelessWidget {
  const FileCard({Key? key, required this.name, required this.size})
      : super(key: key);

  final String name;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding:  EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).cardColor,
          width: 0.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.07),
            offset: const Offset(12, 26),
            blurRadius: 50,
          ),
        ],
      ),
      child: Row(
        children: [
           Image.asset('assets/images/logodark.png'),
            SizedBox(
            height: MediaQuery.of(context).size.height/35,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  '${(size * math.pow(10, -6)).toString()} ${tr('mb')}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
