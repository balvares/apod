import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/data/datasources/apod_remote_datasource_impl.dart';
import 'app/data/repositories/apod_repository_impl.dart';
import 'app/domain/usecases/get_apod_list_usecase_impl.dart';
import 'app/domain/usecases/get_apod_usecase_impl.dart';
import 'app/presentation/providers/apod_provider.dart';

void main() {
  final apodDataSource = APODRemoteDataSourceImpl();
  final apodRepository = APODRepositoryImpl(datasource: apodDataSource);
  final getApodUsecase = GetAPODUseCaseImpl(repository: apodRepository);
  final getApodListUsecase = GetAPODListUseCaseImpl(repository: apodRepository);
  final apodProviderGlobal = ChangeNotifierProvider<APODProvider>(
    create: (_) => APODProvider(
      getAPODUseCase: getApodUsecase,
      getAPODListUseCase: getApodListUsecase,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        apodProviderGlobal,
      ],
      child: const APODApp(),
    ),
  );
}
