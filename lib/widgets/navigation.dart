import '../export.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

navigatePop() {
  return navigatorKey.currentState!.pop();
}

navigatePush(Widget widget) {
  return navigatorKey.currentState!
      .push(MaterialPageRoute(builder: (context) => widget));
}

navigatePushReplacement(Widget widget) {
  return navigatorKey.currentState!
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}

navigateToRemoveUntil(Widget widget) {
  return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false);
}
