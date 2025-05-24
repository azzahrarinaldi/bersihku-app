class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? profilePicture;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.profilePicture,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic>? map) {
    if (map == null) return UserModel(uid: uid);
    return UserModel(
      uid: uid,
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profilePicture: map['profile_picture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profile_picture': profilePicture,
    };
  }
}