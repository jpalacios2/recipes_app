import 'package:flutter/material.dart';
import 'package:flutter_recipes/screens/categories_screen.dart';
import 'package:flutter_recipes/screens/query_screen.dart';
//import 'package:flutter_recipes/screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget drawerWidget(String textInfo, Icon icon, Function functionCall) {
    return Container(
      width: double.infinity,
      color: Colors.red,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: .5)),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 25),
          child: ListTile(
            onTap: () => functionCall(),
            leading: icon,
            title: Text(
              textInfo,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      semanticLabel: 'DRAWER',
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.only(top: 75, bottom: 25),
            decoration: BoxDecoration(color: Colors.orange[300]),
            child: Text(
              'Yummy!',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          drawerWidget(
              'Meals',
              Icon(
                Icons.restaurant_menu,
                color: Colors.white,
              ), () {
            Navigator.of(context)
                .pushReplacementNamed(CategoriesScreen.routeName);
          }),
          drawerWidget(
              'Filters',
              Icon(
                Icons.settings,
                color: Colors.white,
              ), () {
            Navigator.of(context).pushNamed(FiltersScreen.routeName);
          }),
        ]),
      ),
    );
  }
}
