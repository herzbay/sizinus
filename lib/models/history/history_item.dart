class HistoryItem {
  final String title;
  final String description;
  final int points;
  final DateTime createdAt;

  const HistoryItem({
    required this.title,
    required this.description,
    required this.points,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'points': points,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HistoryItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HistoryItem(
      title: json['title'],
      description: json['description'],
      points: json['points'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
    );
  }
}