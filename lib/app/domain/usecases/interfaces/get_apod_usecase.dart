import '../../entities/apod_entity.dart';

abstract interface class GetAPODUsecase {
  Future<APODEntity> call({required DateTime date});
}
