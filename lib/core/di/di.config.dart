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
import '../../data/data_sources/remote_data_sources/cart_remote_data_source_imp.dart'
    as _i106;
import '../../data/data_sources/remote_data_sources/home_remote_data_source_imp.dart'
    as _i1035;
import '../../data/repositories/auth_repository_imp.dart' as _i346;
import '../../data/repositories/cart_repository_imp.dart' as _i489;
import '../../data/repositories/home_repository_imp.dart' as _i617;
import '../../domain/repositories/auth/auth_repository.dart' as _i660;
import '../../domain/repositories/cart/cart_repository.dart' as _i388;
import '../../domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart'
    as _i327;
import '../../domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart'
    as _i629;
import '../../domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart'
    as _i923;
import '../../domain/repositories/home/home_repository.dart' as _i22;
import '../../domain/use_cases/add_to_cart_use_case.dart' as _i1024;
import '../../domain/use_cases/delete_items_in_cart_use_case.dart' as _i87;
import '../../domain/use_cases/get_all_brand_use_case.dart' as _i227;
import '../../domain/use_cases/get_all_category_use_case.dart' as _i1035;
import '../../domain/use_cases/get_all_product_use_case.dart' as _i826;
import '../../domain/use_cases/get_items_in_cart_use_case.dart' as _i315;
import '../../domain/use_cases/get_sub_category_use_case.dart' as _i718;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/order_use_case.dart' as _i924;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../domain/use_cases/update_count_in_cart_use_case.dart' as _i261;
import '../../ui/ui/auth/login/cubit/register_view_model.dart' as _i649;
import '../../ui/ui/auth/register/cubit/register_view_model.dart' as _i502;
import '../../ui/ui/pages/cart_screen/cubit/cart_view_model.dart' as _i843;
import '../../ui/ui/pages/check_out_screen/cubit/checkout_screen_view_model.dart'
    as _i39;
import '../../ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart'
    as _i256;
import '../../ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart'
    as _i248;
import '../../ui/ui/pages/home_screen/tabs/products_tab/cubit_sub_category/sub_category_view_model.dart'
    as _i305;
import '../../ui/ui/pages/home_screen/tabs/user_tab/cubit/user_tab_view_model.dart'
    as _i355;
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i355.UserTabViewModel>(() => _i355.UserTabViewModel());
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i629.CartRemoteDataSource>(
      () => _i106.CartRemoteDataSourceImp(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i327.AuthRemoteDataSource>(
      () => _i897.AuthRemoteDataSourceImp(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i923.HomeRemoteDataSource>(
      () => _i1035.HomeRemoteDataSourceImp(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i388.CartRepository>(
      () => _i489.CartRepositoryImp(
        cartRemoteDataSource: gh<_i629.CartRemoteDataSource>(),
      ),
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
    gh.factory<_i87.DeleteItemsInCartUseCase>(
      () => _i87.DeleteItemsInCartUseCase(
        cartRepository: gh<_i388.CartRepository>(),
      ),
    );
    gh.factory<_i315.GetItemsInCartUseCase>(
      () => _i315.GetItemsInCartUseCase(
        cartRepository: gh<_i388.CartRepository>(),
      ),
    );
    gh.factory<_i924.OrderUseCase>(
      () => _i924.OrderUseCase(cartRepository: gh<_i388.CartRepository>()),
    );
    gh.factory<_i261.UpdateCountInCartUseCase>(
      () => _i261.UpdateCountInCartUseCase(
        cartRepository: gh<_i388.CartRepository>(),
      ),
    );
    gh.factory<_i843.CartViewModel>(
      () => _i843.CartViewModel(
        getItemsInCartUseCase: gh<_i315.GetItemsInCartUseCase>(),
        deleteItemsInCartUseCase: gh<_i87.DeleteItemsInCartUseCase>(),
        updateCountInCartUseCase: gh<_i261.UpdateCountInCartUseCase>(),
      ),
    );
    gh.factory<_i471.LoginUseCase>(
      () => _i471.LoginUseCase(authRepository: gh<_i660.AuthRepository>()),
    );
    gh.factory<_i479.RegisterUseCase>(
      () => _i479.RegisterUseCase(authRepository: gh<_i660.AuthRepository>()),
    );
    gh.factory<_i1024.AddToCartUseCase>(
      () => _i1024.AddToCartUseCase(homeRepository: gh<_i22.HomeRepository>()),
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
    gh.factory<_i718.GetSubCategoryUseCase>(
      () => _i718.GetSubCategoryUseCase(
        homeRepository: gh<_i22.HomeRepository>(),
      ),
    );
    gh.factory<_i649.LoginViewModel>(
      () => _i649.LoginViewModel(loginUseCase: gh<_i471.LoginUseCase>()),
    );
    gh.factory<_i39.CheckoutScreenViewModel>(
      () => _i39.CheckoutScreenViewModel(gh<_i924.OrderUseCase>()),
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
    gh.factory<_i305.SubCategoryViewModel>(
      () => _i305.SubCategoryViewModel(
        getSubCategoryUseCase: gh<_i718.GetSubCategoryUseCase>(),
      ),
    );
    gh.factory<_i248.ProductsTabViewModel>(
      () => _i248.ProductsTabViewModel(
        getAllProductUseCase: gh<_i826.GetAllProductUseCase>(),
        addToCartUseCase: gh<_i1024.AddToCartUseCase>(),
      ),
    );
    return this;
  }
}
