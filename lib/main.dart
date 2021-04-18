import 'package:flutter/material.dart';
import 'package:flutter_recipes/screens/categories_screen.dart';
import 'package:flutter_recipes/screens/query_screen.dart';
import 'screens/category_meals_screen.dart';
import 'package:flutter/services.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import 'screens/query_screen.dart';
import './screens/favorites_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatefulWidget {
  @override
  _RecipeAppState createState() {
    return _RecipeAppState();
  }
}

class _RecipeAppState extends State {
  Map<String, bool> filters = {
    'glutenFree': false,
    'vegetarian': false,
    'vegan': false,
    'lactoseFree': false,
  };

  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
    });
  }

  void _toggleFavorite(String mealId) {
    print('Adding a FAV!!!');
    final existingIndex = favoriteMeals.indexWhere((element) {
      return element.id == mealId;
    });

    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      Meal favMeal;
      DUMMY_MEALS.forEach((element) {
        if (element.id == mealId) {
          favMeal = element;
        }
      });

      this.setState(() {
        favoriteMeals.add(favMeal);
      });
    }

    favoriteMeals.forEach((element) {
      print(element.title);
    });
  }

  bool _isFavorite(String mealId) {
    return favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    List<Meal> availableMeals = DUMMY_MEALS.where((m) {
      if (filters['glutenFree'] && !m.isGlutenFree) {
        return false;
      }
      if (filters['vegetarian'] && !m.isVegetarian) {
        return false;
      }
      if (filters['vegan'] && !m.isVegan) {
        return false;
      }
      if (filters['lactoseFree'] && !m.isVegan) {
        return false;
      }
      return true;
    }).toList();

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1))),
      ),
      initialRoute: CategoriesScreen.routeName,
      routes: {
        CategoriesScreen.routeName: (ctx) => TabsScreen(
            favoriteMeals: favoriteMeals,
            toggleFavorite: _toggleFavorite), //CategoriesScreen(),
        CatergoryMealsScreen.routeName: (ctx) => CatergoryMealsScreen(
              availableMeals: availableMeals,
            ),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(
              isFavorite: _isFavorite,
              toggleFavorite: _toggleFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              setFilters: setFilters,
              filters: filters,
            ),
        FavoritesScreen.routeName: (ctx) => FavoritesScreen(
              removeMeal: () {},
              toggleFavorite: _toggleFavorite,
            )
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) {
          return CategoriesScreen(
            toggleFavorite: _toggleFavorite,
          );
        });
      },
    );
  }
}
