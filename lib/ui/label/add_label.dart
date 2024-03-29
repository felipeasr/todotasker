import 'package:flutter/material.dart';

import '../../bloc/bloc_provider.dart';
import '../../data/model/label.dart';
import '../../utils/app_util.dart';
import '../../utils/collapsable_expand_tile.dart';
import '../../utils/color_util.dart';
import 'label_bloc.dart';

class AddLabel extends StatelessWidget {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();

  @override
  Widget build(BuildContext context) {
    ColorPalette currentSelectedPalette;
    LabelBloc labelBloc = BlocProvider.of(context);
    String labelName = "";
    labelBloc.labelsExist.listen((isExist) {
      if (isExist) {
        showSnackbar(_scaffoldState, "Tag já existe");
      } else {
        Navigator.pop(context);
      }
    });
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Add Tag"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () async {
          if (_formState.currentState.validate()) {
            _formState.currentState.save();
            var label = Label.create(
                labelName,
                currentSelectedPalette.colorValue,
                currentSelectedPalette.colorName);
            labelBloc.checkIfLabelExist(label);
          }
        },
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formState,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Tag Nome"),
                maxLength: 20,
                validator: (value) {
                  return value.isEmpty ? "Insira uma tag" : null;
                },
                onSaved: (value) {
                  labelName = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StreamBuilder(
                stream: labelBloc.colorSelection,
                initialData: ColorPalette("Grey", Colors.grey.value),
                builder: (context, snapshot) {
                  currentSelectedPalette = snapshot.data;
                  return CollapsibleExpansionTile(
                      key: expansionTile,
                      title: Text(currentSelectedPalette.colorName),
                      leading: Icon(Icons.label,
                          size: 16.0,
                          color: Color(currentSelectedPalette.colorValue)),
                      children: buildMaterialColors(labelBloc));
                }),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors(LabelBloc labelBloc) {
    List<Widget> projectWidgetList = List();
    colorsPalettes.forEach((color) {
      projectWidgetList.add(ListTile(
        title: Text(color.colorName),
        leading: Icon(
          Icons.label,
          size: 16.0,
          color: Color(color.colorValue),
        ),
        onTap: () {
          expansionTile.currentState.collapse();
          labelBloc.updateColorSelection(
              ColorPalette(color.colorName, color.colorValue));
        },
      ));
    });
    return projectWidgetList;
  }
}
