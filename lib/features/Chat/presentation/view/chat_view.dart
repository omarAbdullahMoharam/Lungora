import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Chat/data/open_router_service.dart';
import 'package:lungora/features/Chat/presentation/view/widgets/chat_screen.dart';
import 'package:lungora/features/Chat/presentation/view_model/chat_cubit/chat_cubit.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        openRouterService: OpenRouterService(),
      ),
      child: const ChatScreen(),
    );
  }
}
