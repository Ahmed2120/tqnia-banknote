import 'package:banknote/src/app/utils/app_constants.dart';
import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? deviceToken;
  bool? emailVerifiedAt;
  String? photo;
  bool? isDelete;
  bool? isActive;
  String? createdAt;
  UserModel(
      { 
      this.id,
      this.fName,
      this.lName,
      this.phone,
      this.email,
      this.deviceToken,
      this.emailVerifiedAt,
      this.photo ,
      this.createdAt ,
      });

  UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    id = json['id'];
    fName = json['first_name'];
    lName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    deviceToken = json['device_token'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    if (json["photo"] != null) {
      photo = json["photo"].startsWith('http')
          ? json["photo"]
          : '${Connection.storage}${json["photo"]}';
    }
    if (isNotBlank(token)) saveToken('Bearer $token');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': fName,
        'last_name': lName,
        'phone': phone,
        'email': email,
        'device_token': deviceToken,
        'photo': photo,
      };

  static Future<String?> get getToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> get isLoggedIn async => await getToken != null;

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
