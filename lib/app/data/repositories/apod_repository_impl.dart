import 'package:intl/intl.dart';

import '../../domain/entities/apod_entity.dart';
import '../../domain/repositories/apod_repository.dart';
import '../datasources/interfaces/apod_remote_datasource.dart';

class APODRepositoryImpl implements APODRepository {
  final APODRemoteDataSource _dataSource;

  APODRepositoryImpl({
    required APODRemoteDataSource datasource,
  }) : _dataSource = datasource;

  @override
  Future<APODEntity> getAPOD({required DateTime date}) {
    return _dataSource.getAPOD(date: DateFormat('yyyy-MM-dd').format(date));
  }

  @override
  Future<List<APODEntity>> getAPODByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _dataSource.getAPODByDateRange(
      startDate: DateFormat('yyyy-MM-dd').format(startDate),
      endDate: DateFormat('yyyy-MM-dd').format(endDate),
    );
  }
}
