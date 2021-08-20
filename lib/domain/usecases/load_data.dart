import '../entities/entities.dart';

abstract class LoadData{
  Future<List<IdunDataEntity>> call();
}