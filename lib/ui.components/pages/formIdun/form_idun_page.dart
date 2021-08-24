import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import '/domain/helpers/helpers.dart';

class FormIdunPage extends StatefulWidget {
  @override
  _FormIdunPageState createState() => _FormIdunPageState();
}

class _FormIdunPageState extends State<FormIdunPage> {
  final guid = faker.guid.guid();

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: false,
                initialValue: guid,
                style: TextStyle(color: Colors.black.withOpacity(.4)),
                decoration: InputDecoration(
                    labelText: "guid",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Digite algo ...",
                  labelText: "Texto",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  dateTime = (await showDatePicker(
                    context: context,
                    initialDate: dateTime,
                    firstDate: DateTime(1111),
                    lastDate: DateTime(2999),
                  ))!;
                  setState(() {
                    dateTime = dateTime;
                  });
                },
                child: Text("Selecione uma data: ${dateTime.dateConvert}"),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {},
                child: Text("Enviar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
