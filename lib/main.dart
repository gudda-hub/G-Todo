import 'export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider);
    return MaterialApp(
      navigatorKey: navigatorKey, scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: ColorTheme.getPrimary(isDarkMode),
        cardColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor:
              isDarkMode ? ColorTheme.primaryDark : ColorTheme.primaryLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              // color: ColorTheme.getText(isDarkMode)
              color: ColorTheme.textDark),
          iconTheme: IconThemeData(color: ColorTheme.getIcon(isDarkMode)),
        ),
        scaffoldBackgroundColor: ColorTheme.getBackground(isDarkMode),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: ColorTheme.getText(isDarkMode),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: ColorTheme.getText(isDarkMode),
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: ColorTheme.getSecondaryText(isDarkMode),
          ),
        ),
        iconTheme: IconThemeData(color: ColorTheme.getIcon(isDarkMode)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorTheme.getButton(isDarkMode),
            foregroundColor: Colors.white,
            // foregroundColor: ColorTheme.getText(isDarkMode)
          ),
        ),
      ),
      home: const SplashScreen(),
      // home: const HomeScreen(),
    );
  }
}
