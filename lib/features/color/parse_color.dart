import 'dart:ui';

class ParseColor{



 static Color parseColor(String colorString) {
    String hexColor = colorString.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Adding full opacity if not provided
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}