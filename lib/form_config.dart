import 'package:flutter/cupertino.dart';
class FormConfig extends ChangeNotifier{
  static String from = '1';
  //1 = quidem molestiae enim
  //4 = non ese culpa molestiae omnis sed optio

  void updateHttp(input){
    from = input;
    notifyListeners(); //this rebuilds the widget
  }
}