import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:idun_test/presentation/presenters/mobx_fields_idun_presenter.dart';
import 'package:idun_test/presentation/presenters/mobx_list_idun_presenter.dart';
import 'package:idun_test/ui/components/show_erro_message.dart';
import 'package:idun_test/ui/pages/formIdun/components/show_date_picker.dart';
import 'package:idun_test/ui/pages/formIdun/components/text_form_field_custom.dart';
import 'package:mobx/mobx.dart';

import '/domain/helpers/helpers.dart';

class FormIdunPage extends StatefulWidget {
  @override
  _FormIdunPageState createState() => _FormIdunPageState();
}

class _FormIdunPageState extends State<FormIdunPage> {
  MobxFieldsIdunPresenter mobxFieldsIdunPresenter =
      GetIt.instance<MobxFieldsIdunPresenter>();
  MobxListIdunPresenter mobxListIdunPresenter =
      GetIt.instance<MobxListIdunPresenter>();

  @override
  void initState() {
    reaction((_) => mobxFieldsIdunPresenter.error, (error) {
      if (error != null) {
        showErrorMessage(context, error.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Formulário"),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () async {
            mobxFieldsIdunPresenter.resetFields();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Observer(
                builder: (_) {
                  if (mobxFieldsIdunPresenter.isLoading) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldCustom(
                        labelText: "guid",
                        initialValue: mobxFieldsIdunPresenter.guid,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormFieldCustom(
                        labelText: "Texto",
                        hintText: "Digite algo ...",
                        errorText: mobxFieldsIdunPresenter.textError,
                        onChanged: mobxFieldsIdunPresenter.setText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () async {
                          showDatepicker(context, DateTime.now())
                              .then((DateTime? value) {
                            mobxFieldsIdunPresenter.setDateTime(value!);
                          });
                        },
                        child: Text(
                            "Selecione uma data: ${mobxFieldsIdunPresenter.dateTime.dateConvert}"),
                      ),
                      const Divider(),
                      ElevatedButton(
                        onPressed: mobxFieldsIdunPresenter.formValidat
                            ? () async {
                                FocusScope.of(context).unfocus();
                                await mobxFieldsIdunPresenter.postField();
                                if (mobxFieldsIdunPresenter.error == null) {
                                  mobxFieldsIdunPresenter.resetFields();
                                  mobxListIdunPresenter.getListPosts();
                                  Navigator.of(context).pop();
                                }
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
      ),
    );
  }
}
