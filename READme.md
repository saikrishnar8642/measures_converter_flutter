# Measures Converter App

A Flutter-based application to convert between metric and imperial units for distance and weight. The app allows users to input a value, select units to convert from and to, and displays the converted result instantly.

---
## Features

- Convert between meters, kilometers, feet, miles (distance)

- Convert between grams, kilograms, pounds, ounces (weight)

- Dropdown menus for selecting "From" and "To" units

- Input validation to prevent invalid conversions

- Responsive UI suitable for web and mobile browsers

- Clean and readable code with comments following Dart best practices

---
## Project Structure

        flutter_application_1/
        ├─ lib/
        │   └─ main.dart          # Main application code
        ├─ android/               # Android platform files
        ├─ ios/                   # iOS platform files (optional)
        ├─ web/                   # Web deployment files (optional)
        ├─ pubspec.yaml           # Manifest and dependencies
        ├─ README.md              # Project instructions
        ├─ analysis_options.yaml  # Linting rules (optional)

---
## Getting Started

- These instructions will help you run the app on your machine or phone.

### Prerequisites

- Flutter SDK installed (Flutter installation guide
)

- Dart SDK (included with Flutter)

- Visual Studio Code or Android Studio

- Web browser (Chrome/Edge) or Android/iOS device

---
### Installing Dependencies

- Open terminal in the project folder:

                  flutter pub get


- This installs all required packages and dependencies.

- Running the App on a Web Browser

- Run the app on a local web server:

                flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0


- Open a web browser and enter:

                http://<your-PC-IP>:5000


- Replace <your-PC-IP> with your computer’s local IP address.

- Running the App on an Android Device

- Connect your Android device via USB and enable Developer Mode & USB Debugging.

- Check connected devices:

                flutter devices


### Run the app:

                flutter run -d <device-id>
                Replace <device-id> with your device’s ID from the previous command.

### Using the App

- Enter a numeric value in the Value field.

- Select the unit to convert From and To using the dropdowns.

- Press Convert.

- The result will appear below the button.

### Coding Best Practices Followed

- Clear and meaningful variable names

- Proper comments explaining logic and UI components

- Input validation to prevent errors

- Separation of UI and logic inside a StatefulWidget

- Consistent formatting according to Effective Dart

---
## More Features

- The app works for both distance and weight units only

- Invalid or incompatible conversions (e.g., meters → pounds) will show an error message

- Compatible with web, Android, and iOS platforms


---
