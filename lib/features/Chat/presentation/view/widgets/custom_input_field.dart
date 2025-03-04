import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Chat/presentation/view_model/chat_cubit/chat_cubit.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController promptController;
  final ScrollController scrollController;
  final bool isLoading;

  const ChatInputField({
    super.key,
    required this.promptController,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 6.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 48.h,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Scrollbar(
              controller: widget.scrollController,
              scrollbarOrientation: ScrollbarOrientation.right,
              trackVisibility: true,
              child: TextField(
                enableSuggestions: true,
                autocorrect: true,
                onChanged: (value) {
                  setState(() {
                    widget.promptController.text = value;
                  });
                  widget.scrollController.jumpTo(
                    widget.scrollController.position.maxScrollExtent,
                  );
                },
                scrollController: widget.scrollController,
                maxLines: null,
                minLines: 1,
                enabled: !widget.isLoading,
                controller: widget.promptController,
                decoration: InputDecoration(
                  // get the current theme
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  hintText: 'Type your message...',
                  hintStyle: Styles.textStyle12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icon/SendIconButton.svg',
              colorFilter: ColorFilter.mode(
                widget.isLoading || widget.promptController.text.isEmpty
                    ? Colors.grey
                    : Colors.white,
                BlendMode.srcIn,
              ),
              height: 24.h,
              width: 24.w,
            ),
            onPressed: () {
              if (widget.promptController.text.isNotEmpty) {
                context
                    .read<ChatCubit>()
                    .sendMessage(widget.promptController.text);
                widget.promptController.clear();
              }
              FocusScope.of(context).unfocus();
              widget.scrollController.jumpTo(
                widget.scrollController.position.maxScrollExtent,
              );
              widget.scrollController.animateTo(
                widget.scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
              setState(() {
                widget.promptController.clear();
              });
            },
            style: widget.isLoading || widget.promptController.text.isEmpty
                ? null
                : IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: kSecondaryColor,
                    foregroundColor: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
