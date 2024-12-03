import '../entities/apod_entity.dart';
import '../repositories/apod_repository.dart';
import 'interfaces/get_apod_usecase.dart';

class GetAPODUseCaseImpl implements GetAPODUsecase {
  final APODRepository repository;

  GetAPODUseCaseImpl({required this.repository});

  @override
  Future<APODEntity> call({required DateTime date}) {
    return repository.getAPOD(date: date);
  }
}
