class WorkingHours {
  // final int id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int doctorId;

  WorkingHours({
    // required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.doctorId,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      // id: json['id'] ?? 0,
      dayOfWeek: json['dayOfWeek'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      doctorId: json['doctorId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'doctorId': doctorId,
    };
  }

  String get formattedTime {
    return '$startTime - $endTime';
  }
}
