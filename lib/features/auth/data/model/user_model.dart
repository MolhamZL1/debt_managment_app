import '../../domain/entity/user_entity.dart';

class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['mobile'] as String,
    );
  }

  UserEntity toEntity() {
    return UserEntity(name: name, email: email, phoneNumber: phoneNumber);
  }
}
