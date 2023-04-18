class Event{
  final String title;

  Event({
    required this.title
  });

  String toString() => this.title;

  Map<String, dynamic> toJson() => {
    'title': this.title
  };

  Event.fromJson(Map<String, dynamic> json)
      : title = json['title'];
}