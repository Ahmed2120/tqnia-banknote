import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../data/dio/dio_client.dart';
import '../data/models/message.dart';

class ChatProvider with ChangeNotifier{

  final appId = "1696520";
  final key = "b7f727205d53e1147bfb";
  final secretKey = "b91e4b797a4340ed716f";
  final cluster = "ap2";

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final _api = DioClient.instance;

  List<MessageModel> _messageList = [];
  List<MessageModel> get messageList => _messageList;

  bool _unReadMsg = false;
  bool get unReadMsg => _unReadMsg;

  bool _msgLoading = false;
  bool get msgLoading => _msgLoading;

  bool _sendMsgLoading = false;
  bool get sendMsgLoading => _sendMsgLoading;

  initialize(int userId) async{
    try {
      await pusher.init(
        apiKey: key,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onDecryptionFailure: onDecryptionFailure,
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      final myChannel = await pusher.subscribe(
          channelName: "1$userId",
          onEvent: ((onEvent)=>print(onEvent.runtimeType))
      );
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    log("onEvent: $event");

    try{
      if(event.data != {}){
        final msg = MessageModel.fromJson(jsonDecode(event.data));

        _messageList.add(msg);
      }
    }catch(e){
      print('llllllllllllllllllll');
      print(e);
    }

    // TODO show mwssage
    notifyListeners();
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }


  Future<void> getMessages() async {
    _msgLoading=true;
    notifyListeners();

    try{
      _messageList = await _api.getMessages();

      _msgLoading=false;
      notifyListeners();
    }on DioException catch(e){
      print(',,,,,,,,,,,,,,,,,,,,,,,');
      print(e.response?.data);
      _msgLoading=false;
      notifyListeners();

      throw e.response!.data;
    }
    catch(e){
      _msgLoading=false;
      notifyListeners();

      rethrow;
    }
  }

  Future<bool> sendMessage(String message) async {
    _sendMsgLoading=true;
    notifyListeners();

    try{
      final success = await _api.sendMessage(message);


      _sendMsgLoading=false;
      notifyListeners();
      return success;
    }on DioException catch(e){
      _sendMsgLoading=false;

      notifyListeners();
      print('llklk-------send');
      print(e.response!.statusCode);
      throw e.response!.data;
    }
    catch(e){
      _sendMsgLoading=false;
      notifyListeners();

      rethrow;
    }


  }
}