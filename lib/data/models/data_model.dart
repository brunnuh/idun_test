import '../../domain/entities/entities.dart';

import '../http/http.dart';

class DataModel {
  final String guid;
  final String text;
  final String date;

  DataModel({
    required this.guid,
    required this.text,
    required this.date,
  });

  factory DataModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['guid', 'text', 'date'])) {
      throw HttpError.invalidData;
    }
    return DataModel(
      guid: json['guid'],
      text: json['text'],
      date: json['date'],
    );
  }

  factory DataModel.fromDomain(IdunDataEntity entity) {
    return DataModel(
      guid: entity.guid,
      text: entity.text,
      date: entity.date.toIso8601String(),
    );
  }

  Map toJson() => {
        "guid": guid,
        "text": text,
        "date": date,
      };

  IdunDataEntity toEntity() => IdunDataEntity(
        text: text,
        guid: guid,
        date: DateTime.parse(date),
      );
}
