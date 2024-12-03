import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/data/datasources/apod_remote_datasource_impl.dart';
import 'app/data/repositories/apod_repository_impl.dart';
import 'app/domain/usecases/get_apod_usecase_impl.dart';
import 'app/presentation/providers/apod_provider.dart';

void main() {
  final client = http.Client();
  final dataSource = APODRemoteDataSourceImpl(client: client);
  final repository = APODRepositoryImpl(datasource: dataSource);
  final useCase = GetAPODUseCaseImpl(repository: repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => APODProvider(getAPODUseCase: useCase),
      child: const APODApp(),
    ),
  );
}
