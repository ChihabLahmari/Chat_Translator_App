import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/constances.dart';
import 'package:chat_translator/presentation/components/font_manager.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:chat_translator/presentation/components/widgets.dart';
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
          appBar: AppBar(
            centerTitle: false,
            title: Text(AppStrings.appName),
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
                          ListView.builder(
                            itemCount: cubit.users.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.all(AppPadding.p12.sp),
                                child: const ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('hello'),
                                  subtitle: Text('calindaflksdjf;al falskd;jfas'),
                                  trailing: Icon(Icons.golf_course),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: cubit.users.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.all(AppPadding.p12.sp),
                                child: const ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('hello'),
                                  subtitle: Text('calindaflksdjf;al falskd;jfas'),
                                  trailing: Icon(Icons.golf_course),
                                ),
                              );
                            },
                          ),
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
            CircleAvatar(
              backgroundColor: user.image == '1' ? ColorManager.purple : ColorManager.blue,
              minRadius: AppSize.s35.sp,
              maxRadius: AppSize.s35.sp,
              child: Center(
                child: Image(image: AssetImage(PresentationConstances.getImage(user.image))),
              ),
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
                    Text(
                      'Last message ....',
                      style: getMeduimStyle(color: ColorManager.darkGrey.withOpacity(0.8)),
                    ),
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
