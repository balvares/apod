import '../../domain/entities/apod_entity.dart';

class APODModel extends APODEntity {
  APODModel({
    required super.title,
    required super.explanation,
    required super.url,
    required super.date,
  });

  factory APODModel.fromJson(Map<String, dynamic> json) {
    return APODModel(
      title: json['title'],
      explanation: json['explanation'],
      url: json['url'],
      date: json['date'],
    );
  }

  static List<APODModel> fromListJson(List<dynamic> listJson) {
    return listJson
        .map((e) => APODModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'explanation': explanation,
      'url': url,
    };
  }
}
