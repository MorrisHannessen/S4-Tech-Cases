import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:techcase/localization/locales.dart';
import 'package:battery_plus/battery_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalization _flutterLocalization;
  var battery = Battery();
  late int _batteryLevel;
  late String _currentLocale;
  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    _getBatteryLevel();
    print(_currentLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleData.title.getString(context),
        ),
        actions: [
          DropdownButton(
            value: _currentLocale,
            items: const [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "es",
                child: Text("Spanish"),
              ),
              DropdownMenuItem(
                value: "zh",
                child: Text("Chinese"),
              ),
              DropdownMenuItem(
                value: "ar",
                child: Text("Arabic"),
              ),
            ],
            onChanged: (value) {
              _setLocale(value);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.formatString(LocaleData.body, ["Morris"]),
              style: const TextStyle(fontSize: 21),
            ),
            SizedBox(height: 20),
            Text(
              context.formatString(LocaleData.batteryLevel, ["Morris"]) +
                  " $_batteryLevel%",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "es") {
      _flutterLocalization.translate("es");
    } else if (value == "zh") {
      _flutterLocalization.translate("zh");
    } else if (value == "ar") {
      _flutterLocalization.translate("ar");
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }

  Future<void> _getBatteryLevel() async {
    final batteryLevel = await battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
