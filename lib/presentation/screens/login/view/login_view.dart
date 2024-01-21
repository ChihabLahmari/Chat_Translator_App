import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:chat_translator/presentation/components/widgets.dart';
import 'package:chat_translator/presentation/screens/login/cubit/login_cubit.dart';
import 'package:chat_translator/presentation/screens/login/cubit/login_state.dart';
import 'package:chat_translator/presentation/screens/main/view/main_view.dart';
import 'package:chat_translator/presentation/screens/register/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            errorToast(state.error).show(context);
          }
          if (state is LoginSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainView(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p20.sp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: AppSize.s20.sp,
                      ),
                      SizedBox(
                        height: AppSize.s300.sp,
                        width: AppSize.s300.sp,
                        child: const Image(
                          image: AssetImage('assets/images/message.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        AppStrings.signin.toUpperCase(),
                        style: getlargeStyle(color: ColorManager.orange),
                      ),
                      SizedBox(
                        height: AppSize.s50.sp,
                      ),
                      customFormField(
                        textEditingcontroller: cubit.emailController,
                        textLabel: AppStrings.emailLabel,
                        errorLabel: cubit.emailErrorMessage,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (value) {
                          cubit.isEmailValid();
                        },
                      ),
                      SizedBox(
                        height: AppSize.s20.sp,
                      ),
                      customPasswordFormField(
                        textEditingcontroller: cubit.passwordController,
                        textLabel: AppStrings.passwordLabel,
                        errorLabel: cubit.passwordErrorMessage,
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          cubit.isPasswordValid();
                        },
                        onVisibleChanged: () {
                          cubit.changePasswordVisibility();
                        },
                        isPasswordVisible: cubit.isPasswordVisible,
                      ),
                      SizedBox(
                        height: AppSize.s50.sp,
                      ),
                      // state is LoginLoadingState
                      //     ? CircularProgressIndicator(
                      //         color: ColorManager.blue,
                      //       )
                      //     :
                      (state is LoginLoadingState)
                          ? CircularProgressIndicator(
                              color: ColorManager.orange,
                            )
                          : customElevatodButton(
                              AppStrings.signin.toUpperCase(),
                              (cubit.emailValid && cubit.passwordValid)
                                  ? () {
                                      cubit.loginWithEmailAndPassowrd();
                                    }
                                  : null,
                            ),
                      SizedBox(
                        height: AppSize.s20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyHaveAnAcounte,
                            style: getMeduimStyle(color: ColorManager.dark),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
                                  ));
                            },
                            child: Text(
                              AppStrings.signup,
                              style: getMeduimStyle(color: ColorManager.orange),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s40.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
