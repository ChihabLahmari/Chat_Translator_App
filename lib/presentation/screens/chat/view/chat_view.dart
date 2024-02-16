import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/assets_manager.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/constances.dart';
import 'package:chat_translator/presentation/components/strings_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:chat_translator/presentation/components/widgets.dart';
import 'package:chat_translator/presentation/screens/chat/cubit/chat_cubit.dart';
import 'package:chat_translator/presentation/screens/chat/cubit/chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.friendData, required this.myData});

  final Customer friendData;
  final Customer myData;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          // cubit.getMessages(reciverId: widget.friendData.id, myId: widget.myData.id);
          return Scaffold(
            backgroundColor: ColorManager.whiteGrey,
            appBar: AppBar(
              // toolbarHeight: AppSize.s80.sp,
              backgroundColor: ColorManager.white,
              leadingWidth: AppSize.s70.sp,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: widget.friendData.image == '1' ? ColorManager.purple : ColorManager.blue,
                    child: Center(
                      child: Image(image: AssetImage(PresentationConstances.getImage(widget.friendData.image))),
                    ),
                  ),
                  SizedBox(width: AppSize.s12.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.friendData.fullName,
                        style: getRegularStyle(color: ColorManager.dark),
                      ),
                      Text(
                        widget.friendData.firstLanguage,
                        style: getMeduimStyle(color: ColorManager.orange).copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              centerTitle: true,
              elevation: 4,
              shadowColor: ColorManager.grey,
              foregroundColor: ColorManager.white,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert_sharp),
                  onPressed: () {},
                ),
              ],
            ),
            body: Stack(
              children: [
                StreamChatBuilder(cubit: cubit, widget: widget),
                BottomBar(
                  cubit: cubit,
                  friendData: widget.friendData,
                  myId: widget.myData.id,
                  state: state,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StreamChatBuilder extends StatelessWidget {
  const StreamChatBuilder({
    super.key,
    required this.cubit,
    required this.widget,
  });

  final ChatCubit cubit;
  final ChatView widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p100.sp, right: AppPadding.p8.sp, left: AppPadding.p8.sp),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: cubit.getMessagesStream(reciverId: widget.friendData.id, myId: widget.myData.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  List<Message> messagesList = snapshot.data ?? [];
                  if (messagesList == []) {
                    return loadingScreen();
                  } else {
                    return ListView.builder(
                      reverse: true,
                      // controller: cubit.scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        var message = messagesList.reversed.toList()[index];
                        return message.senderId == widget.myData.id
                            ? MyMessageContainer(message: message, cubit: cubit)
                            : FriendMessageContainer(message: message, cubit: cubit);
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  errorToast('Error: ${snapshot.error}').show(context);
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Message> messagesList = snapshot.data ?? [];
                  return ListView.builder(
                    reverse: true,
                    // controller: cubit.scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      var message = messagesList.reversed.toList()[index];
                      return message.senderId == widget.myData.id
                          ? MyMessageContainer(message: message, cubit: cubit)
                          : FriendMessageContainer(message: message, cubit: cubit);
                    },
                  );
                }
              },
            ),
          ),
          KeyboardVisibilityBuilder(
            builder: (p0, isKeyboardVisible) {
              cubit.updateTypingStatus(widget.friendData.id, widget.myData.id, isKeyboardVisible);
              return StreamBuilder(
                stream: cubit.getTypingStatus(widget.friendData.id, widget.myData.id),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return Container(
                      width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      height: AppSize.s70.sp,
                      child: Lottie.asset(LottieAsset.typingOrange),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          )
        ],
      ),

      // child: ListView.builder(
      //   reverse: true,
      //   // controller: cubit.scrollController,
      //   itemCount: cubit.messagesList.length,
      //   itemBuilder: (context, index) {
      //     var message = cubit.messagesList.reversed.toList()[index];
      //     return message.senderId == widget.myData.id
      //         ? MyMessageContainer(message: message, cubit: cubit)
      //         : FriendMessageContainer(message: message, cubit: cubit);
      //   },
      // ),
    );
  }
}

