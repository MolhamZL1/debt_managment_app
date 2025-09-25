import '../../domain/entity/user_entity.dart';

class UserModel {
  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel();
  }
  UserEntity toEntity() {
    return UserEntity();
  }
}
