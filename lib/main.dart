import 'package:flutter/material.dart';
import 'package:flutter_projectz/date_filter_form.dart';

import 'fetch_internet_data.dart';

void main() => runApp(FetchDataApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Filter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple,),
      home: MyCustomWidget(),
    );
  }
}

//Custom widget
class MyCustomWidget extends StatefulWidget{

  @override
  _MyCustomWidget createState() => _MyCustomWidget();
}

//Define the State class 'MyCustomWidget'
class _MyCustomWidget extends State<MyCustomWidget>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Date Saturday'),
      ),
      body:
      /*Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                //First text field
                decoration: new InputDecoration(labelText: "From this date"),
                keyboardType: TextInputType.number,
                controller: myController,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                //Second textfield
                decoration: new InputDecoration(labelText: "To this date"),
                keyboardType: TextInputType.number,
                controller: myController2,
              ),
            ),
          ],
        ),
      )*/
      DateFilterForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
              context: context,
              builder:(context) {
                return AlertDialog(
                  content: Text("Filter: "),
                );
              },
          );
        },
        tooltip: 'Filter',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}