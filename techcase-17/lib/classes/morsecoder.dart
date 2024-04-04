import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morse_code_translator/morse_code_translator.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class Morsecoder {
  final MorseCode _morseCode = MorseCode();
  final TorchController torchController = TorchController();
  TextEditingController morseCode = TextEditingController();
  String output = '';

  void decode(String morseCode) {
    try {
      if (morseCode.isEmpty) {
        output += ' ';
      } else {
        output += _morseCode.deCode(morseCode);
      }
      print(output);
      this.morseCode.text = '';
    } catch (e) {
      throw 'Invalid morse code';
    }
  }

  String _encode(String normaleText) {
    try {
      return _morseCode.enCode(normaleText);
    } catch (e) {
      return 'Invalid text';
    }
  }

  void clear() {
    morseCode.text = '';
    output = '';
  }

  void deleteLast() {
    if (morseCode.text.isNotEmpty) {
      morseCode.text = morseCode.text.substring(0, morseCode.text.length - 1);
    } else {
      throw 'No more characters to delete';
    }
  }

  void addDot() {
    morseCode.text += '.';
    print(morseCode.text.toString());
  }

  void addDash() {
    morseCode.text += '-';
    print(morseCode.text.toString());
  }

  Future<void> toggleFlashlightWithMorseCode() async {
    if (output.isEmpty) {
      throw Exception();
    }
    final outputMorseCode = _encode(output);

    print(outputMorseCode);

    String morseCode = outputMorseCode.trim();
    for (int i = 0; i < morseCode.length; i++) {
      String character = morseCode[i];
      if (character == '.') {
        await torchController.toggle();
        await Future.delayed(Duration(milliseconds: 60), () {
          torchController.toggle();
        });
      } else if (character == '-') {
        await torchController.toggle();
        await Future.delayed(Duration(milliseconds: 180), () {
          torchController.toggle();
        });
      } else if (character == ' ') {
        await Future.delayed(Duration(milliseconds: 60));
      } else if (character == '/') {
        await Future.delayed(Duration(milliseconds: 180));
      }
    }
  }

  Future<void> _playBeep({required Duration duration}) async {
    final player = AudioPlayer();
    await player.play(UrlSource('www.soundjay.com/buttons/sounds/beep-09.mp3'));
    await Future.delayed(duration);
    await player.stop();
  }
}
