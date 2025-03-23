import 'dart:math';
import '../export.dart';

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

String generateUniqueTaskId() {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  Random random = Random();
  int randomNumber = random.nextInt(9000) + 1000;
  String paperId = "QP${timestamp.toString().substring(7)}$randomNumber";
  return paperId;
}

Future<String> selectDateTime(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    final DateTime combinedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      9,
      0,
      0,
    ).toUtc();

    return combinedDateTime.toIso8601String();
  } else {
    return "";
  }
}
