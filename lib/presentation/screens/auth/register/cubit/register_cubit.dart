import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/core/services/shared_prefrences.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/usecase/add_new_use_usecase.dart';
import 'package:chat_translator/domain/usecase/register_with_email_password_usecase.dart';
import 'package:chat_translator/presentation/components/constances.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/screens/auth/register/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final RegisterWithEmailAndPasswordUsecase _registerWithEmailAndPasswordUsecase =
      RegisterWithEmailAndPasswordUsecase(getIt());

  final AddNewUserToFiresbaseUsecase _addNewUserToFiresbaseUsecase = AddNewUserToFiresbaseUsecase(getIt());

  // final AppPrefernces _appPrefernces = AppPrefernces(getIt());

  final AppPrefernces _appPrefernces = AppPrefernces(getIt());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? nameErrorMessage;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  bool nameValid = false;
  bool emailValid = false;
  bool passwordValid = false;

  bool isPasswordVisible = true;

  int sliding = 0;

  String firstLanguage = 'Arabic';

  void changeFirstLanguage(String language) {
    firstLanguage = language;
    emit(RegisterChangeLanguageState());
  }

  void changeSliding(int value) {
    sliding = value;
    emit(RegisterChangeImageState());
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterChangePasswordVisibilityState());
  }

  void registerWithEmailAndPassword() async {
    emit(RegisterLoadingState());
    (await _registerWithEmailAndPasswordUsecase.execute(emailController.text, passwordController.text)).fold(
      (failure) {
        emit(RegisterErrorState(failure.message));
      },
      (data1) async {
        (await _addNewUserToFiresbaseUsecase
                .execute(Customer(nameController.text, sliding.toString(), data1, emailController.text, firstLanguage)))
            .fold(
          (failure) {
            emit(RegisterAddNewUserErrorState(failure.message));
          },
          (data2) {
            _appPrefernces.setUserId(data2);
            _appPrefernces.setUserLoggedIn();
            emit(RegisterAddNewUserSuccessState());
          },
        );
        emit(RegisterSuccessState());
      },
    );
  }

  void isNameValid() {
    bool isNameValid = PresentationConstances.isNameValid(nameController.text);
    if (isNameValid) {
      nameErrorMessage = null;
      nameValid = true;
    } else {
      if (nameController.text.length < 5) {
        nameErrorMessage = 'too short';
        emit(RegisterNameValidState());
        return;
      }
      if (nameController.text.length > 15) {
        nameErrorMessage = 'too long';
        emit(RegisterNameValidState());
        return;
      }
      if (nameController.text.startsWith(' ')) {
        nameErrorMessage = 'start with space';
        emit(RegisterNameValidState());
        return;
      }
      if (nameController.text.endsWith(' ')) {
        nameErrorMessage = 'end with spac';
        emit(RegisterNameValidState());
        return;
      }
      if (nameController.text.contains('  ')) {
        nameErrorMessage = 'contains spaces';
      } else {
        nameErrorMessage = 'name not valid';
      }
    }
    emit(RegisterNameValidState());
  }

  void isEmailValid() {
    bool isEmailValid = PresentationConstances.isEmailValid(emailController.text);
    if (isEmailValid) {
      emailErrorMessage = null;
      emailValid = true;
    } else {
      emailErrorMessage = AppStrings.emailNotValid;
    }
    emit(RegisterEmailValidState());
  }

  void isPasswordValid() {
    bool isPasswordValid = PresentationConstances.isPasswordValid(passwordController.text);
    if (isPasswordValid) {
      passwordErrorMessage = null;
      passwordValid = true;
    } else {
      if (passwordController.text.length < 7) {
        passwordErrorMessage = 'too short';
        emit(RegisterPasswordValidState());
        return;
      }
      if (passwordController.text.length > 20) {
        passwordErrorMessage = 'too long';
        emit(RegisterPasswordValidState());
        return;
      }
      if (passwordController.text.startsWith(' ')) {
        passwordErrorMessage = 'start with space';
        emit(RegisterPasswordValidState());
        return;
      }
      if (passwordController.text.endsWith(' ')) {
        passwordErrorMessage = 'end with spac';
        emit(RegisterPasswordValidState());
        return;
      }
      if (passwordController.text.contains('  ')) {
        passwordErrorMessage = 'contains spaces';
      } else {
        passwordErrorMessage = 'password not valid';
      }
    }
    emit(RegisterPasswordValidState());
  }
}
