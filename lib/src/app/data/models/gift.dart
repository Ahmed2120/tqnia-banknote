import 'package:easy_localization/easy_localization.dart';

import '../../../../main.dart';
import 'category_form_model.dart';

class GiftModel {
  bool? status;
  String? message;
  String? giftTxt;

  GiftModel({this.status, this.message, this.giftTxt});

  GiftModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    giftTxt = json['data']['gifts'][NavigationService.currentContext.locale.languageCode];
  }

}
