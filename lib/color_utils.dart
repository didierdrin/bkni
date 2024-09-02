

import 'package:flutter/material.dart';

class ColorUtils {
  static Color parseColor(String color) {
    if (color.startsWith('#')) {
      return Color(int.parse(color.replaceAll('#', '0xFF')));
    } else {
      // Handle color names
      switch (color.toLowerCase()) {
        case 'white':
          return Colors.white;
        case 'black':
          return Colors.black;
        case 'red':
          return Colors.red;
        case 'green':
          return Colors.green;
        case 'blue':
          return Colors.blue;
        // Add more color cases as needed
        default:
          return Colors.grey; // Default color if the name is not recognized
      }
    }
  }
}