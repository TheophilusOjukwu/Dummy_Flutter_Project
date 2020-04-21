import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_projectz/form_config.dart';

class DateFilterForm extends StatefulWidget {
  @override
  DateFilterFormState createState() {
    return DateFilterFormState();
  }
}


// Create a corresponding State class.
// This class holds data related to the form.
class DateFilterFormState extends State<DateFilterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _to = '04/23';
  String _from = '03/23';

  void _submit(BuildContext context) {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print('From = $_from , To = $_to');
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('From = $_from , To = $_to')));

      setState(() {
        //FormConfig.from = _from;
        Provider.of<FormConfig>(context, listen: false).updateHttp(_from);
        print('******* $_from');

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return buildDateWidget(context);
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
}