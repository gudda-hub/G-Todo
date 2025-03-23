import 'dart:developer';
import '../../export.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: splashPages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final page = splashPages[index];
              return OnBoardingCard(page: page);
            },
          ),

          // Page Indicator
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashPages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.transparent,
                    border: Border.all(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),

          // Next/Done Button
          Positioned(
            bottom: 55,
            right: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  fixedSize: const Size.fromHeight(54),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(12)))),
              onPressed: () async {
                if (_currentPage == splashPages.length - 1) {
                  String newToken = await getDeviceToken(ref);
                  log("New TOken :$newToken");
                  if (newToken.isNotEmpty) {
                    ref
                        .watch(secureStorageProvider)
                        .writeData(key: DbUrls.deviceToken, value: newToken);
                    navigatePushReplacement(const HomeScreen());
                  }
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 300),
                width: _currentPage == splashPages.length - 1 ? 120 : 80,
                child: Center(
                  child: Text(
                    _currentPage == splashPages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
