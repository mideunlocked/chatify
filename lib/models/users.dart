class Users {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String phoneNumber;
  final String token;
  final String imageUrl;

  const Users({
    required this.token,
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
  });
}
