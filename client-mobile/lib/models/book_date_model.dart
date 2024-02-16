import 'dart:convert';

class BookDate {
  DateTime? start;
  DateTime? end;
  BookDate({
    this.start,
    this.end,
  });

  BookDate copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return BookDate(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'start': start?.millisecondsSinceEpoch,
      'end': end?.millisecondsSinceEpoch,
    };
  }

  factory BookDate.fromMap(Map<String, dynamic> map) {
    return BookDate(
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'] as int)
          : null,
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookDate.fromJson(Map<String, dynamic> responseData) {
    return BookDate(
      start: DateTime.parse(responseData['start']),
      end: DateTime.parse(responseData['end']),
    );
  }

  @override
  String toString() => 'BookDate(start: $start, end: $end)';

  @override
  bool operator ==(covariant BookDate other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
