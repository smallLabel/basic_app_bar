import 'package:flutter/material.dart';

void main() => runApp(BasicAppBarSample());


class BasicAppBarSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BasicAppBarSampleState();
}

class _BasicAppBarSampleState extends State<BasicAppBarSample> {

  Choice _selectedChoice =choices[0];
  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Basic AppBar"),
          actions: <Widget>[
            IconButton(
              icon: Icon(choices[0].icon),
              onPressed: (){
                _select(choices[0]);
              },
            ),
            IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () {
                _select(choices[1]);
              },
            ),
            PopupMenuButton(
              onSelected: _select,
              itemBuilder: (BuildContext context)  {
                return choices.skip(2).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ChoiceItemCard(
            choice: _selectedChoice,
          ),
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


class  ChoiceItemCard  extends StatelessWidget{

  const ChoiceItemCard({Key key, Choice this.choice}) : super(key:key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size:128.0, color:textStyle.color),
            Text(choice.title, style: textStyle,)
          ],
        ),
      ),
      );
  }
}
