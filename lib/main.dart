import 'package:flutter/material.dart';

void main() {
  runApp(UnitApp());
}

class UnitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ConversionPage(),
    );
  }
}

class ConversionPage extends StatefulWidget {
  @override
  ConversionPageState createState() => ConversionPageState();
}

class ConversionPageState extends State<ConversionPage> {
  final Map<String, List<String>> units = {
    'Length': ['Meters', 'Kilometers', 'Miles'],
    'Weight': ['Kilograms', 'Pounds'],
    'Temperature': ['Celsius', 'Fahrenheit'],
    'Time': ['Seconds', 'Minutes', 'Hours'],
  };

  String? category;
  String? fromUnit;
  String? toUnit;
  TextEditingController inputController = TextEditingController();
  String result = "";

  void convert() {
    if (category == null ||
        fromUnit == null ||
        toUnit == null ||
        inputController.text.isEmpty) {
      setState(() {
        result = "Please fill all fields.";
      });
      return;
    }

    double input = double.tryParse(inputController.text) ?? 0.0;

    if (category == 'Length') {
      if (fromUnit == 'Meters' && toUnit == 'Kilometers') {
        result = (input / 1000).toString() + " Kilometers";
      } else if (fromUnit == 'Kilometers' && toUnit == 'Meters') {
        result = (input * 1000).toString() + " Meters";
      } else if (fromUnit == 'Meters' && toUnit == 'Miles') {
        result = (input / 1609.34).toStringAsFixed(6) + " Miles";
      } else if (fromUnit == 'Miles' && toUnit == 'Meters') {
        result = (input * 1609.34).toStringAsFixed(6) + " Meters";
      } else if (fromUnit == 'Kilometers' && toUnit == 'Miles') {
        result = (input / 1.60934).toStringAsFixed(6) + " Miles";
      } else if (fromUnit == 'Miles' && toUnit == 'Kilometers') {
        result = (input * 1.60934).toStringAsFixed(6) + " Kilometers";
      } else if (fromUnit == toUnit) {
        result = "You Are Using the same Unit";
      } else {
        result = "Conversion logic not implemented.";
      }
    } else if (category == 'Weight') {
      if (fromUnit == 'Kilograms' && toUnit == 'Pounds') {
        result = (input * 2.20462).toStringAsFixed(6) + " Pounds";
      } else if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
        result = (input / 2.20462).toStringAsFixed(6) + " Kilograms";
      } else if (fromUnit == toUnit) {
        result = "You Are Using the same Unit";
      }
    } else if (category == 'Temperature') {
      if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
        result = ((input * 9 / 5) + 32).toStringAsFixed(6) + " Fahrenheit";
      } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
        result = ((input - 32) * 5 / 9).toStringAsFixed(6) + " Celsius";
      } else if (fromUnit == toUnit) {
        result = "You Are Using the same Unit";
      }
    } else if (category == 'Time') {
      if (fromUnit == 'Hours' && toUnit == 'Minutes') {
        result = (input * 60).toStringAsFixed(6) + " Minutes";
      } else if (fromUnit == 'Hours' && toUnit == 'Seconds') {
        result = (input * 3600).toStringAsFixed(6) + " Seconds";
      } else if (fromUnit == 'Minutes' && toUnit == 'Hours') {
        result = (input / 60).toStringAsFixed(6) + " Hours";
      } else if (fromUnit == 'Minutes' && toUnit == 'Seconds') {
        result = (input * 60).toStringAsFixed(6) + " Seconds";
      } else if (fromUnit == 'Seconds' && toUnit == 'Hours') {
        result = (input / 3600).toStringAsFixed(6) + " Hours";
      } else if (fromUnit == 'Seconds' && toUnit == 'Minutes') {
        result = (input / 60).toStringAsFixed(6) + " Minutes";
      } else if (fromUnit == toUnit) {
        result = "You Are Using the same Unit";
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Conversion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              hint: Text('Select Category'),
              value: category,
              items: units.keys.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  category = value;
                  fromUnit = null;
                  toUnit = null;
                });
              },
            ),
            SizedBox(height: 16),
            if (category != null)
              DropdownButton<String>(
                hint: Text('From Unit'),
                value: fromUnit,
                items: units[category]?.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fromUnit = value;
                  });
                },
              ),
            SizedBox(height: 16),
            if (category != null)
              DropdownButton<String>(
                hint: Text('To Unit'),
                value: toUnit,
                items: units[category]?.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    toUnit = value;
                  });
                },
              ),
            SizedBox(height: 16),
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(
              result,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
