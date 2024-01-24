import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:chat_translator/presentation/components/widgets.dart';
import 'package:chat_translator/presentation/screens/auth/register/cubit/register_cubit.dart';
import 'package:chat_translator/presentation/screens/auth/register/cubit/register_states.dart';
import 'package:chat_translator/presentation/screens/main/view/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            errorToast(state.error).show(context);
          }
          if (state is RegisterAddNewUserErrorState) {
            errorToast(state.error).show(context);
          }
          if (state is RegisterAddNewUserSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainView(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorManager.orange),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                AppStrings.signup.toUpperCase(),
                style: getlargeStyle(color: ColorManager.orange),
              ),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p20.sp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppStrings.image,
                          style: getRegularStyle(
                            color: ColorManager.dark,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s5.sp,
                      ),
                      CupertinoSlidingSegmentedControl(
                        children: const {
                          0: Image(image: AssetImage('assets/images/boySticker.png')),
                          1: Image(image: AssetImage('assets/images/girl2Sticker.png')),
                          2: Image(image: AssetImage('assets/images/belliSticker.png')),
                          // 3: Image(image: AssetImage('assets/images/boy2Sticker.png')),
                          // 4: Image(image: AssetImage('assets/images/boy3Sticker.png')),
                          // 1: Image(image: AssetImage('assets/images/girlSticker.png')),
                          // 6: Image(image: AssetImage('assets/images/girl3Sticker.png')),
                        },
                        backgroundColor: ColorManager.whiteGrey,
                        thumbColor: ColorManager.white,
                        groupValue: cubit.sliding,
                        onValueChanged: (int? value) {
                          cubit.changeSliding(value ?? 0);
                        },
                      ),
                      SizedBox(
                        height: AppSize.s20.sp,
                      ),
                      customFormField(
                        textEditingcontroller: cubit.nameController,
                        textLabel: AppStrings.name,
                        errorLabel: cubit.nameErrorMessage,
                        textInputType: TextInputType.name,
                        onChanged: (input) {
                          cubit.isNameValid();
                        },
                      ),
                      SizedBox(
                        height: AppSize.s20.sp,
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
                        height: AppSize.s20.sp,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppStrings.firstLanguage,
                          style: getRegularStyle(
                            color: ColorManager.dark,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s5.sp,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButton(
                          value: cubit.firstLanguage,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: getRegularStyle(color: ColorManager.dark),
                          underline: Container(
                            height: 2.sp,
                            color: ColorManager.orange,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Arabic',
                              child: Text(
                                'Arabic',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'English',
                              child: Text(
                                'English',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'French',
                              child: Text(
                                'French',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Spanish',
                              child: Text(
                                'Spanish',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Japanese',
                              child: Text(
                                'Japanese',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'German',
                              child: Text(
                                'German',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Turkish',
                              child: Text(
                                'Turkish',
                                style: getRegularStyle(color: ColorManager.dark),
                              ),
                            ),
                          ],
                          onChanged: (language) {
                            cubit.changeFirstLanguage(language ?? 'Arabic');
                          },
                        ),
                      ),

                      SizedBox(
                        height: AppSize.s30.sp,
                      ),
                      (state is RegisterLoadingState)
                          ? CircularProgressIndicator(
                              color: ColorManager.orange,
                            )
                          : customElevatodButton(
                              AppStrings.signup.toUpperCase(),
                              (cubit.emailValid && cubit.passwordValid && cubit.nameValid)
                                  ? () {
                                      cubit.registerWithEmailAndPassword();
                                    }
                                  : null,
                            ),

                      // SizedBox(
                      //   height: AppSize.s20.sp,
                      // ),
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
