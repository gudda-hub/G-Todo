import 'package:intl/intl.dart';
import '../../export.dart';

class HomeHeaderSection extends StatelessWidget {
  final bool isDarkMode;
  const HomeHeaderSection(this.isDarkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat.jm().format(DateTime.now());
    String formattedDay = DateFormat('EEEE').format(DateTime.now());
    String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formattedDay,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: ColorTheme.getPrimary(isDarkMode))),
            heightSizedBox(10.0),
            Text("$formattedDate , $formattedTime",
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
