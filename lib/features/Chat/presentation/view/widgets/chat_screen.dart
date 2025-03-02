import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Chat/presentation/view/widgets/loading_message.dart';
import 'package:lungora/features/Chat/presentation/view/widgets/message_bubble.dart';
import 'package:lungora/features/Chat/presentation/view_model/chat_cubit/chat_cubit.dart';
import 'package:lungora/features/Chat/presentation/view_model/chat_cubit/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat Bot'),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: state.messages.isEmpty
                    ? InitialEmptyChat()
                    : ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        children: [
                          // Show message bubbles
                          ...state.messages.map(
                              (message) => ChatMessageBubble(message: message)),

                          // Show typing indicator if needed
                          if (state.isTyping) const LoadingMessageIndicator(),
                        ],
                      ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 16.w,
                  left: 16.w,
                  top: 6.h,
                  bottom: 16.h,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 48.h,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Scrollbar(
                        controller: _scrollController,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        trackVisibility: true,
                        child: TextField(
                          enableSuggestions: true,
                          autocorrect: true,
                          onChanged: (value) {
                            setState(() {
                              _promptController.text = value;
                            });
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
                            );
                          },
                          scrollController: _scrollController,
                          maxLines: null,
                          minLines: 1,
                          enabled: !state.isLoading,
                          controller: _promptController,
                          decoration: InputDecoration(
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
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_promptController.text.isNotEmpty) {
                          context
                              .read<ChatCubit>()
                              .sendMessage(_promptController.text);
                          _promptController.clear();
                        }
                        FocusScope.of(context).unfocus();
                        _scrollController.jumpTo(
                          _scrollController.position.maxScrollExtent,
                        );
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                        setState(() {
                          _promptController.clear();
                        });
                      },
                      style: state.isLoading || _promptController.text.isEmpty
                          ? null
                          : IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: kSecondaryColor,
                              foregroundColor: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InitialEmptyChat extends StatelessWidget {
  const InitialEmptyChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/images/animatedRobot.json",
          width: 300,
          height: 200,
        ),
        Text(
          'Feel free to ask what you want 🥰',
          style: Styles.textStyle20,
        ),
      ],
    );
  }
}
