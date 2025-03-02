import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Chat/data/models/message_model.dart';
import 'package:lungora/features/Chat/data/open_router_service.dart';
import 'package:lungora/features/Chat/presentation/view_model/chat_cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final OpenRouterService _openRouterService;

  ChatCubit({required OpenRouterService openRouterService})
      : _openRouterService = openRouterService,
        super(const ChatState());

  void sendMessage(String content) async {
    if (content.isEmpty || state.isLoading) return;

    // Create user message
    final userMessage = ChatMessage(
      role: 'user',
      content: content,
    );

    // Update state with user message and loading status
    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    ));

    try {
      // Prepare messages for API request
      final messages = state.messages.map((msg) => msg.toJson()).toList();

      // Call API
      final response = await _openRouterService.generateChatCompletion(
        messages: messages,
        additionalParams: {
          'temperature': 0.7,
          'max_tokens': 800,
        },
      );

      // Create assistant message from response
      final assistantMessage = ChatMessage(
        role: 'assistant',
        content: _openRouterService.extractCompletionText(response),
      );

      // Update state with assistant response and turn off loading
      emit(state.copyWith(
        messages: [...state.messages, assistantMessage],
        isLoading: false,
      ));
    } catch (e) {
      // Handle error
      final errorMessage = ChatMessage(
        role: 'system',
        content: 'Error: $e',
      );

      emit(state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void clearChat() {
    emit(const ChatState());
  }
}
