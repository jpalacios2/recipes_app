import 'package:flutter/material.dart';
//import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/settings';

  final Function setFilters;
  final Map<String, bool> filters;

  FiltersScreen({@required this.setFilters, @required this.filters});

  @override
  _FiltersScreenState createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget filterSwitch(
      {bool valueToToggle,
      String textInfo,
      String subtitleString,
      Function actionToCall}) {
    return SwitchListTile(
      value: valueToToggle,
      onChanged: actionToCall,
      title: Text(textInfo),
      subtitle: subtitleString != null ? Text(subtitleString) : null,
    );
  }

  bool _glutenFree = true;
  bool _vegetarian = true;
  bool _vegan = true;
  bool _lactoseFree = true;

  @override
  initState() {
    _glutenFree = widget.filters['glutenFree'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactoseFree'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building filters screen');

    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  widget.setFilters({
                    'glutenFree': _glutenFree,
                    'vegetarian': _vegetarian,
                    'vegan': _vegan,
                    'lactoseFree': _lactoseFree,
                  });
                })
          ],
        ),
        //drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Select filters',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                filterSwitch(
                    valueToToggle: _glutenFree,
                    textInfo: 'Gluten Free',
                    actionToCall: (val) {
                      setState(() {
                        _glutenFree = val;
                      });
                    }),
                filterSwitch(
                    valueToToggle: _vegetarian,
                    textInfo: 'Vegetarian',
                    actionToCall: (val) {
                      setState(() {
                        _vegetarian = val;
                      });
                    }),
                filterSwitch(
                    valueToToggle: _vegan,
                    textInfo: 'Vegan',
                    actionToCall: (val) {
                      setState(() {
                        _vegan = val;
                      });
                    },
                    subtitleString: 'No Cheese, Milk, Eggs...'),
                filterSwitch(
                    valueToToggle: _lactoseFree,
                    textInfo: 'Lactose Free',
                    actionToCall: (val) {
                      print('attempting change');
                      setState(() {
                        _lactoseFree = val;
                      });
                    }),
              ],
            ))
          ],
        ));
  }
}
