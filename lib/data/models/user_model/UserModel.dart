
class UserModel {
  final String id;
  String username;
  final String email;
  final String phoneNumber;
  String photoUrl;
  bool verified;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber = '',
    this.photoUrl = '', // Default image URL
    this.verified = true, // Default to false
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'verified': verified,
    };
  }

  // Create a UserModel from FireStore Document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      verified: map['verified'] ?? true, // Ensure verified field is properly handled
    );
  }
}
