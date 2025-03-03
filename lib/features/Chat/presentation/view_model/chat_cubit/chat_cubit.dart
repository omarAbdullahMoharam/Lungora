import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Chat/data/models/message_model.dart';
import 'package:lungora/features/Chat/data/open_router_service.dart';
import 'package:lungora/features/Chat/presentation/view_model/chat_cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final OpenRouterService _openRouterService;
  List<ChatMessage> messages = [];

  ChatCubit({required OpenRouterService openRouterService})
      : _openRouterService = openRouterService,
        super(ChatInitial());

  void sendMessage(String content) async {
    if (content.isEmpty || state is ChatLoading) return;

    final userMessage = ChatMessage(role: 'user', content: content);
    messages.add(userMessage);

    emit(
      ChatSuccess(
        messages: List.from(messages),
        isTyping: true,
      ),
    );

    try {
      final messagesJson = messages.map((msg) => msg.toJson()).toList();

      final response = await _openRouterService.generateChatCompletion(
        messages: messagesJson,
        additionalParams: {'temperature': 0.7, 'max_tokens': 800},
      );

      final assistantMessage = ChatMessage(
        role: 'assistant',
        content: _openRouterService.extractCompletionText(response),
      );

      messages.add(assistantMessage);
      emit(ChatSuccess(messages: List.from(messages), isTyping: false));
    } catch (e) {
      emit(
        ChatFailure(
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void clearChat() {
    messages.clear();
    emit(ChatInitial());
  }
}
