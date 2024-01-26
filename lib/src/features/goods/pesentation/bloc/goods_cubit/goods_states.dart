abstract class GoodsStates {}

class AppGetAllGoodsInitialStates extends GoodsStates {}

class AppGetAllGoodsSuccessStates extends GoodsStates {}

class AppGetAllGoodsLoadingStates extends GoodsStates {}

class AppGetAllGoodsErrorStates extends GoodsStates {
  final String error;

  AppGetAllGoodsErrorStates(this.error);
}





