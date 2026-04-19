// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/remote_data_sources/auth_remote_data_source_imp.dart'
    as _i897;
import '../../data/repositories/auth_repository_imp.dart' as _i346;
import '../../domain/repositories/auth/auth_repository.dart' as _i660;
import '../../domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart'
    as _i327;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../ui/ui/auth/login/cubit/register_view_model.dart' as _i649;
import '../../ui/ui/auth/register/cubit/register_view_model.dart' as _i502;
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i327.AuthRemoteDataSource>(
      () => _i897.AuthRemoteDataSourceImp(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i660.AuthRepository>(
      () => _i346.AuthRepositoryImp(
        authRemoteDataSource: gh<_i327.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i471.LoginUseCase>(
      () => _i471.LoginUseCase(authRepository: gh<_i660.AuthRepository>()),
    );
    gh.factory<_i479.RegisterUseCase>(
      () => _i479.RegisterUseCase(authRepository: gh<_i660.AuthRepository>()),
    );
    gh.factory<_i649.LoginViewModel>(
      () => _i649.LoginViewModel(loginUseCase: gh<_i471.LoginUseCase>()),
    );
    gh.factory<_i502.RegisterViewModel>(
      () =>
          _i502.RegisterViewModel(registerUseCase: gh<_i479.RegisterUseCase>()),
    );
    return this;
  }
}
