import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/use_cases/get_all_product_use_case.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_states.dart';

import '../../../../../../../domain/entities/ProductResponseEntity.dart';
@injectable
class ProductsTabViewModel  extends Cubit<ProductsTabStates>{
  GetAllProductUseCase getAllProductUseCase;
  ProductsTabViewModel({required this.getAllProductUseCase}) : super(ProductTabInitialState());
  List<ProductsEntity> productsList=[];
  void getAllProducts() async{
    emit(ProductTabLoadingState());

    try {
      var response = await getAllProductUseCase.invoke();
      productsList = response.products ?? [];
      emit(ProductTabSuccessState(responseEntity: response));

    } catch (e) {
      emit(ProductTabErrorState(errorMessage: e.toString()));
    }




  }

}