import 'package:mobx/mobx.dart';
import 'package:faker/faker.dart';

part 'mobx_fields_idun_presenter.g.dart';

class MobxFieldsIdunPresenter = _MobxFieldsIdunPresenter with _$MobxFieldsIdunPresenter;

abstract class _MobxFieldsIdunPresenter with Store{

  @observable
  String? text;

  final guid = faker.guid.guid();

  @observable
  DateTime dateTime = DateTime.now();

  @action
  void setText(String? value) => text = value;

  @action
  void setDateTime(DateTime value) => dateTime = value;

  @computed
  String? get textError{
    if(text != null && text!.isEmpty){
      return "Campo obrigatorio";
    }
    return null;
  }

}