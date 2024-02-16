import 'dart:convert';

class Review {
  String? id;
  String? User;
  String? UserName;
  num? Rating;
  String? Description;
  String? createdDate;
  Review({
    this.id,
    this.User,
    this.UserName,
    this.Rating,
    this.Description,
    this.createdDate,
  });

  Review copyWith({
    String? id,
    String? User,
    String? UserName,
    num? Rating,
    String? Description,
    String? createdDate,
  }) {
    return Review(
      id: id ?? this.id,
      User: User ?? this.User,
      UserName: UserName ?? this.UserName,
      Rating: Rating ?? this.Rating,
      Description: Description ?? this.Description,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'User': User,
      'UserName': UserName,
      'Rating': Rating,
      'Description': Description,
      'createdDate': createdDate,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] != null ? map['id'] as String : null,
      User: map['User'] != null ? map['User'] as String : null,
      UserName: map['UserName'] != null ? map['UserName'] as String : null,
      Rating: map['Rating'] != null ? map['Rating'] as num : null,
      Description:
          map['Description'] != null ? map['Description'] as String : null,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(Map<String, dynamic> responseData) {
    return Review(
      id: responseData['_id'],
      User: responseData['User'],
      UserName: responseData['UserName'],
      Rating: responseData['Rating'],
      Description: responseData['Description'],
      createdDate: responseData['createdDate'],
    );
  }

  @override
  String toString() {
    return 'Review(id: $id, User: $User, UserName: $UserName, Rating: $Rating, Description: $Description, createdDate: $createdDate)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.User == User &&
        other.UserName == UserName &&
        other.Rating == Rating &&
        other.Description == Description &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        User.hashCode ^
        UserName.hashCode ^
        Rating.hashCode ^
        Description.hashCode ^
        createdDate.hashCode;
  }
}
