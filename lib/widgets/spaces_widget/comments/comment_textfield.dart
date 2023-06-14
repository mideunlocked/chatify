import 'package:chatify/providers/comment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool isFocused = false;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.w,
        right: 3.w,
        bottom: 2.h,
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            focusNode: focusNode,
            cursorColor: const Color.fromARGB(255, 192, 250, 223),
            maxLines: 5,
            minLines: 1,
            style: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              hintText: "Enter your comment",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 192, 250, 223),
                  width: 1.5,
                ),
              ),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            onTap: () => setState(() {
              isFocused = true;
            }),
            onSubmitted: (value) {},
          ),
          isFocused == true
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 1.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor:
                            const Color.fromARGB(255, 192, 250, 223),
                        onPressed: () => postComment(context),
                        label: Text(
                          "Comment",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void postComment(BuildContext context) async {
    var commentProvider = Provider.of<CommentProvider>(context, listen: false);

    await commentProvider.addComment(
      controller.text.trim(),
      widget.id,
    );
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
