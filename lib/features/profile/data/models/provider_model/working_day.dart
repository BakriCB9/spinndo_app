class WorkingDay {
	String? day;
	String? start;
	String? end;

	WorkingDay({this.day, this.start, this.end});

	factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
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