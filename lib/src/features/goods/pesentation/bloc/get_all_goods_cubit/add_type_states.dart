import 'package:store_house/src/features/goods/data/models/unit_model.dart';

abstract class AppGetAllCubitStates {}

class AppGetAllGoodsInitialStates extends AppGetAllCubitStates {}

class AppGetAllGoodsSuccessStates extends AppGetAllCubitStates {
  final List<UnitModel> goods;

  AppGetAllGoodsSuccessStates(this.goods);
}

class AppGetAllGoodsLoadingStates extends AppGetAllCubitStates {}

class AppGetAllGoodsErrorStates extends AppGetAllCubitStates {
  final String error;

  AppGetAllGoodsErrorStates(this.error);
}

class AppChangeUnitQuantityLoadingStates extends AppGetAllCubitStates {}

class AppChangeUnitQuantitySuccessStates extends AppGetAllCubitStates {}

class AppChangeUnitQuantityErrorStates extends AppGetAllCubitStates {
  final String error;

  AppChangeUnitQuantityErrorStates(this.error);
}
