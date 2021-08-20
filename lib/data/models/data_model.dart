import 'package:idun_test/domain/entities/entities.dart';

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
    return DataModel(
        guid: json['guid'], text: json['text'], date: json['date']);
  }

  IdunDataEntity toEntity() => IdunDataEntity(
        text: text,
        guid: guid,
        date: DateTime.parse(date),
      );
}
