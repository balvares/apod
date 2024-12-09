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
        _getAPODListUseCase = getAPODListUseCase {
    _initialize();
  }

  var _apod;
  APODEntity get apod => _apod;

  var _apodList;
  List<APODEntity> get apodList => _apodList;

  bool isLoading = false;
  String? error;

  Future<void> _initialize() async {
    try {
      await fetchAPOD();
      await fetchAPODList();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  void showError(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Hello! This is a SnackBar.'),
        duration: const Duration(seconds: 3), // Duração do SnackBar
        action: SnackBarAction(
          label: 'Tentar novamente',
          onPressed: () async {
            await fetchAPOD();
            await fetchAPODList();
          },
        ),
      ),
    );
  }

  Future<void> fetchAPOD() async {
    isLoading = true;
    error = null;
    notifyListeners();

    _apod = await _getAPODUseCase.call(date: DateTime.now());

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAPODList() async {
    isLoading = true;
    error = null;
    notifyListeners();

    _apodList = await _getAPODListUseCase.call(
        startDate: DateTime.now(), endDate: DateTime.now());

    isLoading = false;
    notifyListeners();
  }
}
