abstract class LoginStates {}

class AppLoginInitialStates extends LoginStates {}

class AppLoginSuccessStates extends LoginStates {}

class AppLoginLoadingStates extends LoginStates {}

class AppLoginErrorStates extends LoginStates {
  late String error;
  AppLoginErrorStates(this.error);
}

class AppSelectImageState extends LoginStates {}

class AppLoginChangePasswordVisibilityState extends LoginStates {}
