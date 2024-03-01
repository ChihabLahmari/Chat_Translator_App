import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/assets_manager.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/constances.dart';
import 'package:chat_translator/presentation/components/font_manager.dart';
import 'package:chat_translator/presentation/components/page_transition.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:chat_translator/presentation/components/widgets.dart';
import 'package:chat_translator/presentation/screens/auth/login/view/login_view.dart';
import 'package:chat_translator/presentation/screens/chat/view/chat_view.dart';
import 'package:chat_translator/presentation/screens/main/cubit/main_cubit.dart';
import 'package:chat_translator/presentation/screens/main/cubit/main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        MainCubit.get(context).changeLogoAlignment();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: ColorManager.white,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.dark),
        centerTitle: false,
        title: Text(AppStrings.appName),
        actions: [
          const EndDrawerButton(),
          SizedBox(width: AppSize.s5.sp),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p16.sp).copyWith(top: AppPadding.p8.sp),
        child: Column(
          children: [
            TabBarContainer(tabController: tabController),
            Expanded(
              child: Stack(
                children: [
                  TabBarView(
                    controller: tabController,
                    children: [
                      const UserListview(),
                      const OnlineUserListview(),
                      loadingScreen(),
                    ],
                  ),
                  BlocBuilder<MainCubit, MainStates>(
                    buildWhen: (previous, current) => current is MainChangeLogoAlignmentState,
                    builder: (context, state) {
                      var cubit = MainCubit.get(context);
                      return SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            cubit.changeLogoAlignment();
                          },
                          child: AnimatedAlign(
                            duration: const Duration(seconds: 1),
                            alignment: cubit.alignment,
                            // curve: Curves.decelerate,
                            // curve: Curves.bounceOut,
                            curve: Curves.elasticIn,
                            // curve: Curves.elasticInOut,
                            child: SizedBox(
                              width: AppSize.s70.sp,
                              child: const Image(
                                image: AssetImage(ImageAsset.gdgLogo),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      buildWhen: (previous, current) {
        return current is MainGetMyUserState;
      },
      listener: (context, state) {},
      builder: ((context, state) {
        var cubit = MainCubit.get(context);
        return Drawer(
          backgroundColor: ColorManager.white,
          child: SafeArea(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: PresentationConstances.getImageColor(cubit.user?.image ?? '1'),
                  minRadius: AppSize.s50.sp,
                  maxRadius: AppSize.s50.sp,
                  child: Center(
                    child: Image(image: AssetImage(PresentationConstances.getImage(cubit.user?.image ?? '1'))),
                  ),
                ),
                SizedBox(height: AppSize.s15.sp),
                Text(
                  cubit.user?.fullName ?? '',
                  style: getlargeStyle(color: ColorManager.dark),
                ),
                SizedBox(height: AppSize.s10.sp),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return logoutDialog(context, cubit);
                      },
                    );
                  },
                  leading: Icon(
                    Icons.logout_outlined,
                    color: ColorManager.dark,
                  ),
                  title: Text(
                    AppStrings.logout,
                    style: getMeduimStyle(color: ColorManager.dark),
                  ),
                ),
                SizedBox(height: AppSize.s10.sp),
                ListTile(
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: ColorManager.dark,
                  ),
                  title: Text(
                    AppStrings.darkLightMode,
                    style: getMeduimStyle(color: ColorManager.dark),
                  ),
                ),
                SizedBox(height: AppSize.s10.sp),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: ColorManager.dark,
                  ),
                  title: Text(
                    AppStrings.settings,
                    style: getMeduimStyle(color: ColorManager.dark),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TabBarContainer extends StatelessWidget {
  const TabBarContainer({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s60.sp,
      decoration: BoxDecoration(
        color: ColorManager.whiteOrange,
        borderRadius: BorderRadius.circular(AppPadding.p12.sp),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(AppPadding.p6.sp),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p12.sp),
          color: ColorManager.orange,
        ),
        controller: tabController,
        // labelPadding: EdgeInsets.symmetric(horizontal: AppPadding.p30.sp),
        labelColor: ColorManager.white,
        unselectedLabelColor: ColorManager.orange,
        tabs: const [
          Tab(
              child: Text(
            'Chat',
            style: TextStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.medium,
            ),
          )),
          Tab(
              child: Text(
            'Status',
            style: TextStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.medium,
            ),
          )),
          Tab(
              child: Text(
            'Calls',
            style: TextStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.medium,
            ),
          )),
        ],
      ),
    );
  }
}

class UserListview extends StatelessWidget {
  const UserListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      buildWhen: (previous, current) {
        return previous is MainGetAllUsersLoadingState ||
            previous is MainGetAllUsersSuccessState ||
            previous is MainGetAllUsersErrorState ||
            current is MainGetAllUsersLoadingState ||
            current is MainGetAllUsersSuccessState ||
            current is MainGetAllUsersErrorState;
      },
      listener: (context, state) {
        if (state is MainGetAllUsersErrorState) {
          errorToast(state.error).show(context);
        }
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return (state is MainGetAllUsersLoadingState)
            ? loadingScreen()
            : ListView.builder(
                itemCount: cubit.users.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var user = cubit.users[index];
                  return UserListtile(
                    user: user,
                    cubit: cubit,
                  );
                },
              );
      },
    );
  }
}

