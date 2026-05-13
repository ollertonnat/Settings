import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CupertinoApp(home: SettingsHome(), theme: CupertinoThemeData(brightness: Brightness.light), debugShowCheckedModeBanner: false));

class SettingsHome extends StatefulWidget {
  const SettingsHome({super.key});
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  String userName = "Max .";
  String bHealth = "96%"; 
  String bCycles = "279";
  String sNumber = "G0QTRQ23P3";
  String mNumber = "MYN63AE/A";
  String storage = "512 GB";
  String avail = "319.42 GB";

  void _showSecretEditor() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Admin Editor"),
          trailing: CupertinoButton(padding: EdgeInsets.zero, child: const Text("Done"), onPressed: () => Navigator.pop(context)),
        ),
        child: SafeArea(
          child: Material(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(decoration: const InputDecoration(labelText: "Serial Number"), onChanged: (v) => setState(() => sNumber = v)),
                TextField(decoration: const InputDecoration(labelText: "Battery Health (%)"), onChanged: (v) => setState(() => bHealth = v)),
                TextField(decoration: const InputDecoration(labelText: "Cycles"), onChanged: (v) => setState(() => bCycles = v)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(middle: Text("Settings"), border: null),
      child: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile.notched(
                leading: CircleAvatar(backgroundColor: Colors.grey.shade400, child: const Text("M", style: TextStyle(color: Colors.white))),
                title: Text(userName),
                subtitle: const Text("Apple Account, iCloud and more"),
                trailing: const CupertinoListTileChevron(),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile.notched(
                leading: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)), child: const Icon(CupertinoIcons.battery_100, color: Colors.white, size: 20)),
                title: const Text("Battery"),
                trailing: const CupertinoListTileChevron(),
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => BatteryMain(health: bHealth, cycles: bCycles))),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile.notched(
                leading: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(6)), child: const Icon(CupertinoIcons.settings_solid, color: Colors.white, size: 20)),
                title: const Text("General"),
                trailing: const CupertinoListTileChevron(),
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AboutPage(sn: sNumber, mod: mNumber, health: bHealth, cycles: bCycles, cap: storage, av: avail))),
              ),
            ],
          ),
          GestureDetector(
            onTapDown: (details) { if(details.tapCount == 3) _showSecretEditor(); },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text("Legal & Regulatory", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

class BatteryMain extends StatelessWidget {
  final String health, cycles;
  const BatteryMain({super.key, required this.health, required this.cycles});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Battery")),
      child: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile.notched(title: const Text("Battery Health"), additionalInfo: const Text("Normal"), trailing: const CupertinoListTileChevron(), 
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => BatteryDetail(health: health, cycles: cycles)))),
            ],
          ),
        ],
      ),
    );
  }
}

class BatteryDetail extends StatelessWidget {
  final String health, cycles;
  const BatteryDetail({super.key, required this.health, required this.cycles});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Battery Health")),
      child: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            footer: const Text("This is a measure of battery capacity relative to when it was new."),
            children: [ CupertinoListTile.notched(title: const Text("Maximum Capacity"), additionalInfo: Text(health, style: const TextStyle(fontWeight: FontWeight.bold))) ],
          ),
          CupertinoListSection.insetGrouped(
            header: const Text("BATTERY VALIDATION"),
            children: [ CupertinoListTile.notched(title: const Text("Cycle Count"), additionalInfo: Text(cycles)) ],
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final String sn, mod, health, cycles, cap, av;
  const AboutPage({super.key, required this.sn, required this.mod, required this.health, required this.cycles, required this.cap, required this.av});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("About")),
      child: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            children: [
              const CupertinoListTile.notched(title: Text("Model Name"), additionalInfo: Text("iPhone 16 Pro")),
              CupertinoListTile.notched(title: const Text("Model Number"), additionalInfo: Text(mod)),
              CupertinoListTile.notched(title: const Text("Serial Number"), additionalInfo: Text(sn)),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile.notched(title: const Text("Capacity"), additionalInfo: Text(cap)),
              CupertinoListTile.notched(title: const Text("Available"), additionalInfo: Text(av)),
            ],
          ),
        ],
      ),
    );
  }
}
