import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = '/favorite-meals';
  final List<Meal> favoriteMeals;
  final Function removeMeal;
  final Function toggleFavorite;
  FavoritesScreen({this.favoriteMeals, this.removeMeal, this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Container(
        child: Center(child: Text('No favorites added...')),
      );
    }
    return ListView.builder(
      itemBuilder: (context, i) {
        return MealItem(
          id: favoriteMeals[i].id,
          imageUrl: favoriteMeals[i].imageUrl,
          affordability: favoriteMeals[i].affordability,
          complexity: favoriteMeals[i].complexity,
          duration: favoriteMeals[i].duration,
          title: favoriteMeals[i].title,
          removeMeal: removeMeal,
          toggleFavorite: toggleFavorite,
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
