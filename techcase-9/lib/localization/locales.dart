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
  static const String emptyPhone = "emptyPhone";
  static const String fullPhone = "fullPhone";
  static const String hours = "hours";
  static const String minutes = "minutes";

  static const Map<String, dynamic> EN = {
    title: "TechCase 9",
    body: "Welcome to TechCase 9",
    batteryLevel: "Battery Level:",
    emptyPhone: "Time left till phone is empty:",
    fullPhone: "Time left till phone is full:",
    hours: "Hours",
    minutes: "Minutes",
  };

  static const Map<String, dynamic> ES = {
    title: "TechCase 9",
    body: "Bienvenido a TechCase 9",
    batteryLevel: "Nivel de batería:",
    emptyPhone: "Tiempo restante hasta que el teléfono esté vacío:",
    fullPhone: "Tiempo restante hasta que el teléfono esté lleno:",
    hours: "Horas",
    minutes: "Minutos",
  };

  static const Map<String, dynamic> ZH = {
    title: "TechCase 9",
    body: "欢迎来到TechCase 9",
    batteryLevel: "电池电量：",
    emptyPhone: "手机剩余时间：",
    fullPhone: "手机充满时间：",
    hours: "小时",
    minutes: "分钟",
  };

  static const Map<String, dynamic> AR = {
    title: "TechCase 9",
    body: "مرحبًا بك في TechCase 9",
    batteryLevel: "مستوى البطارية:",
    emptyPhone: "الوقت المتبقي حتى ينفد الهاتف:",
    fullPhone: "الوقت المتبقي حتى يمتلئ الهاتف:",
    hours: "ساعات",
    minutes: "دقائق",
  };
}
