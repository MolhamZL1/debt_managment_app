import '../../../../core/services/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/entities/ClientSearchDropDownEntity.dart';
import '../../domain/repo/ClientSearchDropDown_repo.dart';
import '../model/ClientSearchDropDownModel.dart';

class ClientSearchDropdownRepoImpl implements ClientSearchDropDownRepo {
  final DatabaseService databaseService;
  ClientSearchDropdownRepoImpl({required this.databaseService});

  @override
  Future<List<ClientSearchDropDownEntity>> searchClients(String query) async {
    final data = await databaseService.getData(
      endpoint: BackendEndPoint.clientsSearch,
      quary: {"q": query},
    );
    final list =
        (data["result"] as List)
            .map((e) => ClientSearchDropDownModel.fromJson(e).toEntity())
            .toList();
    return list;
  }
}
