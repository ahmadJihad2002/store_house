abstract class AddTypeStates {}

class AppInitialStates extends AddTypeStates {}

class AppBottomNavAppBarChangeStates extends AddTypeStates {}

class ChangeButtonState extends AddTypeStates {}

class AppSelectImageState extends AddTypeStates {}

class AppAddTypeSuccessState extends AddTypeStates {}

class AppDateBeenSelectedState extends AddTypeStates {}

class AppChangeQuantityState extends AddTypeStates {}

class AppChangeQuantityErrorState extends AddTypeStates {
  final String error;

  AppChangeQuantityErrorState(this.error);
}

class AppAddNewTypeSuccessState extends AddTypeStates {}

class AppAddNewTypeLoadingState extends AddTypeStates {}

class AppAddNewTypeErrorState extends AddTypeStates {
  final String error;

  AppAddNewTypeErrorState(this.error);
}
