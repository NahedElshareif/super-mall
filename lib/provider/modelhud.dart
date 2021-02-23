import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool isLoading=false;

  ChangeIsLoading(bool value){

    isLoading=value;
    notifyListeners();
  }
}