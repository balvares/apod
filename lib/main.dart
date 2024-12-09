import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/data/datasources/apod_remote_datasource_impl.dart';
import 'app/data/repositories/apod_repository_impl.dart';
import 'app/domain/usecases/get_apod_list_usecase_impl.dart';
import 'app/domain/usecases/get_apod_usecase_impl.dart';
import 'app/presentation/providers/apod_provider.dart';

void main() {
  final client = http.Client();
  final GetIt getIt = GetIt.instance;
  final apodDataSource = APODRemoteDataSourceImpl(client: client);
  final apodRepository = APODRepositoryImpl(datasource: apodDataSource);
  final getApodUsecase = GetAPODUseCaseImpl(repository: apodRepository);
  final getApodListUsecase = GetAPODListUseCaseImpl(repository: apodRepository);
  final apodProviderGlobal = ChangeNotifierProvider<APODProvider>(
    create: (_) => APODProvider(
      getAPODUseCase: getApodUsecase,
      getAPODListUseCase: getApodListUsecase,
    ),
  );

  void setup() {
    getIt.registerSingleton<APODProvider>(
      APODProvider(
        getAPODUseCase: getApodUsecase,
        getAPODListUseCase: getApodListUsecase,
      ),
    );
  }

  setup();
  runApp(
    MultiProvider(
      providers: [
        apodProviderGlobal,
      ],
      child: const APODApp(),
    ),
  );
}
