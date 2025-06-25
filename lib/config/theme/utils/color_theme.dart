import 'package:flutter/material.dart';

class ColorTheme {
  // Color to text
  static Color textPrimary = HexColor.fromHex("#212121");
  static Color textSecondary = HexColor.fromHex("#757575");
  static Color iconsColor = HexColor.fromHex("#CAC4D0");

  // Color of theme
  static Color primaryColor = HexColor.fromHex("#6750A4");
  static Color lightPrimaryColor = HexColor.fromHex("#D0BCFF");
  static Color secondaryColor = HexColor.fromHex("#625B71");
  static Color accentColor = HexColor.fromHex("#03DAC6");

  // Backgrounds of theme
  static Color backgroundColor = HexColor.fromHex("#E6E1E5");
  static Color backgroundColorDark = HexColor.fromHex("#121212");
  static Color backgroundLight = HexColor.fromHex("#f4f4f4");
  static Color navigationBackgroundColorDark = HexColor.fromHex("#2A292D");
  static Color navigationBackgroundColorLight = HexColor.fromHex("#F7F2FA");

  // Utils
  static Color error = HexColor.fromHex("#EF5350");
  static Color divider = HexColor.fromHex("#BDBDBD");
  static Color success = HexColor.fromHex("#4caf50");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color disable = HexColor.fromHex("#bcbcbc");
}

extension HexColor on Color {
  /// Converts a hex color string to a [Color] object.
  /// The hex string can optionally start with '#' or not.
  /// If the hex string does not contain an alpha value, it will default to fully opaque (FF).
  static Color fromHex(String hexColor) {
    // Trim spaces and remove the '#' symbol if present
    hexColor = hexColor.trim().replaceAll("#", "");

    // Ensure that the hex color code has 6 or 8 characters (RGB or RGBA format)
    if (hexColor.length == 6) {
      // Add the alpha value 'FF' (fully opaque) for 6 character codes
      hexColor = 'FF$hexColor';
    } else if (hexColor.length != 8) {
      // Throw an exception if the hex color is not valid (not 6 or 8 characters long)
      throw FormatException(
          "Invalid hex color format. It should be either 6 or 8 characters long.");
    }

    // Parse the hex string to an integer and return a Color
    return Color(int.parse('0x$hexColor'));
  }
}
