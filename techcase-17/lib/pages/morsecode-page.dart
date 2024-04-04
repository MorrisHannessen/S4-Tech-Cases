import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:techcase17/classes/morsecoder.dart';
import 'package:torch_controller/torch_controller.dart';

class MorseCodePage extends StatefulWidget {
  @override
  _MorseCodePageState createState() => _MorseCodePageState();
}

class _MorseCodePageState extends State<MorseCodePage> {
  final TorchController _torchController = TorchController();
  final Morsecoder _morsecoder = Morsecoder();
  String decodedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Morse Decoder',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
        ),
        backgroundColor:
            Colors.lightGreen, // Set background color to light green
        toolbarHeight: 100.0,
      ),
      body: Container(
        color: Colors.lightGreen,
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                  'To use the app, tap the screen to add a dot, and long press to add a dash. to make a space just send an empty field, Swipe left to delete the last character. Tap the "Send Letter" button to decode the morse code. Tap the "Clear Fields" button to clear the fields. Tap the "Play Morse code with flashlight" button to play the morse code with the flashlight.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(height: 20.0),
              Text(
                _morsecoder.morseCode.text.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onLongPress: () {
                  _morsecoder.addDash();
                  setState(() {});
                },
                onTap: () {
                  _morsecoder.addDot();
                  setState(() {});
                },
                onHorizontalDragEnd: (DragEndDetails details) {
                  try {
                    _morsecoder.deleteLast();
                    setState(() {});
                  } catch (e) {
                    print(e);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45.0),
                  child: Container(
                    height: 60.0,
                    color: Colors.grey,
                    child: const Center(
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  try {
                    _morsecoder.decode(_morsecoder.morseCode.text.toString());
                    setState(() {});
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Invalid morse code'),
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
                },
                child: const Text('Send Letter'),
              ),
              ElevatedButton(
                onPressed: () {
                  _morsecoder.clear();
                  setState(() {});
                },
                child: const Text('Clear Fields'),
              ),
              const SizedBox(height: 20.0),
              Text(
                _morsecoder.output.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _morsecoder.toggleFlashlightWithMorseCode();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(e.toString()),
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
                },
                child: Text('Play Morse code with flashlight'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
