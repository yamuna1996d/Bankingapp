import 'dart:convert';

import 'package:bankingapp/Screens/View.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Models/UserModel.dart';

class Details extends StatefulWidget {

@override
_DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String name = "", discription = "",userid="";
  final GlobalKey _formGlobalKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1260,
          child: Stack(
            children: [
              Positioned(
                  top: 50,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10),
                    child: Container(
                      width: 340,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formGlobalKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25,),
                              child: Container(
                                child: Text("Product Details", style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1
                                ),),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 45.0, bottom: 7, right: 10, left: 10),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'UserID',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 2.0, right: 10, left: 10),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: new TextFormField(
                                            onChanged: (String value) {
                                              userid = value;
                                            },
                                            decoration: const InputDecoration(
                                                disabledBorder: InputBorder.none,
                                                hintText: "Enter Userid"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 45.0, bottom: 7, right: 10, left: 10),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Product Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 2.0, right: 10, left: 10),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: new TextFormField(
                                            onChanged: (String value) {
                                              name = value;
                                            },
                                            decoration: const InputDecoration(
                                                disabledBorder: InputBorder.none,
                                                hintText: "Enter Product Name"),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter Your name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 30.0, bottom: 7, right: 10, left: 10),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Description',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 2.0, right: 10, left: 10),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: new TextFormField(
                                            onChanged: (String value) {
                                              discription = value;
                                            },
                                            decoration: const InputDecoration(
                                                disabledBorder: InputBorder.none,
                                                hintText: "Enter Product Description"),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter Description';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),

                                child: FlatButton(
                                  onPressed: () {
                                      addDetails();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text("Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),

                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewDetails()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text("Get",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  void addDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          "title": name,
          "body": discription,
          "userId":userid
        })
    );
    print(response.body);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewDetails()));
  }
}