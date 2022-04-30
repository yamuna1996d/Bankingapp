import 'dart:async';

import 'package:bankingapp/Screens/deviceinfo.dart';
import 'package:bankingapp/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class PhoneDetails extends StatefulWidget {
  const PhoneDetails({Key? key}) : super(key: key);

  @override
  State<PhoneDetails> createState() => _PhoneDetailsState();
}

class _PhoneDetailsState extends State<PhoneDetails> {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  late StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("internet status : $hasInternet"),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DeviceInfo()));
                },
                child: Text("Device info"),
              ),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      hasInternet =
                          await InternetConnectionChecker().hasConnection;
                      result = await Connectivity().checkConnectivity();
                      print("result is $result");
                      final color = hasInternet ? Colors.green : Colors.red;
                      final text = hasInternet ? "Internet" : "No Internet";
                      //print(text);

                      if (result == ConnectivityResult.mobile) {
                        showSimpleNotification(
                            Text("$text :Mobile network",
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                            background: color);
                      } else if (result == ConnectivityResult.wifi) {
                        showSimpleNotification(
                            Text("$text :Wifi network",
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                            background: color);
                      } else {
                        showSimpleNotification(
                            Text("$text :No network",
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                            background: color);
                      }
                    },
                    child: const Text("check internet")))
          ]),
    );
  }
}
