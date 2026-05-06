import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/use_cases/get_all_brand_use_case.dart';
import 'package:sahl_shop/domain/use_cases/get_all_category_use_case.dart';

import '../../../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import 'home_tab_states.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabStates> {
  final GetAllCategoryUseCase getAllCategoryUseCase;
  final GetAllBrandUseCase getAllBrandUseCase;

  HomeTabViewModel({
    required this.getAllCategoryUseCase,
    required this.getAllBrandUseCase,
  }) : super(HomeTabInitialState());

  void getAllCategories() async {
    emit(CategoryLoadingState());

    final result = await getAllCategoryUseCase.invoke();

    result.fold(
          (error) {
        emit(CategoryErrorState(errors: error));
      },
          (response) {
        emit(CategorySuccessState(responseEntity: response));
      },
    );
  }

  void getAllBrands() async {
    emit(BrandLoadingState());

    final result = await getAllBrandUseCase.invoke();

    result.fold(
          (error) {
        emit(BrandErrorState(errors: error));
      },
          (response) {
        emit(BrandSuccessState(responseEntity: response));
      },
    );
  }
}