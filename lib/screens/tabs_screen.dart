import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;

  TabsScreen({@required this.favoriteMeals, @required this.toggleFavorite});

  @override
  _TabsScreenState createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> navItems = [];

  @override
  initState() {
    navItems = [
      {
        'page': CategoriesScreen(
          toggleFavorite: widget.toggleFavorite,
        ),
        'title': 'Categories'
      },
      {
        'page': FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Favorites'
      }
    ];
    super.initState();
  }

  int currentNavItem = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(navItems[currentNavItem]['title']),
          ),
          drawer: MainDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            elevation: 10,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.green,
            //backgroundColor: Theme.of(context).primaryColor,
            onTap: (currentNavI) {
              setState(() {
                currentNavItem = currentNavI;
              });
            },
            currentIndex: currentNavItem,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                label: 'Categories',
                icon: Icon(
                  Icons.category,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Favorites',
                icon: Icon(
                  Icons.favorite,
                ),
              ),
            ],
          ),
          body: navItems[currentNavItem]['page'],
        ));
  }
}
