import 'package:easy_localization/easy_localization.dart';

import '../../../../main.dart';

class CategoryFormModel{
  int? id;
  String? title;
  String? description;
  int? price;
  String? date;
  int? members;
  List<FormData>? formData;
  List<FormUsers>? formUsers;

  CategoryFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'][NavigationService.currentContext.locale.languageCode];
    description = json['description'][NavigationService.currentContext.locale.languageCode];
    price = json['price'];
    date = json['date'];
    members = json['members'];
    formData = json['forms']?.map<FormData>((e)=> FormData.fromJson(e)).toList();
    formUsers = json['form_users']?.map<FormUsers>((e)=> FormUsers.fromJson(e)).toList();
  }
}

class FormData{
  String? inputName;

  FormData.fromJson(Map<String, dynamic> json) {

    inputName = json['inputName'];

  }
}

class FormUsers{
  int? number;
  int? formDataId;

  FormUsers.fromJson(Map<String, dynamic> json) {

    number = json['number'];
    formDataId = json['form_data_id'];

  }
}