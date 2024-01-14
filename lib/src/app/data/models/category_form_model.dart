import 'package:easy_localization/easy_localization.dart';

import '../../../../main.dart';

class CategoryFormModel{
  int? id;
  String? title;
  String? description;
  int? price;
  String? date;
  int? members;
  List<int>? privateMembers;
  List<FormData>? formData;


  CategoryFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'][NavigationService.currentContext.locale.languageCode];
    description = json['description'][NavigationService.currentContext.locale.languageCode];
    price = json['price'];
    date = json['date'];
    members = json['members'];
    privateMembers = json['private_members']?.map<int>((e)=> int.parse(e)).toList();
    formData = json['forms']?.map<FormData>((e)=> FormData.fromJson(e)).toList();
  }
}

class FormData{
  String inputName;
  FormData({required this.inputName});

  FormData.fromJson(Map<String, dynamic> json) :

    inputName = json['input_name'];


}