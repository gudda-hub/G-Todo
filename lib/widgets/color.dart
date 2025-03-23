import '../export.dart';

class ColorTheme {
// Light Theme Colors
  static const Color primaryLight = Color(0xFF673AB7); // Vibrant purple
  static const Color bgLight = Color(0xFFF9F6FF); // Even softer background
  static const Color textLight =
      Color(0xFF14142B); // Darker text for excellent contrast
  static const Color text2Light = Color(0xFFE040FB); // Bright pink accent
  static const Color iconLight = Color(0xFF9E59CC); // Subtle purple for icons
  static const Color btnLight = Color(0xFFD16EF0); // Lighter button color

// Dark Theme Colors
  static const Color primaryDark = Color(0xFF311B92); // Deep purple
  static const Color bgDark = Color(0xFF12121C); // Very dark background
  static const Color textDark = Color(0xFFFFF5FF); // Bright white text
  static const Color text2Dark = Color(0xFFF50057); // Vivid pink accent
  static const Color iconDark = Color(0xFFB39DDB); // Subtle purple for icons
  static const Color btnDark = Color(0xFF8E24AA); // Darker button color

// Common getter based on theme mode
  static Color getPrimary(bool isDarkMode) =>
      isDarkMode ? primaryDark : primaryLight;
  static Color getBackground(bool isDarkMode) => isDarkMode ? bgDark : bgLight;
  static Color getText(bool isDarkMode) => isDarkMode ? textDark : textLight;
  static Color getSecondaryText(bool isDarkMode) =>
      isDarkMode ? text2Dark : text2Light;
  static Color getIcon(bool isDarkMode) => isDarkMode ? iconDark : iconLight;
  static Color getButton(bool isDarkMode) => isDarkMode ? btnDark : btnLight;
}
