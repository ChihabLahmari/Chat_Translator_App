abstract class MainStates {}

class MainInitialState extends MainStates {}

class MainGetAllUsersLoadingState extends MainStates {}

class MainGetAllUsersSuccessState extends MainStates {}

class MainGetAllUsersErrorState extends MainStates {
  final String error;

  MainGetAllUsersErrorState(this.error);
}

class MainGetUserDataLoadingState extends MainStates {}

class MainGetUserDataSuccessState extends MainStates {}

class MainGetUserDataErrorState extends MainStates {
  final String error;

  MainGetUserDataErrorState(this.error);
}

class MainGetUserIdState extends MainStates {}

class MainGetMyUserState extends MainStates {}
