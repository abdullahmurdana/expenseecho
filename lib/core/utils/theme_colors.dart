import 'package:flutter/material.dart';

// const String themeColorHex = "#7F3DFF";

const int _violetPrimaryValue = 0xFF7F3DFF;
const int _darkPrimaryValue = 0xFF0D0E0F;
const int _lightPrimaryValue = 0xFFFFFFFF;
const int _redValue = 0xFFFD3C4A;
const int _greenValue = 0xFF00A86B;
const int _blueValue = 0xFF0077FF;
const int _yellowValue = 0xFF00A86B;
const int _tealPrimaryValue = 0xFF008080;
const int _orangePrimaryValue = 0xFFFF5722;

const MaterialColor orangeColor = MaterialColor(
  _orangePrimaryValue,
  <int, Color>{
    100: Color(0xFFFF5722), // Orange 100
    80: Color(0xFFFF7043), // Orange 80
    60: Color(0xFFFF8A65), // Orange 60
    40: Color(0xFFFFAB91), // Orange 40
    20: Color(0xFFFFDAB9), // Orange 20
  },
);

const MaterialColor tealColor = MaterialColor(
  _tealPrimaryValue,
  <int, Color>{
    100: Color(0xFF008080), // Teal 100
    80: Color(0xFF009688), // Teal 80
    60: Color(0xFF4DB6AC), // Teal 60
    40: Color(0xFF80CBC4), // Teal 40
    20: Color(0xFFC8E6C9), // Teal 20
  },
);

const MaterialColor violetColor = MaterialColor(
  _violetPrimaryValue,
  <int, Color>{
    100: Color(0xFF7F3DFF), // Violet 100
    80: Color(0xFF8F57FF), // Violet 80
    60: Color(0xFFB18AFF), // Violet 60
    40: Color(0xFFD3BDFF), // Violet 40
    20: Color(0xFFEEE5FF), // Violet 20
  },
);

const MaterialColor darkThemeColor = MaterialColor(
  _darkPrimaryValue,
  <int, Color>{
    100: Color(0xFF0D0E0F), // Dark 100
    75: Color(0xFF161719), // Dark 75
    50: Color(0xFF212325), // Dark 50
    25: Color(0xFF292B2D), // Dark 25
  },
);

const MaterialColor lightThemeColor = MaterialColor(
  _lightPrimaryValue,
  <int, Color>{
    100: Color(0xFFFFFFFF), // Light 100
    80: Color(0xFFFCFCFC), // Light 80
    60: Color(0xFFF1F1FA), // Light 60
    40: Color(0xFFE3E5E5), // Light 40
    20: Color(0xFF91919F), // Light 20
  },
);

const MaterialColor redThemeColor = MaterialColor(
  _redValue,
  <int, Color>{
    100: Color(0xFFFD3C4A), // red 100
    80: Color(0xFFFD5662), // red 80
    60: Color(0xFFFD6F7A), // red 60
    40: Color(0xFFFDA2A9), // red 40
    20: Color(0xFFFDD5D7), // red 20
  },
);

const MaterialColor greenThemeColor = MaterialColor(
  _greenValue,
  <int, Color>{
    100: Color(0xFF00A86B), // green 100
    80: Color(0xFF2AB784), // green 80
    60: Color(0xFF65D1AA), // green 60
    40: Color(0xFF93EACA), // green 40
    20: Color(0xFFCFFAEA), // green 20
  },
);

const MaterialColor yellowThemeColor = MaterialColor(
  _yellowValue,
  <int, Color>{
    100: Color(0xFFFCAC12), // Yellow 100
    80: Color(0xFFFCBB3C), // Yellow 80
    60: Color(0xFFFCCC6F), // Yellow 60
    40: Color(0xFFFCDDA1), // Yellow 40
    20: Color(0xFFFCEED4), // Yellow 20
  },
);

const MaterialColor blueThemeColor = MaterialColor(
  _blueValue,
  <int, Color>{
    100: Color(0xFF0077FF), // blue 100
    80: Color(0xFF248AFF), // blue 80
    60: Color(0xFF57A5FF), // blue 60
    40: Color(0xFF8AC0FF), // blue 40
    20: Color(0xFFBDDCFF), // blue 20
  },
);

const Map<String, Color> iconToBackgroundColor = {
  'Food': Color(0xFFFDD5D7),
  'Transportation': Color(0xFFBDDCFF),
  'Shopping': Color(0xFFFCEED4),
  'Utility Bills': Color(0xFFFFDAB9),
  'Subscriptions': Color(0xFFFCE4EC),
  'Salary': Color(0xFFCFFAEA),
  'Passive Income': Color(0xFF292B2D),
};
