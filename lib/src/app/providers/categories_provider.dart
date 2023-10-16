import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CategoriesProvider extends ChangeNotifier {
  final _api = DioClient.instance;
  bool isload= false;
  bool subCatLoad= false;
  CategoryModel? categories;
  CategoryModel? subCategories;
  Future<void> getCategoryhData() async {
    isload=true;
    notifyListeners();
   print('////////////////////');
    categories = await _api.getCategories();
   
    isload=false;
    notifyListeners();
  }

  Future<void> getSubCategories(int id) async {
    subCatLoad=true;
    notifyListeners();

    subCategories = await _api.getSubCategories(id);

    subCatLoad=false;
    notifyListeners();
  }
}
