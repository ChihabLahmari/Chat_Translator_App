import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/usecase/get_all_users_usecase.dart';
import 'package:chat_translator/presentation/screens/main/cubit/main_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  final GetAllusersUsecase _getAllusersUsecase = GetAllusersUsecase(getIt());

  List<Customer> users = [];

  void getAllUsers() async {
    emit(MainGetAllUsersLoadingState());
    (await _getAllusersUsecase.execute()).fold(
      (failure) {
        emit(MainGetAllUsersErrorState(failure.message));
      },
      (data) {
        users = data + data + data;
        emit(MainGetAllUsersSuccessState());
      },
    );
  }

  String getImage(String imageNum) {
    if (imageNum == '0') return 'assets/images/boySticker.png';
    if (imageNum == '1') return 'assets/images/girlSticker.png';
    if (imageNum == '2') return 'assets/images/belliSticker.png';
    return 'assets/images/boySticker.png';
  }
}
