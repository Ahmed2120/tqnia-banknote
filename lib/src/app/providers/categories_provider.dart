import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CategoriesProvider extends ChangeNotifier {
  final _api = DioClient.instance;
  bool isload= false;
  CategoryModel? categories;
  Future<void> getCategoryhData() async {
    isload=true;
    notifyListeners();
   
    categories = await _api.getCategories();
   
    isload=false;
    notifyListeners();
  }
}
