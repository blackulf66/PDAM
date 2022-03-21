class RegisterDto {
  RegisterDto({
    required this.email,
    required this.password,
    required this.username,

  });
  late final String email;
  late final String password;
  late final String username;


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['username'] = username;
    return _data;
  }
}