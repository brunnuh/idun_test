import 'package:equatable/equatable.dart';

class IdunDataEntity extends Equatable {
  final String guid;
  final String text;
  final DateTime date;

  IdunDataEntity({
    required this.guid,
    required this.text,
    required this.date,
  });

  @override
  List<Object?> get props => ['guid', 'text', 'date'];


}
