import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/api/api_manager.dart';
import 'package:sahl_shop/data/models/RegisterResponseDM.dart';
import 'package:sahl_shop/domain/entities/LoginResponseEntity.dart';
import 'package:sahl_shop/domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart';
import '../../../../core/errors/errors.dart';
import '../../../core/api/end_points.dart';
import '../../models/LoginResponseDM.dart';
@Injectable(as: AuthRemoteDataSource)
 class AuthRemoteDataSourceImp implements AuthRemoteDataSource{
  ApiManager apiManager;
  AuthRemoteDataSourceImp({required this.apiManager});
  @override
  Future<Either<Errors, RegisterResponseDm>> register(String name, String email, String password, String rePassword, String phone)async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var response = await apiManager.postData(
            endPoint: EndPoints.signUp,
            body: {
              "name": name,
              "email": email,
              "password": password,
              "rePassword": rePassword,
              "phone": phone
            }
        );

        var registerResponse = RegisterResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        } else {
          return Left(ServerError(errorMessage: registerResponse.message!));
        }
      } else {
        //todo no internet
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    }catch(e){
      return Left(ServerError(errorMessage: e.toString()));

    }
  }

  @override
  Future<Either<Errors, LoginResponseDm>> login(String email, String password)async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        //todo internet
        var response = await apiManager.postData(
            endPoint: EndPoints.login,
            body: {
              "email": email,
              "password": password,
           }
        );

        var loginResponse = LoginResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(loginResponse);
        } else {
          return Left(ServerError(errorMessage: loginResponse.message!));
        }
      } else {
        //todo no internet
        return Left(NetworkError(
            errorMessage: 'no internet connection please check internet'));
      }
    }catch(e){
      return
        Left(ServerError(errorMessage: e.toString()));

    }
  }

}