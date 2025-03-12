// commit by christian
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

// commit by rence
class _BluetoothScreenState extends State<BluetoothScreen> {
  bool isBluetoothEnabled = true;
  bool isBluetoothSwitchLoading = false;
  bool isSearching = false; // For loading animation in "Other Devices"

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Bluetooth"),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text("Edit", style: TextStyle(color: CupertinoColors.activeBlue)),
          onPressed: () {},
        ),
      ),
      child: _bluetoothSettings(),
    );
  }

  //commit by aron
  Widget _bluetoothSettings() {
    return ListView(
      children: [
        const SizedBox(height: 10),
        _bluetoothHeader(),
        const SizedBox(height: 10),
        CupertinoListSection.insetGrouped(
          children: [
            CupertinoListTile(
              title: const Text("Bluetooth"),
              trailing: isBluetoothSwitchLoading
                  ? const CupertinoActivityIndicator(radius: 10)
                  : CupertinoSwitch(
                      value: isBluetoothEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          isBluetoothSwitchLoading = true;
                        });

                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            isBluetoothSwitchLoading = false;
                            isBluetoothEnabled = value;
                            isSearching = value; // Start searching when turned on
                          });
                        });
                      },
                    ),
            ),
            if (isBluetoothEnabled)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Text(
                  "This iPhone is discoverable as 'iPhone' while Bluetooth Settings is open.",
                  style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
                ),
              ),
          ],
        ),
