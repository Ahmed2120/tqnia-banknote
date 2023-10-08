import 'package:banknote/src/app/utils/color.dart';
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer(
      {Key? key,
      this.hasShadow = false,
      this.iconColor,
      this.color,
      this.height,
      this.width,
      this.onTap,
      this.isGradient = false})
      : super(key: key);

  final bool hasShadow;
  final Color? color;
  final Color? iconColor;
  final bool isGradient;
  final double? height;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 45,
        width: width ?? 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: p1,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.camera_alt,
          color: iconColor ??
              (color == Theme.of(context).primaryColor
                  ? Theme.of(context).scaffoldBackgroundColor
                  : null),
        ),
      ),
    );
  }
}
