import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:idun_test/presentation/presenters/mobx_list_idun_presenter.dart';

import 'package:idun_test/ui.components/pages/listIdun/components/list_item_component.dart';

class ListIdunPage extends StatelessWidget {
  MobxListIdunPresenter listIdunPresenter =
      GetIt.instance<MobxListIdunPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Postagens"),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: listIdunPresenter.listPostsStream.length,
            itemBuilder: (_, index) {
              return ListItemComponent(
                  dataModel: listIdunPresenter.listPostsStream[index]);
            },
          );
        },
      ),
    );
  }
}
