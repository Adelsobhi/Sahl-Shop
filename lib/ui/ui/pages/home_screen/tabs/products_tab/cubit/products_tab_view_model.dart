import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/use_cases/get_all_product_use_case.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_states.dart';

import '../../../../../../../core/cache/shared_preference.dart';
import '../../../../../../../core/errors/errors.dart';
import '../../../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../../../domain/use_cases/add_to_cart_use_case.dart';
@injectable
class ProductsTabViewModel  extends Cubit<ProductsTabStates>{
  AddToCartUseCase addToCartUseCase;
  GetAllProductUseCase getAllProductUseCase;
  ProductsTabViewModel({required this.getAllProductUseCase,required this.addToCartUseCase}) : super(ProductTabInitialState());
  int? numOfCartItems=0 ;
  List<DataEntity> productsList=[];
  List<String> favoriteIds=[];
  // القائمة التي سيتم عرضها وفلترتها أثناء البحث
  List<DataEntity> SearchProductsList = [];
  static ProductsTabViewModel get(context)=>  BlocProvider.of<ProductsTabViewModel>(context);
  void getAllProducts() async{
    emit(ProductTabLoadingState());

    var either = await getAllProductUseCase.invoke();
    either.fold((error) {
      emit(ProductTabErrorState(errorMessage: error));
    }, (response) {
      productsList = response.data ?? [];
      SearchProductsList = productsList;
      emit(ProductTabSuccessState(responseEntity: response));
    });

    }


  void addToCart({required String productId}) async{
    emit(AddCartLoadingState());
    try {
      var either = await addToCartUseCase.invoke(productId: productId);
      either.fold((error) {
        emit(AddCartErrorState(errorMessage: error));
        print('error: ${error.errorMessage}');
      },(response){
        numOfCartItems=response.numOfCartItems!.toInt();
        emit(AddCartSuccessState(responseEntity: response));
        print('numOfCartItems: $numOfCartItems');
      } );

    } catch (e) {
      emit(ProductTabErrorState(errorMessage: Errors(errorMessage: e.toString())));
    }




  }


  void toggleFavorite({required String productId}) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }

    SharedPreference.saveData(
      key: 'favorites', // 👈 مهم جدًا
      value: favoriteIds,
    );

    print("Favorites List: $favoriteIds");

    emit(FavoriteUpdatedState());
  }
  void loadFavorites() {
    favoriteIds = SharedPreference
        .getStringList(key: 'favorites');

    print("Loaded Favorites: $favoriteIds");

    emit(FavoriteUpdatedState());
  }

  void search(String query) {
    if (query.isEmpty) {

      SearchProductsList = productsList;
    } else {
      // فلترة المنتجات بناءً على الاسم (Title)
      SearchProductsList = productsList.where((product) {
        return product.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(ProductSearchState());
  }


}










