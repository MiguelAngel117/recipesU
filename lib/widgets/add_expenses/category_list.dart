import 'package:recipes/models/features_model.dart';

class CategoryList {
  var catList = [
    FeaturesModel(
        category: 'Desayuno',
        color: '#FFEE93',
        icon: 'breakfast_dining_outlined'),
    FeaturesModel(
        category: 'Almuerzo', color: '#FF6F61', icon: 'lunch_dining_outlined'),
    FeaturesModel(
        category: 'Cena', color: '#6B8E23', icon: 'dinner_dining_outlined'),
    FeaturesModel(category: 'Postre', color: '#FFD700', icon: 'cake_outlined'),
    FeaturesModel(
        category: 'Bebidas', color: '#87CEEB', icon: 'local_drink_outlined'),
  ];
}
