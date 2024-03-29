import 'dart:async';

import '../../bloc/bloc_provider.dart';
import '../../data/db/label_db.dart';
import '../../data/model/label.dart';
import '../../utils/color_util.dart';

class LabelBloc implements BlocBase {
  StreamController<List<Label>> _labelController =
      StreamController<List<Label>>.broadcast();

  Stream<List<Label>> get labels => _labelController.stream;

  StreamController<bool> _labelExistController =
      StreamController<bool>.broadcast();

  Stream<bool> get labelsExist => _labelExistController.stream;

  StreamController<ColorPalette> _colorController =
      StreamController<ColorPalette>.broadcast();

  Stream<ColorPalette> get colorSelection => _colorController.stream;

  LabelDB _labelDB;

  LabelBloc(this._labelDB) {
    _loadLabels();
  }

  @override
  void dispose() {
    _labelController.close();
    _labelExistController.close();
    _colorController.close();
  }

  void _loadLabels() {
    _labelDB.getLabels().then((labels) {
      _labelController.sink.add(List.unmodifiable(labels));
    });
  }

  void refresh() {
    _loadLabels();
  }

  void checkIfLabelExist(Label label) async {
    _labelDB.isLabelExits(label).then((isExist) {
      _labelExistController.sink.add(isExist);
    });
  }

  void updateColorSelection(ColorPalette colorPalette) {
    _colorController.sink.add(colorPalette);
  }
}
