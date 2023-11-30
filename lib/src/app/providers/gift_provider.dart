import 'package:banknote/src/app/data/models/news.dart';
import 'package:flutter/material.dart';

import '../data/dio/dio_client.dart';
import '../data/models/gift.dart';

class GiftProvider with ChangeNotifier{
  final _api = DioClient.instance;

  GiftModel? _gift;
  GiftModel? get gift => _gift;

  bool _gift_load = false;
  bool get gift_load => _gift_load;

  Future<void> getGift() async {
    _gift_load=true;
    notifyListeners();

    try{
      _gift = await _api.getGift();

      _gift_load=false;
      notifyListeners();
    }catch(e){
      _gift_load=false;
      notifyListeners();

      // rethrow;
    }


  }

}