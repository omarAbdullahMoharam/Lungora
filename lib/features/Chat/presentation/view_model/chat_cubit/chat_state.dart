import 'package:lungora/features/Chat/data/models/message_model.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;

  ChatSuccess({required this.messages, this.isTyping = false});
}

final class ChatFailure extends ChatState {
  final String errorMessage;

  ChatFailure({required this.errorMessage});
}
