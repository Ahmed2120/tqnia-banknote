import 'dart:io';
export 'package:provider/provider.dart';
import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/category_form_model.dart';
import 'package:banknote/src/app/data/models/form_model.dart';
import 'package:dio/dio.dart' as d;

import 'package:flutter/material.dart';

import '../data/models/category_model.dart';

FormModel? form;
final _api = DioClient.instance;

class CreateFormProvider extends ChangeNotifier {

  bool _form_load = false;
  bool get formLoad => _form_load;

  Future<void> createForm(
  {required int id,
  required int number,
  String? firstName,
  String? lastName,
  String? title,
  String? email,
  String? desc,
  String? date,
  String? phone,
  String? city,
  String? detailLocation,
  int? price,

      File? image}) async {
    try{
      _form_load = true;
      notifyListeners();

      form = await _api.createForm(
        id: id,
        firstName: firstName,
        lastName: lastName,
        title: title,
        email: email,
        desc: desc,
        date: date,
        price: price,
        number: number,
        phone: phone,
        image: image,
        city: city,
        detailLocation: detailLocation,
      );

      _form_load = false;
      notifyListeners();
    }on d.DioException catch(e){
      print(e.response!.data);
      _form_load = false;
      notifyListeners();
      throw e.response!.data;
    }
    catch(e){
      _form_load = false;
      notifyListeners();
      rethrow;
    }


  }

  bool containsInputType(List<FormData> formData, String type) {
    for (var i in formData) {
      if (i.inputName == type) {
        return true;
      }
    }
    return false;
  }

  List<int> getNumberOfMembersList(List<FormUsers> formUsers, int members, List<int>? privateMembers) {
    final List<int> NumMembers = [];
    for (int i = 1; i <= members; i++) {
      NumMembers.add(i);
    }
    for (var i in formUsers) {
      NumMembers.remove(i.number);
    }
    print('lllllllllllllllllllllllll;;;;;;;;;;;;;;');
    print(privateMembers.runtimeType);
    if(privateMembers != null) {
      for (var i in privateMembers) {
        NumMembers.remove(i);
      }
    }

    return NumMembers;
  }
}
