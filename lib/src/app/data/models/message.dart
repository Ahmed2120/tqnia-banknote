class MessageModel {
  int? id;
  int? userId;
  int? sender;
  int? receiver;
  String? message;
  int? guard;
  String? createdAt;
  String? updatedAt;

  MessageModel(
      {this.id,
        this.userId,
        this.sender,
        this.receiver,
        this.message,
        this.guard,
        this.createdAt,
        this.updatedAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sender = json['sender'];
    receiver = json['receiver'];
    message = json['message'];
    guard = json['guard'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['message'] = this.message;
    data['guard'] = this.guard;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}