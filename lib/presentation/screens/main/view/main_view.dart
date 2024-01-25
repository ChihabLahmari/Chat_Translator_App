import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/constances.dart';
import 'package:chat_translator/presentation/components/font_manager.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is MainGetAllUsersErrorState) {
          errorToast(state.error).show(context);
        }
      },
      builder: (context, state) {
        TabController tabController = TabController(length: 3, vsync: this);
        var cubit = MainCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          drawer: CustomDrawer(cubit: cubit),
          appBar: AppBar(
            centerTitle: false,
            title: Text(AppStrings.appName),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_outlined),
                color: ColorManager.dark,
              ),
              const DrawerButton(),

              // IconButton(
              //   onPressed: () {
              //     const Drawer();
              //   },
              //   icon: const Icon(Icons.menu_outlined),
              //   color: ColorManager.dark,
              // ),
            ],
          ),
          body: (state is MainGetAllUsersLoadingState)
              ? loadingScreen()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppPadding.p10.sp).copyWith(bottom: 2),
                      child: Card(child: TabBarContainer(tabController: tabController)),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          UserListview(cubit: cubit),
                          loadingScreen(),
                          loadingScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  return removeTasksDialog(context, cubit);
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
    ));
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
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(AppPadding.p6.sp),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p12.sp),
          color: ColorManager.orange,
        ),
        controller: tabController,
        labelPadding: EdgeInsets.symmetric(horizontal: AppPadding.p30.sp),
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
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              MaterialPageRoute(
                builder: (context) => ChatView(
                  friendData: user,
                  myData: cubit.user!,
                ),
              ));
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppPadding.p8.sp).copyWith(bottom: AppPadding.p12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
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
                    return snapshot.data == true
                        ? Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(AppPadding.p12.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppSize.s2.sp),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.green,
                                  borderRadius: BorderRadius.circular(AppPadding.p12.sp),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
            SizedBox(
              width: AppSize.s15.sp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppSize.s300.sp,
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
                                style: getMeduimStyle(color: ColorManager.dark),
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
                              children: [
                                // Text()
                                SizedBox(
                                  width: AppSize.s300.sp,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Text(
                                          lastMessage.text == '' ? 'No messages' : lastMessage.text,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: getMeduimStyle(color: ColorManager.darkGrey.withOpacity(0.8)),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          lastMessage.dateTime == '' ? "" : cubit.extractTime(lastMessage.dateTime),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: getMeduimStyle(color: ColorManager.dark),
                                        ),
                                      ),
                                    ],
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
                  width: AppSize.s310.sp,
                  color: ColorManager.grey.withOpacity(0.8),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget removeTasksDialog(BuildContext context, MainCubit cubit) {
  return AlertDialog(
    backgroundColor: ColorManager.white,
    shadowColor: ColorManager.orange.withOpacity(0.5),
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
