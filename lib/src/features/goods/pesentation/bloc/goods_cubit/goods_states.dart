abstract class GoodsStates {}

class AppGetAllGoodsInitialStates extends GoodsStates {}

class AppGetAllGoodsSuccessStates extends GoodsStates {}

class AppGetAllGoodsLoadingStates extends GoodsStates {}

class AppGetAllGoodsErrorStates extends GoodsStates {
  final String error;

  AppGetAllGoodsErrorStates(this.error);
}

// class AppChangeUnitQuantityLoadingStates extends GoodsStates {}
//
// class AppChangeUnitQuantitySuccessStates extends GoodsStates {}
//
// class AppChangeUnitQuantityErrorStates extends GoodsStates {
//   final String error;
//
//   AppChangeUnitQuantityErrorStates(this.error);
// }

// class AppPikingDataState extends GoodsStates {}

// this state is active when we want to add incoming and outgoing goods

// class AppUnitAddedToIncomingState extends GoodsStates {}
//
// class AppDeleteIncomingUnitState extends GoodsStates {}
//
// class AppAddIncomingGoodsSuccessState extends GoodsStates {}
//
// class AppAddIncomingGoodsLoadingState extends GoodsStates {}

// class AppAddIncomingGoodsErrorState extends GoodsStates {
//   final String error;
//
//   AppAddIncomingGoodsErrorState(this.error);
// }
