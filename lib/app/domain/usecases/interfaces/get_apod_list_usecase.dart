import '../../entities/apod_entity.dart';

abstract interface class GetAPODListUsecase {
  Future<List<APODEntity>> call({
    required DateTime startDate,
    required DateTime endDate,
  });
}
