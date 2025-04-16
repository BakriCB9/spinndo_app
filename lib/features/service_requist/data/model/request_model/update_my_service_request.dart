class MyServiceRequest {
  final String title;
  final String desCription;
  final double price;
  final int dayDuration;
  final int? id;
  
  MyServiceRequest({
    required this.desCription,
    required this.dayDuration,
    required this.price,
    required this.title,
  
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": desCription,
      "price": price,
      "days_duration": dayDuration,
      
    };
  }
}
