import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/core/services/shared_prefrences.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/usecase/get_all_users_usecase.dart';
import 'package:chat_translator/presentation/screens/main/cubit/main_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  final GetAllusersUsecase _getAllusersUsecase = GetAllusersUsecase(getIt());

  // final GetUserDataByIdUsecase _getUserDataByIdUsecase = GetUserDataByIdUsecase(getIt());

  final AppPrefernces _appPrefernces = AppPrefernces(getIt());

  List<Customer> users = [];
  String userId = '';
  Customer? user;

  Future<void> getUserId() async {
    userId = await _appPrefernces.getUserId();
    print('userId$userId');
    emit(MainGetUserIdState());
  }

  void getAllUsers() async {
    emit(MainGetAllUsersLoadingState());
    (await _getAllusersUsecase.execute()).fold(
      (failure) {
        emit(MainGetAllUsersErrorState(failure.message));
      },
      (data) async {
        users = data;
        getUserId().then((value) => getMyUser());
        emit(MainGetAllUsersSuccessState());
      },
    );
  }

  getMyUser() {
    user = users.where((customer) => customer.id == userId).first;
    users.removeWhere((customer) => customer.id == userId);
    emit(MainGetMyUserState());
  }

  // void getUserData() async {
  //   emit(MainGetUserDataLoadingState());
  //   (await _getUserDataByIdUsecase.execute(await _appPrefernces.getUserId())).fold(
  //     (failure) {
  //       emit(MainGetUserDataErrorState(failure.message));
  //     },
  //     (data) {
  //       user = data;
  //       emit(MainGetUserDataSuccessState());
  //     },
  //   );
  // }
}
