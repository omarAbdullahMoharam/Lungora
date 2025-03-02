import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Chat/presentation/view/widgets/custom_input_field.dart';
import 'package:lungora/features/Chat/presentation/view/widgets/initial_empty_chat.dart';
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          'Chat with Ai',
          style: Styles.textStyle24,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(),
          )
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty
                      ? InitialEmptyChat()
                      : ListView(
                          children: [
                            // Show message bubbles
                            ...state.messages.map((message) =>
                                ChatMessageBubble(message: message)),

                            // Show typing indicator if needed
                            if (state.isTyping) const LoadingMessageIndicator(),
                          ],
                        ),
                ),
                ChatInputField(
                  promptController: _promptController,
                  scrollController: _scrollController,
                  isLoading: state.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
