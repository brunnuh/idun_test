import 'package:idun_test/data/models/data_model.dart';
import 'package:idun_test/data/usecases/load_data.dart';
import 'package:idun_test/domain/helpers/domain_error.dart';
import 'package:mobx/mobx.dart';

part 'mobx_list_idun_presenter.g.dart';

class MobxListIdunPresenter = _MobxListIdunPresenter with _$MobxListIdunPresenter;

abstract class _MobxListIdunPresenter with Store  {

  _MobxListIdunPresenter({required this.loadData}){
    getListPosts();
  }

  final LoadData loadData;


  @observable
  bool isLoading = false;

  @observable
  String? erro;

  ObservableList<DataModel> listPostsStream = ObservableList<DataModel>();

  @action
  Future<void> getListPosts() async{
    listPostsStream.clear();
    erro = null;
    isLoading = true;
    try{
      final listPosts = await loadData.call();
      listPosts.forEach((entity) {
        listPostsStream.add(DataModel(guid: entity.guid, text: entity.text, date: entity.date.toIso8601String()));
      });
    }catch(e){
      erro = "Algo Inesperado Aconteceu";
    }
    isLoading = false;
  }

}