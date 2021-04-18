import 'package:flutter/material.dart';
import 'package:flutter_recipes/models/meal.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CatergoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';
  final List<Meal> availableMeals;
  CatergoryMealsScreen({this.availableMeals});
  @override
  _CatergoryMealsScreen createState() {
    return _CatergoryMealsScreen();
  }
}

class _CatergoryMealsScreen extends State<CatergoryMealsScreen> {
  List<Meal> categoryMeals;

  String title;
  String id;
  Function toggleFavorite;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      print('did change dependies');
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      id = args["id"];
      title = args["title"];
      toggleFavorite = args['toggleFavorite'];
      categoryMeals = widget.availableMeals.where((element) {
        return element.categories.contains(id);
      }).toList();
      _loadedInitData = true;
    }
    print('did NOT change dependies');
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    print('meal to remove ${mealId}');
    setState(() {
      categoryMeals.removeWhere((element) {
        return element.id == mealId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
          itemBuilder: (context, i) {
            return MealItem(
              id: categoryMeals[i].id,
              imageUrl: categoryMeals[i].imageUrl,
              affordability: categoryMeals[i].affordability,
              complexity: categoryMeals[i].complexity,
              duration: categoryMeals[i].duration,
              title: categoryMeals[i].title,
              removeMeal: _removeMeal,
              toggleFavorite: toggleFavorite,
            );
          },
          itemCount: categoryMeals.length,
        ));
  }
}
