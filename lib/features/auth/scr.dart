import 'package:todo/export.dart';

class OnBoardingPageModel {
  final String title;
  final String description;
  final String imagePath;

  OnBoardingPageModel(
      {required this.title,
      required this.description,
      required this.imagePath});
}

List<OnBoardingPageModel> splashPages = [
  OnBoardingPageModel(
    title: 'Welcome to Task Manager',
    description: 'Manage your tasks efficiently and effortlessly.',
    imagePath: 'assets/image/1.png',
  ),
  OnBoardingPageModel(
    title: 'Track Progress',
    description: 'Keep an eye on your task progress and achievements.',
    imagePath: 'assets/image/2.png',
  ),
  OnBoardingPageModel(
    title: 'Stay Organized',
    description: 'Never miss a deadline with our easy-to-use task planner.',
    imagePath: 'assets/image/3.png',
  ),
];

class OnBoardingCard extends StatelessWidget {
  final OnBoardingPageModel page;
  const OnBoardingCard({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(page.imagePath, height: 340), // Image
        heightSizedBox(30.0),
        Text(page.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        heightSizedBox(10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(page.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
        ),
        heightSizedBox(30.0),
      ],
    );
  }
}
