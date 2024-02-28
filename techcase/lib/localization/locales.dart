import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("es", LocaleData.ES),
  MapLocale("zh", LocaleData.ZH),
  MapLocale("ar", LocaleData.AR),
];

mixin LocaleData {
  static const String title = "title";
  static const String body = "body";
  static const String batteryLevel = "batteryLevel";

  static const Map<String, dynamic> EN = {
    title: "TechCase 9",
    body: "Welcome to TechCase 9",
    batteryLevel: "Battery Level:",
  };

  static const Map<String, dynamic> ES = {
    title: "TechCase 9",
    body: "Bienvenido a TechCase 9",
    batteryLevel: "Nivel de batería:",
  };

  static const Map<String, dynamic> ZH = {
    title: "TechCase 9",
    body: "欢迎来到TechCase 9",
    batteryLevel: "电池电量：",
  };

  static const Map<String, dynamic> AR = {
    title: "TechCase 9",
    body: "مرحبًا بك في TechCase 9",
    batteryLevel: "مستوى البطارية:",
  };
}
