import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/use_cases/get_sub_category_use_case.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit_sub_category/sub_category_states.dart';

import '../../../../../../../domain/entities/SubCategoryResponseEntity.dart';

@injectable
class SubCategoryViewModel extends Cubit<SubCategoryStates> {
  GetSubCategoryUseCase  getSubCategoryUseCase;

  SubCategoryViewModel({
    required this.getSubCategoryUseCase,
  }) : super(SubCategoryInitialState());

   List<SubCategoryDataEntity>subCategoryList=[];
  void getSubCategories(String categoryId) async {
    emit(SubCategoryLoadingState());

    final result = await getSubCategoryUseCase.invoke(categoryId);

    result.fold(
          (error) {
        emit(SubCategoryErrorState(errorMessage: error));
      },
          (response) {
            subCategoryList=response.data!;
        emit(SubCategorySuccessState(responseEntity: response));
      },
    );
  }
}