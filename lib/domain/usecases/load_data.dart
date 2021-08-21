import '../entities/entities.dart';

abstract class ILoadData{
  Future<List<IdunDataEntity>> call();
}