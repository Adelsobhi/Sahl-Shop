import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/repositories/auth/auth_repository.dart';

import '../../core/errors/errors.dart';
import '../entities/RegisterResponseEntity.dart';
@injectable
class RegisterUseCase {
  AuthRepository  authRepository;
  RegisterUseCase({required this.authRepository});

  Future<Either<Errors, RegisterResponseEntity>>invoke(String name,String email,String password,String rePassword,String phone){
     return authRepository.register(name, email, password, rePassword, phone);
  }


}