import 'package:banknote/src/app/data/models/news.dart';
import 'package:flutter/material.dart';

import '../data/dio/dio_client.dart';

class NewsProvider with ChangeNotifier{
  final _api = DioClient.instance;

  NewsModel? _news;
  NewsModel? get news => _news;

  bool _news_load = false;
  bool get news_load => _news_load;

  Future<void> getNews() async {
    _news_load=true;
    notifyListeners();

    try{
      _news = await _api.getNews();

      _news_load=false;
      notifyListeners();
    }catch(e){

      _news_load=false;
      notifyListeners();
      rethrow;
    }


  }

}