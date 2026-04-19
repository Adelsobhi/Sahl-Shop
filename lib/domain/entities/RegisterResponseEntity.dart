/// message : "success"
/// user : {"name":"adel1111","email":"adel1111@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZGVjZjY2Y2ZmN2RkNjdhODIyNGJkMSIsIm5hbWUiOiJhZGVsMTExMSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2MjA5OTA2LCJleHAiOjE3ODM5ODU5MDZ9.FskPORCfkcCKnG1Wi-5ua1ioTazgI2bV6iD5hRzS8DQ"

class RegisterResponseEntity {
  RegisterResponseEntity({
      this.message, 
      this.user,
      this.token,
    this.statusMsg
  });

  String? message;
  UserEntity? user;
  String? token;
  String? statusMsg;



}
class UserEntity {
  UserEntity({
      this.name, 
      this.email,});

  String? name;
  String? email;


}