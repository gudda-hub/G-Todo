import '../export.dart';

class Responsive {
  //size for desktop > 1100.0 // mobile <700.0
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 500.0;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 500.0 &&
      MediaQuery.of(context).size.width < 1000.0;
  static bool isDeskTop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000.0;
}

getWidth(context, width) {
  double screenWidth = width(context);
  return (width / 375.0) * screenWidth;
}

getHeight(context, height) {
  double screenWidth = height(context);
  return (height / 812.0) * screenWidth;
}
