import 'dart:convert';

import 'package:apod/app/core/utils/constants.dart';
import 'package:apod/app/domain/entities/apod_entity.dart';
import 'package:http/http.dart' as http;

import '../../core/config/db_config.dart';
import '../models/apod_model.dart';
import 'interfaces/apod_remote_datasource.dart';

class APODRemoteDataSourceImpl implements APODRemoteDataSource {
  final http.Client _client = http.Client();
  final dbHelper = DbConfig.instance;

  final String apiUrl = '$baseUrl?api_key=$apiKey';

  @override
  Future<APODEntity> getAPOD({required String date}) async {
    try {
      final response = await _client.get(Uri.parse("$apiUrl&date=$date"));

      if (response.statusCode == 200) {
        return APODModel.fromJson(json.decode(response.body));
      } else {
        return await getAPODFromLocal(date: date);
      }
    } catch (error) {
      return await getAPODFromLocal(date: date);
    }
  }

  @override
  Future<List<APODEntity>> getAPODList({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _client
          .get(Uri.parse("$apiUrl&start_date=$startDate&end_date=$endDate"));

      if (response.statusCode == 200) {
        List<APODEntity> apodList =
            APODModel.fromListJson(json.decode(response.body));
        for (APODEntity item in apodList) {
          await dbHelper.insertAPOD(_entityToMap(item));
        }
        return apodList;
      } else {
        return await getAPODListFromLocal(
            startDate: startDate, endDate: endDate);
      }
    } catch (error) {
      return await getAPODListFromLocal(startDate: startDate, endDate: endDate);
    }
  }

  Future<APODEntity> getAPODFromLocal({required String date}) async {
    final localData = await dbHelper.getAPOD(date: date);
    if (localData.isNotEmpty) {
      return APODModel.fromJson(localData.first);
    } else {
      throw Exception('No local data found for date: $date');
    }
  }

  Future<List<APODEntity>> getAPODListFromLocal({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final localData = await dbHelper.getAPODList(
        startDate: startDate,
        endDate: endDate,
      );
      return localData.map((item) => APODModel.fromJson(item)).toList();
    } catch (error) {
      return [];
    }
  }

  Map<String, dynamic> _entityToMap(APODEntity entity) {
    return {
      'title': entity.title,
      'explanation': entity.explanation,
      'url': entity.url,
      'date': entity.date,
    };
  }
}
