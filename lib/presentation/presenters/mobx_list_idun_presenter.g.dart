// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_list_idun_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxListIdunPresenter on _MobxListIdunPresenter, Store {
  final _$isLoadingAtom = Atom(name: '_MobxListIdunPresenter.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getListPostsAsyncAction =
      AsyncAction('_MobxListIdunPresenter.getListPosts');

  @override
  Future<void> getListPosts() {
    return _$getListPostsAsyncAction.run(() => super.getListPosts());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
