class CheckInEntity {
  CheckInEntity({
    required this.id,
    required this.date,
    required this.completed,
  });

  final String id;
  final DateTime date;
  final bool completed;

  CheckInEntity copyWith({
    String? id,
    DateTime? date,
    bool? completed,
  }) =>
      CheckInEntity(
        id: id ?? this.id,
        date: date ?? this.date,
        completed: completed ?? this.completed,
      );
}