class MyMessageContainer extends StatelessWidget {
  const MyMessageContainer({
    super.key,
    required this.message,
    required this.cubit,
  });

  final Message message;
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              cubit.extractTime(message.dateTime) ?? "",
              style: getSmallStyle(color: ColorManager.dark),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: AppPadding.p6.sp),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppPadding.p12.sp).copyWith(bottomRight: Radius.zero),
                color: ColorManager.orange,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.orange.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxWidth: AppSize.s280.sp,
              ),
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p8.sp),
                child: Text(
                  message.text,
                  style: getMeduimStyle(color: ColorManager.white),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendMessageContainer extends StatelessWidget {
  const FriendMessageContainer({
    super.key,
    required this.message,
    required this.cubit,
  });

  final Message message;
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p8.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppPadding.p12.sp).copyWith(bottomLeft: Radius.zero),
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 5), // Adjust the offset for the bottom shadow
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxWidth: AppSize.s280.sp,
              ),
              // width: AppSize.s300.sp,
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p8.sp),
                child: Text(
                  message.text,
                  style: getMeduimStyle(color: ColorManager.dark),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: AppPadding.p6.sp),
            Text(
              cubit.extractTimeReverse(message.dateTime) ?? "",
              style: getSmallStyle(color: ColorManager.dark),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.cubit,
    required this.friendData,
    required this.myId,
    required this.state,
  });

  final ChatCubit cubit;
  final Customer friendData;
  final String myId;
  final ChatStates state;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: AppSize.s110.sp,
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey,
              blurRadius: 7.0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p14.sp).copyWith(top: AppPadding.p16.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessageFormField(
                cubit: cubit,
                friendData: friendData.id,
                myId: myId,
              ),
              SizedBox(width: AppSize.s10.sp),
              SendButton(
                cubit: cubit,
                friendData: friendData,
                myId: myId,
                state: state,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageFormField extends StatelessWidget {
  const MessageFormField({
    super.key,
    required this.cubit,
    required this.friendData,
    required this.myId,
  });

  final ChatCubit cubit;
  final String friendData;
  final String myId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: cubit.messageController,
        keyboardType: TextInputType.text,
        cursorColor: ColorManager.orange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: AppPadding.p20.sp, horizontal: AppPadding.p10.sp),
          prefixIcon: Icon(
            Icons.emoji_emotions_outlined,
            color: ColorManager.dark.withOpacity(0.5),
          ),
          filled: true,
          fillColor: ColorManager.whiteGrey,
          label: Text(AppStrings.typeAMessage),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: getRegularStyle(
            color: ColorManager.dark.withOpacity(0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p12.sp),
            borderSide: BorderSide(
              color: ColorManager.whiteGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p12.sp),
            borderSide: BorderSide(
              color: ColorManager.orange,
            ),
          ),
        ),
        // onChanged: (value) {
        //   cubit.updateTypingStatus(friendData, myId, true);
        // },
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  const SendButton({
    super.key,
    required this.cubit,
    required this.friendData,
    required this.myId,
    required this.state,
  });

  final ChatCubit cubit;
  final Customer friendData;
  final String myId;
  final ChatStates state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cubit.sendMessage(friendData.id, friendData.firstLanguage, myId);
      },
      child: Container(
        width: AppSize.s60.sp,
        height: AppSize.s60.sp,
        decoration: BoxDecoration(
          color: ColorManager.whiteOrange,
          borderRadius: BorderRadius.circular(AppPadding.p12),
        ),
        child: Center(
          child: state is ChatSendMessagesLoadingState
              ? CircularProgressIndicator(color: ColorManager.orange)
              : Icon(
                  Icons.send_rounded,
                  size: AppSize.s30.sp,
                ),
        ),
      ),
    );
  }
}
