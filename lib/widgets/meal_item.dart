import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipes/models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeMeal;
  final Function toggleFavorite;

  MealItem(
      {@required this.id,
      @required this.imageUrl,
      @required this.affordability,
      @required this.complexity,
      @required this.duration,
      @required this.title,
      @required this.removeMeal,
      @required this.toggleFavorite});

  String get complexityText {
    String val = '';

    switch (complexity) {
      case Complexity.Simple:
        val = 'Simple';
        break;
      case Complexity.Challenging:
        val = 'Intermediate';
        break;
      case Complexity.Hard:
        val = 'Hard AF!';
        break;
      default:
        val = 'Easy';
    }

    return val;
  }

  String get affordabilityText {
    String val = '';

    switch (affordability) {
      case Affordability.Affordable:
        val = '\$';
        break;
      case Affordability.Pricey:
        val = '\$\$';
        break;
      case Affordability.Luxurious:
        val = '\$\$\$';
        break;
      default:
        val = '\$\$';
    }

    return val;
  }

  void mealSelection({ctx: BuildContext, mealTitle: String}) {
    //short hand way of passing args through if there is only 1 that needs to be passed
    Navigator.of(ctx).pushNamed('/meal-details', arguments: {
      'id': id,
      'removeItem': removeMeal,
      'toggleFavorite': toggleFavorite
    }).then((values) {
      if (values != null) {
        //print(values);
        var valuesRecieved = values as Map<String, Object>;
        String id = valuesRecieved['mealId'];
        print(id);
        removeMeal(id);
        return;
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => mealSelection(ctx: context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 280,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${duration} mins')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityText)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
