import 'package:flutter/material.dart';

import '../../../../data/models/data_model.dart';

import '../../../../domain/helpers/helpers.dart';

class ListItemComponent extends StatelessWidget {
  final DataModel dataModel;

  ListItemComponent({required this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Center(child: Text("Texto")),
                content: Text(dataModel.text),
              );
            },
          );
        },
        title: Text(
          "guid: ${dataModel.guid}",
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child:
              Text("postado em: ${DateTime.parse(dataModel.date).dateConvert}"),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
