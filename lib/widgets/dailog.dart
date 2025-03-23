// Alert Dialog Box
import '../../export.dart';

// make snackBarKey and assign in
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void snackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}

Future<void> showCustomDialog(
  BuildContext context, {
  String title = '',
  String content = '',
  VoidCallback? onPressed1,
  VoidCallback? onPressed2,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User can only close via buttons
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        content: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:
                Text(content, style: Theme.of(context).textTheme.bodyMedium)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: onPressed1,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: Text(" Ok ",
                      style: Theme.of(context).textTheme.labelMedium)),
              ElevatedButton(
                onPressed: onPressed2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text("Cancel",
                    style: Theme.of(context).textTheme.labelMedium),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void showDialogBox(
    {String message = '',
    String title = '',
    bool loading = false,
    Color titleColor = Colors.black,
    double titleFontSize = 20,
    Color messageColor = Colors.black,
    double messageFontSize = 15}) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: titleColor,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: SizedBox(
            height: 90,
            width: 90,
            child: Center(
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        message,
                        style: TextStyle(
                            color: messageColor, fontSize: messageFontSize),
                      )),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ]);
    },
  );
}

void closeLoadingDialog() {
  navigatorKey.currentState!.pop();
}
