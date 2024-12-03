import 'package:flutter/material.dart';

import '../../domain/entities/apod_entity.dart';
import '../../domain/usecases/interfaces/get_apod_usecase.dart';

class APODProvider with ChangeNotifier {
  final GetAPODUsecase _getAPODUseCase;

  APODProvider({
    required GetAPODUsecase getAPODUseCase,
  }) : _getAPODUseCase = getAPODUseCase;

  APODEntity? apod;
  bool isLoading = false;
  String? error;

  Future<void> fetchAPOD() async {
    isLoading = true;
    error = null;
    notifyListeners();

    apod = await _getAPODUseCase.call(date: DateTime(2024, 12, 02));

    isLoading = false;
    notifyListeners();
  }
}
