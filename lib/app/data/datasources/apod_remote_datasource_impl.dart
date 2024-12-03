import 'dart:convert';

import 'package:apod/app/core/errors/http_exception.dart';
import 'package:apod/app/core/utils/constants.dart';
import 'package:apod/app/domain/entities/apod_entity.dart';
import 'package:http/http.dart' as http;

import '../models/apod_model.dart';
import 'interfaces/apod_remote_datasource.dart';

class APODRemoteDataSourceImpl implements APODRemoteDataSource {
  final http.Client _client;

  final String apiUrl = '$baseUrl?api_key=$apiKey';

  APODRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;

  @override
  Future<APODEntity> getAPOD({required String date}) async {
    try {
      final response = await _client.get(Uri.parse("$apiUrl&date=$date"));

      if (response.statusCode == 200) {
        return APODModel.fromJson(json.decode(response.body));
      } else {
        throw HttpException.fromJson(json.decode(response.body));
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<APODEntity>> getAPODByDateRange({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _client
          .get(Uri.parse("$apiUrl&start_date=$startDate&end_date=$endDate"));

      if (response.statusCode == 200) {
        return APODModel.fromListJson(json.decode(response.body));
      } else {
        throw HttpException.fromJson(json.decode(response.body));
      }
    } catch (error) {
      rethrow;
    }
  }
}
