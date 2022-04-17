import 'package:flutter/material.dart';

import '../Models/UserModel.dart';

class UserDataProvider extends ChangeNotifier{
  List<UserDetails> _items = [];

  List<UserDetails> get items{
    return _items;
  }

  int get count{
    return _items.length;
  }

  void setProducts(List<UserDetails> items){
    _items = items;
    notifyListeners();
  }
}