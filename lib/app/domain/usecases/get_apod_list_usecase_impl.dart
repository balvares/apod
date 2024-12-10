import '../entities/apod_entity.dart';
import '../repositories/apod_repository.dart';
import 'interfaces/get_apod_list_usecase.dart';

class GetAPODListUseCaseImpl implements GetAPODListUsecase {
  final APODRepository repository;

  GetAPODListUseCaseImpl({required this.repository});

  @override
  Future<List<APODEntity>> call({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return repository.getAPODList(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
