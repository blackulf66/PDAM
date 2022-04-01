class RegisterDto {
  RegisterDto({
    required this.email,
    required this.password,
    required this.username,
    required this.role,

  });
  late final String email;
  late final String password;
  late final String username;
  late final String role;


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['username'] = username;
    _data['role']= role;
    return _data;
  }
}