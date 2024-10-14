import 'package:recipes/models/features_model.dart';
import 'package:recipes/providers/db_features.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> flist = [];

  addNewFeature(String category, String color, String icon) async {
    final newFeature =
        FeaturesModel(category: category, color: color, icon: icon);
    final id = await DBFEatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    flist.add(newFeature);
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFEatures.db.getAllFeatures();
    flist = [...response];
    notifyListeners();
  }
}
