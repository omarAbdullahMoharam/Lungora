import 'package:equatable/equatable.dart';
import 'package:lungora/features/Chat/data/models/message_model.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final bool isTyping;
  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.isTyping = false,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    bool? isTyping,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error, isTyping];
}
