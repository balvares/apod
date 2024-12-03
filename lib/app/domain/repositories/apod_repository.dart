import '../entities/apod_entity.dart';

abstract interface class APODRepository {
  Future<APODEntity> getAPOD({required DateTime date});

  Future<List<APODEntity>> getAPODByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });
}
