import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bluetooth_screen.dart';

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
  bool _showMemberDialog = false; // State to control dialog visibility

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
            // Added Show Members option
            CupertinoListTile(
              title: const Text("Show Members"),
              leading: _iconWithColor(CupertinoIcons.person_3, CupertinoColors.systemIndigo),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                _showMembersDialog();
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showMembersDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Team Members"),
        content: Column(
          children: const [
            Text(" Rence Estoque"),
            Text(" Aron Villa"),
            Text(" Christian Suva"),
          ],
        ),

        actions: [
          CupertinoDialogAction(
            child: const Text("Close"),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _showMemberDialog = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Wi-Fi Screen
class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  _WifiScreenState createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  bool isWifiEnabled = true;
  bool isWifiSwitchLoading = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: const Text("Wi-Fi", style: TextStyle(color: CupertinoColors.white)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back, color: CupertinoColors.activeBlue),
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
      child: ListView(
        children: [
          const SizedBox(height: 10),
          _wifiHeader(),
          const SizedBox(height: 10),
          CupertinoListSection.insetGrouped(
            backgroundColor: CupertinoColors.black,
            children: [
              CupertinoListTile(
                title: const Text("Wi-Fi", style: TextStyle(color: CupertinoColors.white)),
                trailing: isWifiSwitchLoading
                    ? const CupertinoActivityIndicator(radius: 10)
                    : CupertinoSwitch(
                  value: isWifiEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isWifiSwitchLoading = true;
                    });

                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        isWifiSwitchLoading = false;
                        isWifiEnabled = value;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          if (isWifiEnabled) ...[
            CupertinoListSection.insetGrouped(
              backgroundColor: CupertinoColors.black,
              header: const Text("OTHER NETWORKS", style: TextStyle(color: CupertinoColors.white)),
              children: [
                _wifiNetworkTile("HCC_ICS_Lab"),
                _wifiNetworkTile("Network_1"),
                _wifiNetworkTile("Network_2"),
                _wifiNetworkTile("Network_3"),
                _wifiNetworkTile("Guest_Wifi"),
                _wifiNetworkTile("Other..."),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _wifiHeader() {
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.wifi,
                size: 40,
                color: CupertinoColors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Wi-Fi",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Connect to Wi-Fi, view available networks, and manage settings.",
            textAlign: TextAlign.center,
            style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Learn More...",
              style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wifiNetworkTile(String networkName) {
    return CupertinoListTile(
      title: Text(networkName, style: const TextStyle(color: CupertinoColors.white)),
      trailing: const Icon(CupertinoIcons.wifi, color: CupertinoColors.systemGrey),
    );
  }
}

Widget _iconWithColor(IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: CupertinoColors.white, size: 22),
  );
}
