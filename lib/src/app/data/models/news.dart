import 'package:easy_localization/easy_localization.dart';

import '../../../../main.dart';
import 'category_form_model.dart';

class NewsModel {
  bool? status;
  String? message;
  String? newsTxt;

  NewsModel({this.status, this.message, this.newsTxt});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    newsTxt = json['data']['news_for_you'][NavigationService.currentContext.locale.languageCode];
  }

}
