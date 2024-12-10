import '../../../domain/entities/apod_entity.dart';

abstract class APODRemoteDataSource {
  Future<APODEntity> getAPOD({required String date});

  Future<List<APODEntity>> getAPODList({
    required String startDate,
    required String endDate,
  });
}
