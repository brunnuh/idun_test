import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:idun_test/ui.components/pages/listIdun/components/list_item_component.dart';
import 'package:idun_test/data/models/data_model.dart';

class ListIdunPage extends StatelessWidget {

  final List<DataModel> listProvisory = [
    DataModel(
      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,",
      date: DateTime.now().toString(),
      guid: faker.guid.guid(),),
    DataModel(
      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,",
      date: DateTime.now().toString(),
      guid: faker.guid.guid(),),
    DataModel(
      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,",
      date: DateTime.now().toString(),
      guid: faker.guid.guid(),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Postagens"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: listProvisory.length,
          itemBuilder: (_, index) {
            return ListItemComponent(dataModel: listProvisory[index]);
          },
        )
    );
  }
}
