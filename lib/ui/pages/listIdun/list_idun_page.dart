import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:idun_test/presentation/presenters/mobx_list_idun_presenter.dart';
import 'package:idun_test/ui/pages/formIdun/form_idun_page.dart';

import 'package:idun_test/ui/pages/listIdun/components/list_item_component.dart';

import '../../components/show_erro_message.dart';

class ListIdunPage extends StatefulWidget {
  @override
  _ListIdunPageState createState() => _ListIdunPageState();
}

class _ListIdunPageState extends State<ListIdunPage> {
  MobxListIdunPresenter mobxlistIdunPresenter =
      GetIt.instance<MobxListIdunPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Postagens"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: mobxlistIdunPresenter.getListPosts,
            icon: Icon(Icons.update),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (mobxlistIdunPresenter.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (mobxlistIdunPresenter.erro != null &&
              mobxlistIdunPresenter.erro!.isNotEmpty) {
            showErrorMessage(context, mobxlistIdunPresenter.erro!);
          }
          return ListView.builder(
            itemCount: mobxlistIdunPresenter.listPostsStream.length,
            itemBuilder: (_, index) {
              return ListItemComponent(
                  dataModel: mobxlistIdunPresenter.listPostsStream[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => FormIdunPage(),
          ),
        ),
        child: Icon(Icons.send),
      ),
    );
  }
}
