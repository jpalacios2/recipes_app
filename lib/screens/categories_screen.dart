import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = '/';

  final Function toggleFavorite;
  CategoriesScreen({@required this.toggleFavorite});

  final appBar = AppBar(
    title: Text('Yummy'),
  );

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context);
    bool isLandscape = mediaQ.orientation.index == 1;
    Widget portraitView = GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent:
              MediaQuery.of(context).size.height / 5, //TOP TO BOTTOM
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 5, //left to right spacing
          mainAxisSpacing: 5, //top to bottom spacing
          maxCrossAxisExtent:
              MediaQuery.of(context).size.width / 2), //LEFT TO RIGHT
      children: [
        ...DUMMY_CATEGORIES.map((e) {
          return CategoryItem(
            id: e.id,
            title: e.title,
            color: e.color,
            toggleFavorite: toggleFavorite,
          );
        })
      ],
    );

    Widget landscapeView = GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent:
              MediaQuery.of(context).size.height / 2, //TOP TO BOTTOM
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 5, //left to right spacing
          mainAxisSpacing: 5, //top to bottom spacing
          maxCrossAxisExtent:
              MediaQuery.of(context).size.width / 4), //LEFT TO RIGHT
      children: [
        ...DUMMY_CATEGORIES.map((e) {
          return CategoryItem(
            id: e.id,
            title: e.title,
            color: e.color,
            toggleFavorite: toggleFavorite,
          );
        })
      ],
    );

    return isLandscape
        ? landscapeView
        : portraitView; //Scaffold(appBar: appBar, body: isLandscape ? landscapeView : portraitView);
  }
}
