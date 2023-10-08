class FormModel {
  bool? status;
  String? message;
  Data? data;

  FormModel({this.status, this.message, this.data});

  FormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? city;
  String? detailLocation;
  int? userId;
  int? formDataId;
  int? categoryId;
  int? subCategoryId;
  int? subSubCategoryId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.email,
      this.phone,
      this.firstName,
      this.lastName,
      this.city,
      this.detailLocation,
      this.userId,
      this.formDataId,
      this.categoryId,
      this.subCategoryId,
      this.subSubCategoryId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    city = json['city'];
    detailLocation = json['Detail_Location'];
    userId = json['user_id'];
    formDataId = json['form_data_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    subSubCategoryId = json['sub_sub_category_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['city'] = this.city;
    data['Detail_Location'] = this.detailLocation;
    data['user_id'] = this.userId;
    data['form_data_id'] = this.formDataId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_sub_category_id'] = this.subSubCategoryId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}