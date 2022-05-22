import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => const SettingsPage());
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _currentSpeedValue = 20;
  double _currentToneValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SETTINGS",
          style: TextStyle(fontFamily: "CarterOne", fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 255, 187),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Text(
              "SPEED = " + _currentSpeedValue.toStringAsFixed(2) + "WPM",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Slider(
            value: _currentSpeedValue,
            max: 50,
            min: 5,
            label: _currentSpeedValue.round().toString(),
            activeColor: Colors.amber,
            inactiveColor: Colors.grey,
            onChanged: (double value) {
              setState(() {
                _currentSpeedValue = value;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Text(
              "TONE = " + _currentToneValue.toStringAsFixed(2) + "Hz",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Slider(
            value: _currentToneValue,
            max: 1000,
            min: 20,
            label: _currentToneValue.round().toString(),
            activeColor: Colors.amber,
            inactiveColor: Colors.grey,
            onChanged: (double value) {
              setState(() {
                _currentToneValue = value;
              });
            },
          ),
          ElevatedButton(
              onPressed: (() {}),
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  fixedSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0))),
              child: const Text(
                "CHANGE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
