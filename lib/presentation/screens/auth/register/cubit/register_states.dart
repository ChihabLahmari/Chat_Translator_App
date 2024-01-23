abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterNameValidState extends RegisterStates {}

class RegisterEmailValidState extends RegisterStates {}

class RegisterPasswordValidState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterAddNewUserLoadingState extends RegisterStates {}

class RegisterAddNewUserSuccessState extends RegisterStates {}

class RegisterAddNewUserErrorState extends RegisterStates {
  final String error;

  RegisterAddNewUserErrorState(this.error);
}
class RegisterChangeImageState extends RegisterStates {}
class RegisterChangeLanguageState extends RegisterStates {}
