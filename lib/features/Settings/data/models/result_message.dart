class ResultMessage {
  final String message;

  ResultMessage({required this.message});

  factory ResultMessage.fromJson(Map<String, dynamic> json) {
    return ResultMessage(
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
    };
  }
}
