import 'dart:ui';

import 'package:chatify/helpers/gc_status.dart';
import 'package:chatify/models/group_chat.dart';
import 'package:chatify/providers/group_chatting.dart';
import 'package:chatify/widgets/create_group_widget/create_group_textfield.dart';
import 'package:chatify/widgets/general_widget/custom_back_button.dart';
import 'package:chatify/widgets/general_widget/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../home_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final nameNode = FocusNode();
  final descriptionNode = FocusNode();

  bool isPublic = true;

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    descriptionController.dispose();

    nameNode.dispose();
    descriptionNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CreateGroupAppBar(),
                  SizedBox(
                    height: 3.h,
                  ),
                  CreateGroupTextFeild(
                    inputAction: TextInputAction.next,
                    controller: nameController,
                    node: nameNode,
                    newNode: descriptionNode,
                    hint: "Enter group title",
                    label: "Title",
                    maxText: 25,
                  ),
                  CreateGroupTextFeild(
                    inputAction: TextInputAction.newline,
                    inputType: TextInputType.multiline,
                    controller: descriptionController,
                    node: descriptionNode,
                    newNode: descriptionNode,
                    hint: "Enter group about",
                    label: "About",
                    maxText: 70,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      VisibilityHintText(
                        isPublic: isPublic,
                        of: of,
                      ),
                      Switch(
                        activeColor: of.indicatorColor,
                        inactiveTrackColor: Colors.white38,
                        value: isPublic,
                        onChanged: (newValue) {
                          setState(() {
                            isPublic = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  CreateGroupButton(
                    of: of,
                    function: () => createGroup(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => LoadingDialog(context: context),
    );
  }

  void createGroup() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid == false) {
      return;
    } else {
      showLoadingDialog();
      var groupChatProvider =
          Provider.of<GroupChatting>(context, listen: false);
      var authInstance = groupChatProvider.authInstance;
      String? uid = authInstance.currentUser?.uid;

      var response = await groupChatProvider.createGroupChat(
        ListGroupChat(
          id: "",
          about: {
            "name": nameController.text.trim(),
            "description": descriptionController.text.trim(),
            "createdBy": uid,
            "createdOn": Timestamp.now(),
            "imageUrl": "",
            "isPublic": isPublic,
          },
          requests: [],
          recipients: [uid],
          chats: [],
          admins: [uid],
          timestamp: Timestamp.now(),
        ),
      );

      if (response != true) {
        if (mounted) {
          Navigator.pop(context);
        }
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => const HomeScreen(),
              ),
              (route) => false);
        }
      }
    }
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).primaryColor,
          child: SizedBox(
            height: 20.h,
            width: 40.w,
            child: const Center(
              child: CustomProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({
    super.key,
    required this.of,
    required this.function,
  });

  final ThemeData of;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        height: 7.5.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: of.indicatorColor,
          borderRadius: BorderRadius.circular(50),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
        ),
        alignment: Alignment.center,
        child: Text(
          "Create group",
          style: TextStyle(
            color: of.primaryColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}

class VisibilityHintText extends StatelessWidget {
  const VisibilityHintText({
    super.key,
    required this.isPublic,
    required this.of,
  });

  final bool isPublic;
  final ThemeData of;

  @override
  Widget build(BuildContext context) {
    String privateHint =
        "Keep conversations private and exclusive with our secure and personalized private group chat feature.";
    String publicHint =
        "Connect and collaborate with a diverse community in our public group chat feature.";
    var textTheme = of.textTheme;

    return Flexible(
      child: ListTile(
        title: Row(
          children: [
            const Text(
              "Visibility settings",
            ),
            SizedBox(
              width: 3.w,
            ),
            isPublic == true ? openImage : lockedImage,
          ],
        ),
        subtitle: Text(
          isPublic == true ? publicHint : privateHint,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white38,
            fontSize: 8.sp,
          ),
        ),
      ),
    );
  }
}

class CreateGroupAppBar extends StatelessWidget {
  const CreateGroupAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomBackButton(),
        SizedBox(
          width: 5.w,
        ),
        Text(
          "New group",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
