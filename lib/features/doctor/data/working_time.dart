class WorkingTime {
  final String day;
  final String from;
  final String to;

  WorkingTime({
    required this.day,
    required this.from,
    required this.to,
  });

  // factory WorkingTime.fromJson(Map<String, dynamic> json) {
  //   return WorkingTime(
  //     day: json['day'],
  //     from: json['from'],
  //     to: json['to'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'day': day,
  //     'from': from,
  //     'to': to,
  //   };
  // }
}
