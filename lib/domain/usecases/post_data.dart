
import 'package:idun_test/domain/entities/entities.dart';

abstract class PostData{
  Future create({required IdunDataEntity entity});
}