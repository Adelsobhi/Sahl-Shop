/// message : "success"
/// user : {"name":"adel1111","email":"adel1111@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZGVjZjY2Y2ZmN2RkNjdhODIyNGJkMSIsIm5hbWUiOiJhZGVsMTExMSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2MjA5OTA2LCJleHAiOjE3ODM5ODU5MDZ9.FskPORCfkcCKnG1Wi-5ua1ioTazgI2bV6iD5hRzS8DQ"

class LoginResponseEntity {
  LoginResponseEntity({
      this.message, 
      this.user, 
      this.token,
      this.statusMsg
  });

  LoginResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? LoginUserEntity.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  LoginUserEntity? user;
  String? token;
  String? statusMsg;



}

/// name : "adel1111"
/// email : "adel1111@gmail.com"
/// role : "user"

class LoginUserEntity {
  LoginUserEntity({
      this.name, 
      this.email,});

  LoginUserEntity.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
  }
  String? name;
  String? email;


}