abstract class AppLoginStates {}

class AppLoginInitialStates extends AppLoginStates {}

class AppLoginSuccessStates extends AppLoginStates {}

class AppLoginLoadingStates extends AppLoginStates {}

class AppLoginErrorStates extends AppLoginStates {
  late String error;

  AppLoginErrorStates(this.error);
}

class AppLoginChangePasswordVisibilityState extends AppLoginStates {}
