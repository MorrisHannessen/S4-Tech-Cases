import 'dart:async';
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
  late BatteryState _batteryState;
  late String _currentLocale;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    _getBatteryLevel();
    _getBatteryState();
    _startUpdating(); // Start periodic updates
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
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
            SizedBox(height: 20),
            Container(
              width: 200,
              child: LinearProgressIndicator(
                value: _batteryLevel / 100,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getBatteryColor(_batteryLevel),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              context.formatString(LocaleData.emptyPhone, ["Morris"]) +
                  " ${calculateTimeToEmpty(_batteryLevel)}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            FutureBuilder<bool>(
              future: isCharging(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Text(
                    context.formatString(LocaleData.fullPhone, ["Morris"]) +
                        " ${calculateTimeToFullCharge(_batteryLevel)}",
                    style: TextStyle(fontSize: 16),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Returns an empty widget if not charging
                }
              },
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

  Color _getBatteryColor(int batteryLevel) {
    if (batteryLevel <= 20) {
      return Colors.red;
    } else if (batteryLevel <= 50) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  void _startUpdating() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getBatteryLevel();
      _getBatteryState();
    });
  }

  Future<void> _getBatteryLevel() async {
    final batteryLevel = await battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getBatteryState() async {
    final batteryState = await battery.batteryState;
    if (batteryState != _batteryState) {
      setState(() {
        _batteryState = batteryState;
      });
    }
  }

  Future<void> _refresh() async {
    await _getBatteryLevel();
  }

  Future<bool> isCharging() async {
    final BatteryState batteryState = await battery.batteryState;
    if (batteryState == BatteryState.charging) {
      return true;
    } else {
      return false;
    }
  }

  String calculateTimeToEmpty(int batteryLevel) {
    int batteryCapacity = 5000; // mAh
    int averageConsumption = 100; // mA
    final hoursToEmpty =
        (batteryLevel / 100) * batteryCapacity / averageConsumption;

    if (hoursToEmpty.isInfinite || hoursToEmpty.isNaN) {
      return 'N/A';
    }

    final hours = hoursToEmpty.floor();
    final minutes = ((hoursToEmpty - hours) * 60).round();

    return '$hours ' +
        LocaleData.hours.getString(context) +
        ' $minutes ' +
        LocaleData.minutes.getString(context);
  }

  String calculateTimeToFullCharge(int currentBatteryLevel) {
    double deviceBatteryCapacity = 5; //Ah
    double maxChargingVolt = 11; //Volt
    double maxChargingWatts = 33; //Watts
    double maxChargingRate = maxChargingWatts / maxChargingVolt; //Ampere
    double chargingEfficiency = 0.8; //80%
    if (currentBatteryLevel == 100) {
      return 'N/A';
    }
    int DoD = 100 - currentBatteryLevel;
    final hoursToFullCharge = (deviceBatteryCapacity * (DoD / 100)) /
        (maxChargingRate * chargingEfficiency);

    if (hoursToFullCharge.isInfinite || hoursToFullCharge.isNaN) {
      return 'N/A';
    }

    final hours = hoursToFullCharge.floor();
    final minutes = ((hoursToFullCharge - hours) * 60).round();

    return '$hours ' +
        LocaleData.hours.getString(context) +
        ' $minutes ' +
        LocaleData.minutes.getString(context);
  }
}
