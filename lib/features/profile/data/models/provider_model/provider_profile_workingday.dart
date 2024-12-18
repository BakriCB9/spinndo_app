class ProviderProfileWorkingday {
  String? day;
  String? start;
  String? end;

  ProviderProfileWorkingday({this.day, this.start, this.end});

  factory ProviderProfileWorkingday.fromJson(Map<String, dynamic> json) => ProviderProfileWorkingday(
        day: json['day'] as String?,
        start: json['start'] as String?,
        end: json['end'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'start': start,
        'end': end,
      };
}
