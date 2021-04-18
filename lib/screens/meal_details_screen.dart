import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatefulWidget {
  static const String routeName = '/meal-details';
  final Function isFavorite;
  Function toggleFavorite;
  MealDetailsScreen({@required this.isFavorite, this.toggleFavorite});

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as Map<String, Object>; //as Map<String, String>;
    final String id = args['id'];
    //final Function removeCall = args['removeItem'];
    //toggleFavorite = args['toggleFavorite'];//Not necessary since it is received in main.dart

    //can also use DUMMY_MEALS.firstWhere() and have to worry about elements and not use a ListView.builder
    //final mealInfo = DUMMY_MEALS.where((element) => element.id == id).toList();
    final mealInfo = DUMMY_MEALS.firstWhere((element) => element.id == id);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('${mealInfo.id} - ${mealInfo.title}')),
      ),
      body: ListView(shrinkWrap: true, children: [
        Column(
          children: [
            Image.network(mealInfo.imageUrl),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 25,
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ...mealInfo.ingredients.map((e) {
                    return Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          '- $e',
                          textAlign: TextAlign.left,
                        ));
                  })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 25,
              child: Text(
                'Steps',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ...mealInfo.steps.map((e) {
                    int stepInt = mealInfo.steps.indexOf(e) + 1;
                    return Column(children: [
                      Row(
                        children: [
                          Container(
                              //width: 10,
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 5),
                              child: CircleAvatar(
                                child: Text(
                                  ' # ${stepInt} ',
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextStyle(fontSize: 14),
                                ),
                              )),
                          Expanded(
                              //width: double.infinity,
                              //margin: EdgeInsets.symmetric(
                              //vertical: 10,
                              //),
                              child: Text(
                            '$e',
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: TextStyle(fontSize: 14),
                          )),
                        ],
                      ),
                      if (stepInt < mealInfo.steps.length)
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        )
                    ]);
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: widget.isFavorite(mealInfo.id)
            ? Icon(Icons.favorite_sharp)
            : Icon(Icons.favorite_outline_rounded),
        onPressed: () {
          //Navigator.of(context).pop({'mealId': id});
          widget.toggleFavorite(mealInfo.id);
        },
      ),
    );
  }
}
