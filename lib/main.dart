// Import the main Flutter material design package.
// This package contains all the widgets we need (App, Scaffold, Text, etc.)
import 'package:flutter/material.dart';

// The main() function is the entry point for all Flutter apps.
void main() {
  // runApp() inflates the given widget and attaches it to the screen.
  // MyApp is our root widget.
  runApp(const MyApp());
}

// MyApp is a StatelessWidget. It describes the "static" part of your app,
// like the title and theme, which don't change over time.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // The build() method describes the part of the user interface
  // represented by this widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title for the app (used by the OS)
      title: 'Measures Converter',
      // The theme applies a consistent visual style (colors, fonts)
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Disables the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,
      // The home screen of our app will be the ConverterHomePage widget
      home: const ConverterHomePage(),
    );
  }
}

// ConverterHomePage is a StatefulWidget. This means it can
// hold "state" – data that can change over time (like user input)
// and cause the UI to rebuild.
class ConverterHomePage extends StatefulWidget {
  const ConverterHomePage({super.key});

  @override
  // This creates the mutable state object for this widget.
  State<ConverterHomePage> createState() => _ConverterHomePageState();
}

// This class holds the "state" for ConverterHomePage.
// All our variables and logic will live here.
class _ConverterHomePageState extends State<ConverterHomePage> {
  // --- State Variables ---

  // Controller to manage the text field's content.
  final TextEditingController _inputController = TextEditingController();

  // The numeric value entered by the user.
  double? _inputValue;

  // The unit selected in the "From" dropdown.
  String _fromMeasure = 'meters';

  // The unit selected in the "To" dropdown.
  String _toMeasure = 'feet';

  // The text to display as the result.
  String _resultMessage = '';

  // --- Data for Dropdowns and Conversions ---

  // List of all available units.
  final List<String> _measures = [
    'meters',
    'kilometers',
    'feet',
    'miles',
    'kilograms',
    'grams',
    'pounds',
    'ounces',
  ];

  // Map defining the *type* of each unit (e.g., distance, weight).
  // This is crucial for preventing impossible conversions (like meters to pounds).
  final Map<String, String> _measureCategories = {
    'meters': 'distance',
    'kilometers': 'distance',
    'feet': 'distance',
    'miles': 'distance',
    'kilograms': 'weight',
    'grams': 'weight',
    'pounds': 'weight',
    'ounces': 'weight',
  };

  // Map of conversion factors.
  // We convert EVERYTHING to a "base" unit first (meters for distance, grams for weight).
  // Then we convert from that base unit to the target unit.
  final Map<String, double> _conversionFactors = {
    // Distance (Base: meters)
    'meters': 1.0,
    'kilometers': 1000.0,
    'feet': 0.3048,
    'miles': 1609.34,
    // Weight (Base: grams)
    'grams': 1.0,
    'kilograms': 1000.0,
    'pounds': 453.592,
    'ounces': 28.3495,
  };

  // --- Logic ---

  /// This function is called when the "Convert" button is pressed.
  void _convert() {
    // 1. Get the text from the input field.
    String inputText = _inputController.text;

    // 2. Try to parse the text into a number (double).
    double? value = double.tryParse(inputText);

    // 3. Check if the input is valid.
    if (value == null) {
      // If input is not a valid number, show an error message.
      setState(() {
        _resultMessage = 'Please enter a valid number';
      });
      return; // Stop the function here.
    }

    // 4. Check if the units are compatible (e.g., both are 'distance').
    if (_measureCategories[_fromMeasure] != _measureCategories[_toMeasure]) {
      // If units are not compatible, show an error.
      setState(() {
        _resultMessage = 'Cannot convert between different types';
      });
      return; // Stop the function here.
    }

    // 5. Perform the conversion.
    // Step 5a: Convert the input value to the "base" unit.
    double valueInBaseUnit = value * _conversionFactors[_fromMeasure]!;

    // Step 5b: Convert from the "base" unit to the target unit.
    double convertedValue = valueInBaseUnit / _conversionFactors[_toMeasure]!;

    // 6. Update the UI with the result.
    // setState() tells Flutter that our state has changed and it
    // needs to re-run the build() method to update the screen.
    setState(() {
      _inputValue = value;
      // Format the result to have 3 decimal places for readability.
      _resultMessage =
          '$value $_fromMeasure are ${convertedValue.toStringAsFixed(3)} $_toMeasure';
    });

    // Also, unfocus the text field to hide the keyboard.
    FocusScope.of(context).unfocus();
  }

  // --- UI Build Method ---

  @override
  Widget build(BuildContext context) {
    // Scaffold is a basic material design layout structure.
    // It gives us an AppBar (top bar) and a body (screen content).
    return Scaffold(
      // The top application bar.
      appBar: AppBar(
        title: const Text('Measures Converter'),
      ),
      // The main content of the screen.
      body: SingleChildScrollView(
        // Use Padding to add some space around all the content.
        padding: const EdgeInsets.all(24.0),
        // Column arranges its children vertically.
        child: Column(
          // CrossAxisAlignment.start makes children align to the left.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Input Value Field ---
            const Text(
              'Value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              // Set keyboard type to show numbers.
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: 'Enter the value to convert',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- "From" Dropdown ---
            const Text(
              'From',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: DropdownButton<String>(
                value: _fromMeasure, // The currently selected value.
                isExpanded: true, // Makes the dropdown take full width.
                underline: Container(), // Hides the default underline.
                // This is called when the user selects a new item.
                onChanged: (String? newValue) {
                  setState(() {
                    _fromMeasure = newValue!;
                  });
                },
                // Maps our list of strings to a list of DropdownMenuItem widgets.
                items: _measures.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // --- "To" Dropdown ---
            const Text(
              'To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: DropdownButton<String>(
                value: _toMeasure, // The currently selected value.
                isExpanded: true, // Makes the dropdown take full width.
                underline: Container(), // Hides the default underline.
                onChanged: (String? newValue) {
                  setState(() {
                    _toMeasure = newValue!;
                  });
                },
                items: _measures.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // --- Convert Button ---
            // Center the button horizontally.
            Center(
              child: ElevatedButton(
                // When pressed, call our _convert function.
                onPressed: _convert,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ),
            const SizedBox(height: 32),

            // --- Result Display ---
            // Center the result text.
            Center(
              child: Text(
                _resultMessage, // This is our state variable.
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
