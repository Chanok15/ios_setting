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
//commit by christian
        const SizedBox(height: 10),
        if (isBluetoothEnabled) ...[
          CupertinoListSection.insetGrouped(
            header: const Text("MY DEVICES"),
            children: [
              _bluetoothDeviceTile("Beats Pro", "Connected"),
              _bluetoothDeviceTile("K12", "Not Connected"),
              _bluetoothDeviceTile("JBL WAVE BUDS", "Not Connected"),
              _bluetoothDeviceTile("Bluetooth", "Not Connected"),
              _bluetoothDeviceTile("Apple AirPods Pro", "Not Connected"),
            ],
          ),
          CupertinoListSection.insetGrouped(
            header: Row(
              children: [
                const Expanded(child: Text("OTHER DEVICES")),
                if (isSearching)
                  const CupertinoActivityIndicator(radius: 8), // Show searching animation
              ],
            ),
            children: [
              _bluetoothDeviceTile("AirPods Pro", "Pairing..."),
            ],
          ),
        ],
      ],
    );
  }
  //committ by rence
  Widget _bluetoothHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: CupertinoColors.black,
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.bluetooth,
                size: 40,
                color: CupertinoColors.white, // White icon
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Bluetooth",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Connect to accessories you can use for activities such as streaming music, making phone calls, and gaming.",
            textAlign: TextAlign.center,
            style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {}, // Add action for Learn More
            child: const Text(
              "Learn More...",
              style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
