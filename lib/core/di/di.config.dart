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
import '../../data/data_sources/remote_data_sources/home_remote_data_source_imp.dart'
    as _i1035;
import '../../data/repositories/auth_repository_imp.dart' as _i346;
import '../../data/repositories/home_repository_imp.dart' as _i617;
import '../../domain/repositories/auth/auth_repository.dart' as _i660;
import '../../domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart'
    as _i327;
import '../../domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart'
    as _i923;
import '../../domain/repositories/home/home_repository.dart' as _i22;
import '../../domain/use_cases/get_all_brand_use_case.dart' as _i227;
import '../../domain/use_cases/get_all_category_use_case.dart' as _i1035;
import '../../domain/use_cases/get_all_product_use_case.dart' as _i826;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../ui/ui/auth/login/cubit/register_view_model.dart' as _i649;
import '../../ui/ui/auth/register/cubit/register_view_model.dart' as _i502;
import '../../ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart'
    as _i256;
import '../../ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart'
    as _i248;
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
    gh.factory<_i923.HomeRemoteDataSource>(
      () => _i1035.HomeRemoteDataSourceImp(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i660.AuthRepository>(
      () => _i346.AuthRepositoryImp(
        authRemoteDataSource: gh<_i327.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i22.HomeRepository>(
      () => _i617.HomeRepositoryImp(
        homeRemoteDataSource: gh<_i923.HomeRemoteDataSource>(),
      ),
    );
    gh.factory<_i471.LoginUseCase>(
      () => _i471.LoginUseCase(authRepository: gh<_i660.AuthRepository>()),
    );
    gh.factory<_i479.RegisterUseCase>(
      () => _i479.RegisterUseCase(authRepository: gh<_i660.AuthRepository>()),
    );
    gh.factory<_i227.GetAllBrandUseCase>(
      () => _i227.GetAllBrandUseCase(homeRepository: gh<_i22.HomeRepository>()),
    );
    gh.factory<_i1035.GetAllCategoryUseCase>(
      () => _i1035.GetAllCategoryUseCase(
        homeRepository: gh<_i22.HomeRepository>(),
      ),
    );
    gh.factory<_i826.GetAllProductUseCase>(
      () =>
          _i826.GetAllProductUseCase(homeRepository: gh<_i22.HomeRepository>()),
    );
    gh.factory<_i649.LoginViewModel>(
      () => _i649.LoginViewModel(loginUseCase: gh<_i471.LoginUseCase>()),
    );
    gh.factory<_i248.ProductsTabViewModel>(
      () => _i248.ProductsTabViewModel(
        getAllProductUseCase: gh<_i826.GetAllProductUseCase>(),
      ),
    );
    gh.factory<_i256.HomeTabViewModel>(
      () => _i256.HomeTabViewModel(
        getAllCategoryUseCase: gh<_i1035.GetAllCategoryUseCase>(),
        getAllBrandUseCase: gh<_i227.GetAllBrandUseCase>(),
      ),
    );
    gh.factory<_i502.RegisterViewModel>(
      () =>
          _i502.RegisterViewModel(registerUseCase: gh<_i479.RegisterUseCase>()),
    );
    return this;
  }
}
