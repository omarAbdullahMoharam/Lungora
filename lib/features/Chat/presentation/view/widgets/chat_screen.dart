import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Chat/data/models/message_model.dart';
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
  final ScrollController _screenController = ScrollController();

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _screenController.animateTo(
          _screenController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          'Chat with AI',
          style: Styles.textStyle24,
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatSuccess) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          Widget chatContent;

          if (state is ChatInitial) {
            chatContent = const InitialEmptyChat();
          } else if (state is ChatLoading) {
            chatContent = const Center(child: CircularProgressIndicator());
          } else if (state is ChatFailure) {
            chatContent = ChatMessageBubble(
              message: ChatMessage(
                role: 'assistant',
                content: state.errorMessage,
                timestamp: DateTime.now(),
              ),
            );
          } else if (state is ChatSuccess) {
            chatContent = Scrollbar(
              trackVisibility: false,
              child: ListView.builder(
                controller: _screenController,
                itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.messages.length) {
                    return ChatMessageBubble(
                      message: state.messages[index],
                    );
                  } else {
                    return const LoadingMessageIndicator();
                  }
                },
              ),
            );
          } else {
            chatContent = const SizedBox();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(child: chatContent),
                ChatInputField(
                  promptController: _promptController,
                  scrollController: _scrollController,
                  isLoading: state is ChatLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
