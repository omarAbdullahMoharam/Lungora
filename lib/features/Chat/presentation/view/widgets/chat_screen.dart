import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
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
                    ? Column(
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
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return ChatMessageBubble(
                              message: state.messages[index]);
                        },
                        scrollDirection: Axis.vertical,
                      ),
              ),
              // i need to set a message to be shown if the stat  is loading

              if (state.isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.isLoading ? 'Loading...' : ''),
                ),
              // i need to set a message to be shown if the stat  is loading

              Container(
                padding: EdgeInsets.only(
                  bottom: 8.h,
                  top: 6.h,
                  right: 0,
                  left: 16.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 48.h,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Scrollbar(
                        controller: _scrollController,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        trackVisibility: true,
                        child: TextField(
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
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
