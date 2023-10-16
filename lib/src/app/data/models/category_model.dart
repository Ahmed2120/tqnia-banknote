import 'category_form_model.dart';

class CategoryModel {
  bool? status;
  String? message;
  List<Category>? listCategory;

  CategoryModel({this.status, this.message, this.listCategory});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listCategory = <Category>[];
      json['data'].forEach((v) {
        listCategory!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.listCategory != null) {
      data['data'] = this.listCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? titl;
  String? desc;
  String? price;
  String? date;
  int? isDelete;
  int? isActive;
  int? isHasData;
  String? createdAt;
  CategoryFormModel? categoryFormModel;
  List<FormUsers>? formUsers;

  Category(
      {this.id,
      this.titl,
      this.desc,
      this.price,
      this.date,
      this.isDelete,
      this.isActive,
      this.isHasData,
      this.createdAt,
      this.categoryFormModel});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titl = json['titl'];
    desc = json['desc'];
    price = json['price'].toString();
    date = json['date'];
    isDelete = json['is_delete'];
    isActive = json['is_active'];
    isHasData = json['is_hasData'];
    createdAt = json['created_at'];
    categoryFormModel = json['form_data2'] == null ? null : CategoryFormModel.fromJson(json['form_data2']);
    formUsers = json['form_users'] != null ? json['form_users'].map<FormUsers>((e)=> FormUsers.fromJson(e)).toList() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titl'] = this.titl;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['date'] = this.date;
    data['is_delete'] = this.isDelete;
    data['is_active'] = this.isActive;
    data['is_hasData'] = this.isHasData;
    data['created_at'] = this.createdAt;
    data['form_data2'] = this.categoryFormModel;
    return data;
  }
}

class FormUsers{
  int? number;
  int? formDataId;

  FormUsers.fromJson(Map<String, dynamic> json) {

    number = json['number'];
    formDataId = json['form_data_id'];

  }
}
