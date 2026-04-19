import '../../domain/entities/LoginResponseEntity.dart';

/// message : "success"
/// user : {"name":"adel1111","email":"adel1111@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZGVjZjY2Y2ZmN2RkNjdhODIyNGJkMSIsIm5hbWUiOiJhZGVsMTExMSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2NDU2MzI3LCJleHAiOjE3ODQyMzIzMjd9.9gxqrrC_nJ6YyNIXIBCuiLRf7ITPo_PeYpkj0jUnbWU"

class LoginResponseDm extends LoginResponseEntity {
  LoginResponseDm({
      super.message,
    super.user,
    super.token,
    super.statusMsg
  });

  LoginResponseDm.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? LoginUserDm.fromJson(json['user']) : null;
    token = json['token'];
  }



}

/// name : "adel1111"
/// email : "adel1111@gmail.com"
/// role : "user"

class LoginUserDm extends LoginUserEntity {
  LoginUserDm({
      super.name,
    super.email,
    this.role,
  });

  LoginUserDm.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  String? role;


}