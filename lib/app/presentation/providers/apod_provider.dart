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

  final TextEditingController nameController = TextEditingController();

  APODEntity? apod;
  APODEntity? todayApod;

  var _apodList = <APODEntity>[];
  List<APODEntity> get apodList => _apodList;

  List<APODEntity> filteredList = [];

  bool isLoading = false;

  // void showError(BuildContext context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: const Text('Hello! This is a SnackBar.'),
  //       duration: const Duration(seconds: 3), // Duração do SnackBar
  //       action: SnackBarAction(
  //         label: 'Tentar novamente',
  //         onPressed: () async {
  //           // await fetchAPOD(DateTime.now());
  //           await fetchAPODList();
  //         },
  //       ),
  //     ),
  //   );
  // }

  Future<void> fetchAPOD(DateTime date) async {
    isLoading = true;
    notifyListeners();

    apod = await _getAPODUseCase.call(date: date);

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAPODList() async {
    isLoading = true;
    notifyListeners();

    _apodList = await _getAPODListUseCase.call(
        startDate: DateTime(2024, 12, 01), endDate: DateTime.now());

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAPODListWithFilter(
      {required DateTime startDate, required DateTime endDate}) async {
    isLoading = true;
    notifyListeners();

    _apodList = await _getAPODListUseCase.call(
      startDate: startDate,
      endDate: endDate,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAPODListByName({required String name}) async {
    isLoading = true;
    notifyListeners();

    filteredList = apodList.where((apod) {
      return apod.title
          .toLowerCase()
          .contains(nameController.text.toLowerCase());
    }).toList();

    _apodList = filteredList;

    isLoading = false;
    notifyListeners();
  }

  void _initialize() async {
    await fetchAPOD(DateTime.now());
    await fetchAPODList();
    todayApod = apod;
    notifyListeners();
  }
}
