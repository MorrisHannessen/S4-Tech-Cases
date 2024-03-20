import 'package:flutter/material.dart';
import 'package:morse_code_translator/morse_code_translator.dart';
import 'package:techcase17/classes/morsecoder.dart';
import 'package:torch_controller/torch_controller.dart';

class MorseCodePage extends StatefulWidget {
  @override
  _MorseCodePageState createState() => _MorseCodePageState();
}

class _MorseCodePageState extends State<MorseCodePage> {
  TextEditingController _inputController = TextEditingController();
  TextEditingController _outputController = TextEditingController();
  Morsecoder morsecoder = Morsecoder();
  TorchController torchController = TorchController();

  void _encode() {
    String input = _inputController.text;
    String encodedText = morsecoder.encode(input);
    setState(() {
      _outputController.text = encodedText;
    });
    if (encodedText == 'Invalid text') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid text'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _decode() {
    String input = _inputController.text;
    String decodedText = morsecoder.decode(input);
    setState(() {
      _outputController.text = decodedText;
    });
    if (decodedText == 'Invalid morse code') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid Morse code'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _toggleFlashlightWithMorseCode() async {
    String morseCode = _outputController.text.trim();
    for (int i = 0; i < morseCode.length; i++) {
      String character = morseCode[i];
      if (character == '.') {
        await torchController.toggle();
        await Future.delayed(Duration(milliseconds: 500), () {
          torchController.toggle();
        });
      } else if (character == '-') {
        await torchController.toggle();
        await Future.delayed(Duration(milliseconds: 1000), () {
          torchController.toggle();
        });
      } else if (character == ' ') {
        // Pause between letters
        await Future.delayed(Duration(milliseconds: 750));
      } else if (character == '/') {
        // Pause between words
        await Future.delayed(Duration(milliseconds: 1250));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morse Decoder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Enter text to encode/decode',
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _encode,
                  child: Text('Encode'),
                ),
                ElevatedButton(
                  onPressed: _decode,
                  child: Text('Decode'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _outputController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Result',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _toggleFlashlightWithMorseCode,
              child: Text('Play Morse code with flashlight'),
            ),
          ],
        ),
      ),
    );
  }
}
