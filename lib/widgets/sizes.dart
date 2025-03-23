import '../../export.dart';

double heightMediaQuery(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double widthMediaQuery(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Container verticalDivider(double height) {
  return Container(height: height, width: 1, color: Colors.black26);
}

Container horizontalDivider(width) {
  return Container(height: 0.4, width: width / 1.0, color: Colors.black26);
}

SizedBox heightSizedBox(height) {
  return SizedBox(height: height / 1.0);
}

SizedBox widthSizedBox(width) {
  return SizedBox(width: width / 1.0);
}
