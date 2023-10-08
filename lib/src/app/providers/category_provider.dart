import 'package:banknote/src/app/data/dio/dio_client.dart';
import 'package:banknote/src/app/data/models/category_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryModel ?category;
  CategoryProvider(this.idofindex);

  final _api = DioClient.instance;
    bool isload= false;
   int? idofindex;
  Future<void> getCategoryDetails() async {
    isload=true;
    notifyListeners();
    category = await _api.getCategoryDetails(idofindex!);
     isload=false;
    notifyListeners();
  }
}
