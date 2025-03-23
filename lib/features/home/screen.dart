import '../../export.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              header(ref, isDarkMode, context),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: taskTypes.length,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TaskType taskType = taskTypes[index];
                      return TaskTypeCard(taskType: taskType);
                    }),
              ),
              heightSizedBox(20.0),
              Text("Pending",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const HomePendingTask(),
              heightSizedBox(80.0),
            ]),
      ),
      bottomSheet: Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * .85,
          height: 55,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  surfaceTintColor: Colors.grey,
                  overlayColor: Colors.blueGrey),
              onPressed: _createBtn,
              child: Text(
                "Add New Task",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white70),
              ))),
    );
  }

  _createBtn() {
    navigatePush(const TaskCreateScreen());
  }

  header(WidgetRef ref, bool isDarkMode, BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text("QZ",
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displayLarge)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
                  },
                  icon: const Icon(Icons.light_mode, size: 24)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.person, size: 26)),
            ],
          ),
          HomeHeaderSection(isDarkMode),
        ],
      ),
    );
    // AppBar(
    //   title: const Text('Quiz Master'),
    //   actions: [
    //     IconButton(
    //         onPressed: () {
    //           ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
    //         },
    //         icon: const Icon(Icons.light_mode, size: 20)),
    //     widthSizedBox(10)
    //   ],
    // );
  }
}
