// ignore_for_file: prefer_final_fields

import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/core/services/shared_prefrences.dart';
import 'package:chat_translator/domain/usecase/login_with_email_password_usecase.dart';
import 'package:chat_translator/presentation/components/constances.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/screens/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginWithEmailAndPassowrdUsecase loginWithEmailAndPassowrdUsecase = LoginWithEmailAndPassowrdUsecase(getIt());

  AppPrefernces _appPrefernces = AppPrefernces(getIt());

  String? emailErrorMessage;
  String? passwordErrorMessage;
  bool emailValid = false;
  bool passwordValid = false;

  bool isPasswordVisible = true;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginChangePasswordVisibilityState());
  }

  void loginWithEmailAndPassowrd() async {
    emit(LoginLoadingState());
    (await loginWithEmailAndPassowrdUsecase.execute(emailController.text, passwordController.text)).fold(
      (failure) {
        emit(LoginErrorState(failure.message));
      },
      (data) {
        _appPrefernces.setUserId(data);
        _appPrefernces.setUserLoggedIn();
        emit(LoginSuccessState());
      },
    );
  }

  void isEmailValid() {
    bool isEmailValid = PresentationConstances.isEmailValid(emailController.text);
    if (isEmailValid) {
      emailErrorMessage = null;
      emailValid = true;
    } else {
      emailErrorMessage = AppStrings.emailNotValid;
    }
    emit(LoginIsEmailValidState());
  }

  void isPasswordValid() {
    bool isPasswordValid = PresentationConstances.isPasswordValid(passwordController.text);
    if (isPasswordValid) {
      passwordErrorMessage = null;
      passwordValid = true;
    } else {
      if (passwordController.text.length < 7) {
        passwordErrorMessage = 'too short';
        emit(LoginIsPasswordValidState());
        return;
      }
      if (passwordController.text.length > 20) {
        passwordErrorMessage = 'too long';
        emit(LoginIsPasswordValidState());
        return;
      }
      if (passwordController.text.startsWith(' ')) {
        passwordErrorMessage = 'start with space';
        emit(LoginIsPasswordValidState());
        return;
      }
      if (passwordController.text.endsWith(' ')) {
        passwordErrorMessage = 'end with spac';
        emit(LoginIsPasswordValidState());
        return;
      }
      if (passwordController.text.contains('  ')) {
        passwordErrorMessage = 'contains spaces';
      } else {
        passwordErrorMessage = 'password not valid';
      }
    }
    emit(LoginIsPasswordValidState());
  }
}
