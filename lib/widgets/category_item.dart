import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final Function toggleFavorite;
  CategoryItem(
      {this.title,
      this.color,
      @required this.id,
      @required this.toggleFavorite});

  void categorySelection({ctx: BuildContext}) {
    print('Nav Pressed!');
    Navigator.of(ctx).pushNamed('/category-meals', arguments: {
      'id': id,
      'title': title,
      'toggleFavorite': toggleFavorite
    });

    /*
    Navigator.of(ctx).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CatergoryMealsScreen(
              title: title,
              id: id,
            )));
    */
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //similar to GestureDetector() but with a ripple effect!
      onTap: () => categorySelection(ctx: context),
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: const EdgeInsets.all(5),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
            color: color,
            gradient: LinearGradient(
                colors: [color.withOpacity(.75), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
