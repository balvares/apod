import 'package:flutter/material.dart';

import '../../domain/entities/apod_entity.dart';
import '../../domain/usecases/interfaces/get_apod_list_usecase.dart';
import '../../domain/usecases/interfaces/get_apod_usecase.dart';

class APODProvider with ChangeNotifier {
  final GetAPODUsecase _getAPODUseCase;
  final GetAPODListUsecase _getAPODListUseCase;

  APODProvider({
    required GetAPODUsecase getAPODUseCase,
    required GetAPODListUsecase getAPODListUseCase,
  })  : _getAPODUseCase = getAPODUseCase,
        _getAPODListUseCase = getAPODListUseCase;

  APODEntity? apod;
  List<APODEntity> apodList = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchAPOD() async {
    isLoading = true;
    error = null;
    notifyListeners();

    apod = await _getAPODUseCase.call(date: DateTime.now());

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAPODList() async {
    isLoading = true;
    error = null;
    notifyListeners();

    apodList = await _getAPODListUseCase.call(
        startDate: DateTime.now(), endDate: DateTime.now());

    isLoading = false;
    notifyListeners();
  }
}