class OnlineUserListview extends StatelessWidget {
  const OnlineUserListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('build OnlineUserListview');
    return BlocConsumer<MainCubit, MainStates>(
      buildWhen: (previous, current) {
        return previous is MainGetAllUsersLoadingState ||
            previous is MainGetAllUsersSuccessState ||
            previous is MainGetAllUsersErrorState ||
            current is MainGetAllUsersLoadingState ||
            current is MainGetAllUsersSuccessState ||
            current is MainGetAllUsersErrorState ||
            current is MainAddOnlineUserState;
      },
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return (state is MainGetAllUsersLoadingState)
            ? loadingScreen()
            : ListView.builder(
                itemCount: cubit.onlineUsers.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var user = cubit.onlineUsers[index];
                  return UserListtile(
                    user: user,
                    cubit: cubit,
                  );
                },
              );
      },
    );
  }
}

class UserListtile extends StatelessWidget {
  const UserListtile({
    super.key,
    required this.user,
    required this.cubit,
  });

  final Customer user;
  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (cubit.user != null) {
          Navigator.push(
            context,
            CustomPageTransition(
              alignment: cubit.alignment,
              widget: ChatView(
                friendData: user,
                myData: cubit.user!,
              ),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppPadding.p12.sp),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FadeInLeft(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: PresentationConstances.getImageColor(user.image),
                    minRadius: AppSize.s35.sp,
                    maxRadius: AppSize.s35.sp,
                    child: Center(
                      child: Image(image: AssetImage(PresentationConstances.getImage(user.image))),
                    ),
                  ),
                  StreamBuilder(
                    stream: cubit.getIsUserOnline(user.id),
                    builder: (context, snapshot) {
                      if (snapshot.data == true) {
                        cubit.addOnlineUser(user.id);
                        return Container(
                          width: AppSize.s20.sp,
                          height: AppSize.s20.sp,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppPadding.p12.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppPadding.p2.sp),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.green,
                                borderRadius: BorderRadius.circular(AppPadding.p12.sp),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppSize.s15.sp,
            ),
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FadeInRight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.fullName,
                              style: getRegularStyle(color: ColorManager.dark),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.language_sharp,
                                  size: AppSize.s18.sp,
                                ),
                                SizedBox(width: AppPadding.p4.sp),
                                Text(
                                  user.firstLanguage,
                                  style: getMeduimStyle(color: ColorManager.dark).copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s5.sp,
                      ),
                      StreamBuilder<Message>(
                        stream: cubit.getLastMessage(user.id, cubit.myId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
                          } else if (snapshot.hasError) {
                            errorToast('Error: ${snapshot.error}').show(context);
                            return Text('Error: ${snapshot.error}');
                          } else {
                            Message? lastMessage = snapshot.data;
                            if (lastMessage != null) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child: FadeInRight(
                                      child: Text(
                                        lastMessage.text == '' ? 'No messages' : lastMessage.text,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: getMeduimStyle(color: ColorManager.darkGrey.withOpacity(0.8)),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: FadeInRight(
                                      child: Text(
                                        lastMessage.dateTime == '' ? "" : cubit.extractTime(lastMessage.dateTime),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: getMeduimStyle(color: ColorManager.dark)
                                            .copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Text('Last message not available');
                            }
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s15.sp,
                  ),
                  Container(
                    height: AppSize.s1.sp,
                    // width: AppSize.s310.sp,
                    color: ColorManager.grey.withOpacity(0.8),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget logoutDialog(BuildContext context, MainCubit cubit) {
  return AlertDialog(
    backgroundColor: ColorManager.white,
    // shadowColor: ColorManager.orange.withOpacity(0.5),
    content: SizedBox(
      height: AppSize.s120.sp,
      // width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.logoutMessage,
            style: getRegularStyle(color: ColorManager.dark).copyWith(overflow: TextOverflow.visible),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppPadding.p12),
                      color: ColorManager.orange,
                    ),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(AppPadding.p10.sp),
                      child: Text(
                        AppStrings.cencel,
                        style: getMeduimStyle(color: ColorManager.white),
                      ),
                    )),
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s20),
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppPadding.p12),
                      color: ColorManager.orange,
                    ),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(AppPadding.p10.sp),
                      child: Text(
                        AppStrings.logout,
                        style: getMeduimStyle(color: ColorManager.white),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
