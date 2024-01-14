
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/utils/color.dart';
import '../../../../app/widgets/button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final double iconSize;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
  const ConfirmationDialog({
    Key? key,
    required this.icon,
    this.iconSize = 50,
    this.title,
    required this.description,
    required this.onYesPressed,
    this.isLogOut = false,
    this.hasCancel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(icon, width: iconSize, height: iconSize),
          ),
          title != null
              ? Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10),
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.red),
            ),
          )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(description,

                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 30),
          Row(children: [
            Expanded(
                child: TextButton(
                  onPressed: () =>Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .disabledColor
                        .withOpacity(0.3),
                    minimumSize: const Size(1170, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15)),
                  ),
                  child: Text(
                    tr('no'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color),
                  ),
                )),
            SizedBox(
                width: 20),
            Expanded(
                child: Button(
                  buttonText: tr('yes'),
                  onpress: () => onYesPressed(),
                    textColor: Colors.white,
                    buttonColor: p7,
                    buttonRadius: 20,
                    buttonHight: 50,
                    buttonWidth: 130,
                    textSize: 16
                )),
          ]),
        ]),
      ),
    );
  }
}
