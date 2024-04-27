class UserModel {
  final String? userId;
  final String? userName;
  final String email;
  final String? password;

  UserModel({
    this.userId,
    this.userName,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'User_Name': userName,
      'User_Id': userId,
      'User_Email': email,
      // 'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['User_Id'] != null ? map['User_Id'] as String : null,
      userName: map['User_Name'] != null ? map['User_Name'] as String : null,
      email: map['User_Email'] as String,
      // password: map['password'] != null ? map['password'] as String : null,
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userName == userName &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}
