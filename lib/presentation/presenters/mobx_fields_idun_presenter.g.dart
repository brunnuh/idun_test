// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_fields_idun_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxFieldsIdunPresenter on _MobxFieldsIdunPresenter, Store {
  Computed<String?>? _$textErrorComputed;

  @override
  String? get textError =>
      (_$textErrorComputed ??= Computed<String?>(() => super.textError,
              name: '_MobxFieldsIdunPresenter.textError'))
          .value;

  final _$textAtom = Atom(name: '_MobxFieldsIdunPresenter.text');

  @override
  String? get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String? value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$dateTimeAtom = Atom(name: '_MobxFieldsIdunPresenter.dateTime');

  @override
  DateTime get dateTime {
    _$dateTimeAtom.reportRead();
    return super.dateTime;
  }

  @override
  set dateTime(DateTime value) {
    _$dateTimeAtom.reportWrite(value, super.dateTime, () {
      super.dateTime = value;
    });
  }

  final _$_MobxFieldsIdunPresenterActionController =
      ActionController(name: '_MobxFieldsIdunPresenter');

  @override
  void setText(String? value) {
    final _$actionInfo = _$_MobxFieldsIdunPresenterActionController.startAction(
        name: '_MobxFieldsIdunPresenter.setText');
    try {
      return super.setText(value);
    } finally {
      _$_MobxFieldsIdunPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateTime(DateTime value) {
    final _$actionInfo = _$_MobxFieldsIdunPresenterActionController.startAction(
        name: '_MobxFieldsIdunPresenter.setDateTime');
    try {
      return super.setDateTime(value);
    } finally {
      _$_MobxFieldsIdunPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
text: ${text},
dateTime: ${dateTime},
textError: ${textError}
    ''';
  }
}