import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/UserModel.dart';
import '../Providers/UserProvider.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body:
            Consumer<UserDataProvider>(builder: (context, userProvider, child) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: userProvider.count,
              itemBuilder: (context, index) {
                return userProvider.items != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                "User ID",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(":"),
                                                ),
                                                Container(
                                                  child: Text(
                                                    userProvider
                                                        .items[index].userId
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                "Body",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(":"),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    userProvider
                                                        .items[index].body
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                "Title",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    ":",
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Container(
                                                    child: Text(
                                                      userProvider
                                                          .items[index].title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Container();
              });
        }));
  }

  Future getUserDetails() async {
    List<UserDetails>? list;
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(json.decode(response.body).toString());
    list = (json.decode(response.body) as List)
        .map((data) => new UserDetails.fromJson(data))
        .toList();
    Provider.of<UserDataProvider>(context, listen: false).setProducts(list);
  }
}
