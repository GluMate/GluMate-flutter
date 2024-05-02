import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDevicesView extends StatefulWidget {
  const BluetoothDevicesView({Key? key}) : super(key: key);

  @override
  State<BluetoothDevicesView> createState() => _BluetoothDevicesViewState();
}

class _BluetoothDevicesViewState extends State<BluetoothDevicesView> {
  List<ScanResult> _discoveredDevices = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartScan();
  }

  void _checkPermissionsAndStartScan() async {
    if (await _checkLocationPermission()) {
      _startScan();
    } else {
      // Handle case where location permission is not granted
      // You can show a dialog or request permission again
    }
  }

  Future<bool> _checkLocationPermission() async {
    if (await Permission.location.isGranted) {
      return true;
    } else {
      var status = await Permission.location.request();
      return status == PermissionStatus.granted;
    }
  }

  void _startScan() {
    const int scanDurationSeconds = 60;
    const int desiredRssiThreshold = -100;

    FlutterBlue.instance
        .startScan(timeout: Duration(seconds: scanDurationSeconds));

    FlutterBlue.instance.scanResults.listen((List<ScanResult> results) {
      if (mounted) {
        setState(() {
          _discoveredDevices = results
              .where((result) => result.rssi > desiredRssiThreshold)
              .toList();
        });
      }
    });
  }

  @override
  void dispose() {
    FlutterBlue.instance.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: _discoveredDevices.length,
        itemBuilder: (context, index) {
          ScanResult device = _discoveredDevices[index];
          if (device.device.name != null && device.device.name!.length >= 1) {
            return ListTile(
              title: Text(device.device.name!),
              subtitle: Text(device.device.id.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
