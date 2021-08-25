import 'package:mobx/mobx.dart';
import 'package:faker/faker.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';

import '../../data/usecases/usecases.dart';

part 'mobx_fields_idun_presenter.g.dart';

class MobxFieldsIdunPresenter = _MobxFieldsIdunPresenter with _$MobxFieldsIdunPresenter;

abstract class _MobxFieldsIdunPresenter with Store{

  final PostData postData;

  _MobxFieldsIdunPresenter({required this.postData});

  @observable
  String? text;

  @observable
  String? error;

  @observable
  bool isLoading = false;

  String guid = faker.guid.guid();

  @observable
  DateTime dateTime = DateTime.now();

  @action
  void setText(String? value) => text = value;

  @action
  void setDateTime(DateTime value) => dateTime = value;

  @action
  Future<void> postField() async {
    error = null;
    isLoading = true;
    try{
      await postData.create(entity: IdunDataEntity(guid: guid, text: text!, date: dateTime));
    }on DomainError catch(e){
      error = e == DomainError.invalidFields ? "Campo invalido" : "Algo Inesperado Aconteceu";
    }
    isLoading = false;
  }

  @action
  void resetFields(){
    text = null;
    dateTime = DateTime.now();
    guid = faker.guid.guid();
  }


  @computed
  String? get textError{
    if(text != null && text!.isEmpty){
      return "Campo obrigatorio";
    }
    return null;
  }

  @computed
  bool get formValidat => text != null && text!.isNotEmpty;

}