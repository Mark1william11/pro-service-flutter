class AppUser {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? bio;
  final DateTime? createdAt;
  final String? profileImageUrl;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.bio,
    this.createdAt,
    this.profileImageUrl,
  });

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? bio,
    DateTime? createdAt,
    String? profileImageUrl,
    bool clearProfileImage = false,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      profileImageUrl: clearProfileImage ? null : (profileImageUrl ?? this.profileImageUrl),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'createdAt': createdAt?.toIso8601String(),
      'profileImageUrl': profileImageUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'],
      bio: map['bio'],
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
      profileImageUrl: map['profileImageUrl'],
    );
  }
}
