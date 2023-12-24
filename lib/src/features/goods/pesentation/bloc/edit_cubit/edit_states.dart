abstract class EditUnitStates {}

class EditInitialState extends EditUnitStates {}

class EditUnitLoadingState extends EditUnitStates {}

class EditUnitSuccessState extends EditUnitStates {}

class EditUnitErrorState extends EditUnitStates {
  final String error;

  EditUnitErrorState(this.error);
}
