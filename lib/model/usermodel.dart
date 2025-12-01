class User {
  final String id;
  final String username;
  final String email;
  final String? profileImage; // optional

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
  });

  // Factory constructor to create a User from JSON (from backend)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'], // can be null
    );
  }

  // Convert User to JSON (for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'profileImage': profileImage,
    };
  }
}
