import 'package:sahl_shop/domain/entities/RegisterResponseEntity.dart';

/// message : "success"
/// user : {"name":"adel1111","email":"adel1111@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZGVjZjY2Y2ZmN2RkNjdhODIyNGJkMSIsIm5hbWUiOiJhZGVsMTExMSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2MjA5OTA2LCJleHAiOjE3ODM5ODU5MDZ9.FskPORCfkcCKnG1Wi-5ua1ioTazgI2bV6iD5hRzS8DQ"

class RegisterResponseDm extends RegisterResponseEntity {
  RegisterResponseDm({
      super.message,
      super.user,
      super.statusMsg,
      super.token,});

  RegisterResponseDm.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDM.fromJson(json['user']) : null;
    token = json['token'];
  }


}

/// name : "adel1111"
/// email : "adel1111@gmail.com"
/// role : "user"

class UserDM extends UserEntity  {
  UserDM({
      super.name,
      super.email,
      this.role,});

  UserDM.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  String? role;



}