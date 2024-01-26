abstract class AccountStates {}

class AccountInitialStates extends AccountStates {}


class GetAccountInfoSuccessState extends AccountStates {}

class GetAccountInfoLoadingState extends AccountStates {}

class GetAccountInfoErrorState extends AccountStates {
  final String error;

  GetAccountInfoErrorState(this.error);
}
class EditAccountInfoSuccessState extends AccountStates {}

class EditAccountInfoLoadingState extends AccountStates {}

class EditAccountInfoErrorState extends AccountStates {
  final String error;

  EditAccountInfoErrorState(this.error);
}
