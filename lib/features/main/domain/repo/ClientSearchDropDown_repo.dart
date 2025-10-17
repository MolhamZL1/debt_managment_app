import '../entities/ClientSearchDropDownEntity.dart';

abstract class ClientSearchDropDownRepo {
  Future<List<ClientSearchDropDownEntity>> searchClients(String query);
}
