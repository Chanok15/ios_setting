// commit by christian
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: SettingsScreen(),
  ));
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Settings"),
      ),
      child: _mainSettings(),
    );
  }

  // commit by rence
  Widget _mainSettings() {
    return ListView(
      children: [
        CupertinoListSection.insetGrouped(
          children: [
            CupertinoListTile(
              title: const Text("Airplane Mode"),
              leading: _iconWithColor(CupertinoIcons.airplane, CupertinoColors.systemOrange),
              trailing: CupertinoSwitch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            CupertinoListTile(
              title: const Text("Wi-Fi"),
              leading: _iconWithColor(CupertinoIcons.wifi, CupertinoColors.systemBlue),
              additionalInfo: const Text("SM Free WiFi"),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const WifiScreen()),
                );
              },
            ),
            CupertinoListTile(
              title: const Text("Bluetooth"),
              leading: _iconWithColor(CupertinoIcons.bluetooth, CupertinoColors.systemBlue),
              additionalInfo: const Text("On"),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const BluetoothScreen()),
                );
              },
            ),
            CupertinoListTile(
              title: const Text("Cellular"),
              leading: _iconWithColor(CupertinoIcons.antenna_radiowaves_left_right, CupertinoColors.systemGreen),
              trailing: const CupertinoListTileChevron(),
            ),
            CupertinoListTile(
              title: const Text("Personal Hotspot"),
              leading: _iconWithColor(CupertinoIcons.personalhotspot, CupertinoColors.systemGreen),
              additionalInfo: const Text("Off"),
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
      ],
    );
  }
}


