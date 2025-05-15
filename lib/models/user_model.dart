class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? profilePicture;

  UserModel({required this.uid, required this.name, required this.email, required this.profilePicture});

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profile_picture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profile_picture': profilePicture
    };
  }
}