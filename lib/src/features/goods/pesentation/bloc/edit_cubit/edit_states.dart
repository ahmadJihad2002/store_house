abstract class EditUnitStates {}

class EditInitialState extends EditUnitStates {}

class EditChangeQuantityErrorState extends EditUnitStates {
  final String error;

  EditChangeQuantityErrorState(this.error);
}

class EditChangeQuantitySuccessState extends EditUnitStates {}

class EditUnitLoadingState extends EditUnitStates {}

class EditUnitSuccessState extends EditUnitStates {}

class EditUnitErrorState extends EditUnitStates {
  final String error;

  EditUnitErrorState(this.error);
}

class DeleteUnitLoadingState extends EditUnitStates {}

class DeleteUnitSuccessState extends EditUnitStates {}

class DeleteUnitErrorState extends EditUnitStates {
  final String error;

  DeleteUnitErrorState(this.error);
}
