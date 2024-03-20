import 'package:flutter/material.dart';
import 'package:techcase17/pages/morsecode-page.dart';
import 'package:torch_controller/torch_controller.dart';

void main() {
  TorchController().initialize();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MorseCodePage(),
    );
  }
}
