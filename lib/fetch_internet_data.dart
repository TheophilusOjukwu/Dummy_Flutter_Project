import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'date_filter_form.dart';
import 'form_config.dart';

String line;

Future<Album> fetchAlbum() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/albums/${FormConfig.from}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class FetchDataApp extends StatefulWidget {
  FetchDataApp({Key key}) : super(key: key);

  @override
  _FetchDataAppState createState() => _FetchDataAppState();
}

class _FetchDataAppState extends State<FetchDataApp> {
  Future<Album> futureAlbum;
  final _formKey = GlobalKey<FormState>();
  String _to = '04/23';
  String _from = '03/23';

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  void _submit(BuildContext context) {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print('From = $_from , To = $_to');
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('From = $_from , To = $_to')));
      setState(() {
        FormConfig.from = _from;
        print('******* $_from');

      });
    }
  }

  Widget buildDateWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                initialValue: _from,
                decoration:  InputDecoration(labelText: 'From ${FormConfig.from}'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (valueFromSave) => _from =valueFromSave,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                initialValue: _to,
                decoration:  InputDecoration(labelText: 'To'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (valueTosave) => _to= valueTosave,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  _submit(context);
                },
                child: Text('Go'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data ${FormConfig.from}'),
        ),
        body: Column(
          children: <Widget>[
            DateFilterForm(),
            Center(
              child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}