import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(AppBarBottomSample());
}

class  AppBarBottomSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppBarBottomSampleState();
  }
}

class _AppBarBottomSampleState  extends State<AppBarBottomSample> with SingleTickerProviderStateMixin {

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex =_tabController.index + delta;
    if (newIndex < 0 || newIndex >=_tabController.length) {
      return;
    }
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AppBar Bottom Widget"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Previous choice',
            onPressed: () { _nextPage(-1); }
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              tooltip: 'Next Choice',
              onPressed: () { _nextPage(1); },
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
                child: TabPageSelector(controller: _tabController, color: Theme.of(context).accentColor, selectedColor: Colors.white,),
                height: 48,
                alignment: Alignment.center,
              ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children:  choices.map((Choice choice) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: ChoiceCard(choice:choice),
              );
            }).toList()
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: "car", icon: Icons.directions_car),
  Choice(title: "bike", icon: Icons.directions_bike),
  Choice(title: "boat", icon: Icons.directions_boat),
  Choice(title: "bus", icon: Icons.directions_bus),
  Choice(title: "train", icon: Icons.directions_railway),
  Choice(title: "walk", icon: Icons.directions_walk),
];


class ChoiceCard extends StatelessWidget {

  const ChoiceCard({Key key, Choice this.choice}) :super(key:key);
  final Choice choice;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color,),
            Text(choice.title, style: textStyle)
          ],
        ),
      ),
    );
  }
}