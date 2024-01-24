import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/core/services/shared_prefrences.dart';
import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/assets_manager.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:chat_translator/presentation/components/widgets.dart';
import 'package:chat_translator/presentation/screens/auth/login/view/login_view.dart';
import 'package:chat_translator/presentation/screens/auth/register/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final AppPrefernces _appPrefernces = AppPrefernces(getIt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p12.sp),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(ImageAsset.message),
              ),
              SizedBox(
                width: AppSize.s250.sp,
                child: Text(
                  AppStrings.onBoradingMessage,
                  style: getlargeStyle(
                    color: ColorManager.dark.withOpacity(0.8),
                  ).copyWith(fontSize: 35),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSize.s18.sp),
              Text(
                AppStrings.onBoradingDescription,
                textAlign: TextAlign.center,
                style: getMeduimStyle(color: ColorManager.darkGrey.withOpacity(0.5)),
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: AppSize.s25.sp),
              customElevatodButton(
                AppStrings.onBoradingLetGetStarted,
                () {
                  _appPrefernces.setUserWatchOnBoarding();

                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s18.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAnAcounte,
                    style: getMeduimStyle(color: ColorManager.dark),
                  ),
                  TextButton(
                    onPressed: () {
                      _appPrefernces.setUserWatchOnBoarding();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      AppStrings.signin,
                      style: getMeduimStyle(color: ColorManager.orange),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
