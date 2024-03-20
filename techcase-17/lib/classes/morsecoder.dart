import 'package:flutter/material.dart';
import 'package:morse_code_translator/morse_code_translator.dart';

class Morsecoder {
  final MorseCode _morseCode = MorseCode();

  String decode(String morseCode) {
    try {
      return _morseCode.deCode(morseCode);
    } catch (e) {
      return 'Invalid morse code';
    }
  }

  String encode(String normaleText) {
    try {
      return _morseCode.enCode(normaleText);
    } catch (e) {
      return 'Invalid text';
    }
  }
}
