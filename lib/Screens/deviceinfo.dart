import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfo extends StatefulWidget {
  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  late Map details = {};
  late Map newMap;
  late List<dynamic> sample = [];
  late List<dynamic> sample2 = [];
  Future<void> getDeviceDetails() async {
    WidgetsFlutterBinding.ensureInitialized();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      print(info.toMap());
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      print(info.toMap());
    } else if (Platform.isLinux) {
      LinuxDeviceInfo info = await deviceInfo.linuxInfo;
      print(info.toMap());
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo info = await deviceInfo.macOsInfo;
      print(info.toMap());
    } else if (Platform.isWindows) {
      WindowsDeviceInfo info = await deviceInfo.windowsInfo;
      print(info.toMap());
    }

    final info = await deviceInfo.deviceInfo;
    print(info.toMap());
    setState(() {
      details = info.toMap();

      details.forEach((key, value) {
        sample.add(key);
        sample2.add(value);

        print('Key: $key');
        print('Value: $value');
        print('------------------------------');
      });
      print("sample is $sample");
      print("sample2 is $sample2");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device details"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              details.isNotEmpty
                  ? Container()
                  : Center(
                      child: ElevatedButton(
                          onPressed: () {
                            getDeviceDetails();
                          },
                          child: const Text("Get Phone Details")),
                    ),
              details.isEmpty
                  ? Container()
                  : Center(
                      child: ListView.builder(
                          itemCount: details.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sample[i].toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text("*************"),
                                  Text(
                                    sample2[i].toString(),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
