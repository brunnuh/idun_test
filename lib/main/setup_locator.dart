import 'package:get_it/get_it.dart';

import '/main/load_data.dart';
import '/main/post_data.dart';

import '/presentation/presenters/presenters.dart';



void setupLocator(){

  GetIt.I.registerSingleton(MobxListIdunPresenter(loadData: getLoadData()));

  GetIt.I.registerSingleton(MobxFieldsIdunPresenter(postData: getPostData()));
}


