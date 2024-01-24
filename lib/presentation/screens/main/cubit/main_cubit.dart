import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/core/services/shared_prefrences.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/usecase/get_all_users_usecase.dart';
import 'package:chat_translator/domain/usecase/get_last_message_usecase.dart';
import 'package:chat_translator/presentation/screens/main/cubit/main_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  final GetAllusersUsecase _getAllusersUsecase = GetAllusersUsecase(getIt());

  final GetLastMessageUsecase _getLastMessageUsecase = GetLastMessageUsecase(getIt());

  // final GetUserDataByIdUsecase _getUserDataByIdUsecase = GetUserDataByIdUsecase(getIt());

  final AppPrefernces _appPrefernces = AppPrefernces(getIt());

  List<Customer> users = [];
  String myId = '';
  Customer? user;

  Future<void> getMyId() async {
    myId = await _appPrefernces.getUserId();
    print('userId$myId');
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
        getMyId().then((value) => getMyUser());
        emit(MainGetAllUsersSuccessState());
      },
    );
  }

  getMyUser() {
    user = users.where((customer) => customer.id == myId).first;
    users.removeWhere((customer) => customer.id == myId);
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

  Stream<Message> getLastMessage(String myFriendId, String myId) {
    return _getLastMessageUsecase.execute(myFriendId, myId);
  }

  String extractTime(String inputString) {
    try {
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(inputString);

      // Format the DateTime to get the time part only
      String formattedMinute = dateTime.minute.toString().padLeft(2, '0');
      return "${dateTime.hour}:$formattedMinute";
    } catch (e) {
      // Handle parsing errors or invalid input strings
      print("Error parsing the input string: $e");
      return '';
    }
  }
}
