abstract class MainStates {}

class MainInitialState extends MainStates {}

class MainGetAllUsersLoadingState extends MainStates {}

class MainGetAllUsersSuccessState extends MainStates {}

class MainGetAllUsersErrorState extends MainStates {
  final String error;

  MainGetAllUsersErrorState(this.error);
}
