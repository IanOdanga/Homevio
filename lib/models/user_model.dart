class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? username;
  String? phoneNumber;

  UserModel({this.uid, this.email, this.fullName, this.username, this.phoneNumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}
