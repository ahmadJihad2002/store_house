abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppBottomNavAppBarChangeStates extends AppStates {}

class AppSelectImageState extends AppStates {}

class AppAddTypeSuccessState extends AppStates {}

class AppDateBeenSelectedState extends AppStates {}

class AppChangeQuantityState extends AppStates {}

class AppChangeQuantityErrorState extends AppStates {
  final String error;

  AppChangeQuantityErrorState(this.error);
}

class AppAddNewTypeSuccessState extends AppStates {}

class AppAddNewTypeLoadingState extends AppStates {}

class AppAddNewTypeErrorState extends AppStates {
  final String error;

  AppAddNewTypeErrorState(this.error);
}
