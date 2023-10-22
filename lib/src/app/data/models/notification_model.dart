class NotificationModel {
  int? id;
  int? adminId;
  int? isDelete;
  int? sittingId;
  int? userId;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;

  NotificationModel({this.id,
    this.adminId,
    this.isDelete,
    this.sittingId,
    this.userId,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['admin_id'];
    isDelete = json['is_delete'];
    sittingId = json['sitting_id'];
    userId = json['user_id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}