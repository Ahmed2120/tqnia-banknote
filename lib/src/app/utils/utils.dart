import 'package:flutter/cupertino.dart';

class Utils {
  static num getSpacing(BuildContext context, num cardWidth,
      {bool cardsNumber = false}) {
    final width = (MediaQuery.of(context).size.width - 32);
    final numberOfCards = (width / cardWidth).floor();
    if (cardsNumber) return numberOfCards;
    final decimal = ((width / cardWidth) - numberOfCards) * 100;
    final spacing = decimal / (numberOfCards);
    return spacing;
  }
}

extension EmptySpace on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}


class EmailChecker {
  static bool isNotValid(String email) {
    return !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}

class PhoneChecker {
  static bool isNotValid(String phone) {
    return !RegExp(r"^01[0125][0-9]{8}$").hasMatch(phone);
  }
}
