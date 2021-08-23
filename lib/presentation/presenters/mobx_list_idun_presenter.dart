import 'package:idun_test/data/models/data_model.dart';
import 'package:idun_test/data/usecases/load_data.dart';
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

  ObservableList<DataModel> listPostsStream = ObservableList<DataModel>();

  @action
  Future<void> getListPosts() async{
    final listPosts = await loadData.call();
    listPosts.forEach((entity) {
      listPostsStream.add(DataModel(guid: entity.guid, text: entity.text, date: entity.date.toIso8601String()));
    });
  }

}