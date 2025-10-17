import '../../domain/entities/ClientSearchDropDownEntity.dart';

class ClientSearchDropDownModel {
  final int id;
  final String name;

  ClientSearchDropDownModel({required this.id, required this.name});

  factory ClientSearchDropDownModel.fromJson(Map<String, dynamic> json) {
    return ClientSearchDropDownModel(id: json['id'], name: json['name']);
  }
  ClientSearchDropDownEntity toEntity() {
    return ClientSearchDropDownEntity(id: id, name: name);
  }
}
