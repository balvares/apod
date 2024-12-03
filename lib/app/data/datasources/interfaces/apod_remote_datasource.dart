import '../../../domain/entities/apod_entity.dart';

abstract class APODRemoteDataSource {
  Future<APODEntity> getAPOD({required String date});

  Future<List<APODEntity>> getAPODByDateRange({
    required String startDate,
    required String endDate,
  });
}
