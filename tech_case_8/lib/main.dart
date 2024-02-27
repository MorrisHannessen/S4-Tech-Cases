import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Case 8',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 32, 228)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tech Case 8: Augmented TQ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // logic
    Position? _CurrentLocation;
    late bool servicePermission = false;
    late LocationPermission permission;

    String _currentAdress = "";

    Future<Position> _getCurrentLocation() async {
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!servicePermission) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location services are disabled');
        }
      }
      return await Geolocator.getCurrentPosition();
    }

    void _printLocation() async {
      _CurrentLocation = await _getCurrentLocation();
      print(_CurrentLocation);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/fontys-logo.png', height: 120, width: 120),
            SizedBox(height: 16),
            const Text(
              'Welcome to Augmented TQ!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _printLocation,
              child: Text('Save location'),
            ),
            ElevatedButton(
              onPressed: _printLocation,
              child: Text('Go to saved location'),
            ),
            ElevatedButton(
              onPressed: _printLocation,
              child: Text('Go to ISSD'),
            ),
          ],
        ),
      ),
    );
  }
}
