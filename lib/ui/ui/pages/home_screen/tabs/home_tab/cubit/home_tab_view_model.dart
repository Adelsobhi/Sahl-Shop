import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/use_cases/get_all_brand_use_case.dart';
import 'package:sahl_shop/domain/use_cases/get_all_category_use_case.dart';

import '../../../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import 'home_tab_states.dart';
@injectable
class HomeTabViewModel extends Cubit<HomeTabStates> {
  GetAllCategoryUseCase getAllCategoryUseCase;
  GetAllBrandUseCase getAllBrandUseCase;
  HomeTabViewModel({required this.getAllCategoryUseCase,required this.getAllBrandUseCase}):super(HomeTabInitialState());
  List<CategoryOrBrandEntity>categoriesList=[];
  List<CategoryOrBrandEntity>brandsList=[];
  void getAllCategories()async{
    emit(CategoryLoadingState());
       var either=await getAllCategoryUseCase.invoke();
       either.fold((error){
         emit(CategoryErrorState(errors: error));
       },
               (response) {
          categoriesList=response.data!;
                 emit(
                     CategorySuccessState(responseEntity: response)
                 );
           }
       );
    }

  void getAllBrands()async{
    emit(BrandLoadingState());
    var either= await getAllBrandUseCase.invoke();
    either.fold((error){
      emit(BrandErrorState(errors: error));
    },
        (response){
      brandsList=response.data!;
      emit(BrandSuccessState(responseEntity: response));

        });
  }

}


