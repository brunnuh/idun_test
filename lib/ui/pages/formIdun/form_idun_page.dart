import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:idun_test/presentation/presenters/mobx_fields_idun_presenter.dart';

import '/domain/helpers/helpers.dart';

class FormIdunPage extends StatefulWidget {
  @override
  _FormIdunPageState createState() => _FormIdunPageState();
}

class _FormIdunPageState extends State<FormIdunPage> {
  MobxFieldsIdunPresenter mobxFieldsIdunPresenter =
      GetIt.instance<MobxFieldsIdunPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário"),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          mobxFieldsIdunPresenter.setText(null);
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Observer(
              builder: (_) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: mobxFieldsIdunPresenter.guid,
                      style: TextStyle(color: Colors.black.withOpacity(.4)),
                      decoration: InputDecoration(
                        labelText: "guid",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: mobxFieldsIdunPresenter.setText,
                      decoration: InputDecoration(
                        hintText: "Digite algo ...",
                        labelText: "Texto",
                        errorText: mobxFieldsIdunPresenter.textError,
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
                        var dt = (await showDatePicker(
                          context: context,
                          initialDate: mobxFieldsIdunPresenter.dateTime,
                          firstDate: DateTime(1111),
                          lastDate: DateTime(2999),
                        ))!;
                        mobxFieldsIdunPresenter.setDateTime(dt);
                      },
                      child: Text(
                          "Selecione uma data: ${mobxFieldsIdunPresenter.dateTime.dateConvert}"),
                    ),
                    const Divider(),
                    ElevatedButton(
                      onPressed: mobxFieldsIdunPresenter.formValidat
                          ? () {
                              print("funcionando");
                            }
                          : null,
                      child: Text("Enviar"),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
