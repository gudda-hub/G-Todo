import 'dart:developer';

import '../export.dart';

class LoadingErrorScreen extends StatelessWidget {
  final String title;
  final bool error;
  const LoadingErrorScreen({super.key, this.title = '', this.error = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(title)),
        body: error
            ? const Center(child: Text('Something went Wrong!'))
            : const Center(child: LoadingIndicator()));
  }
}

class LoadingDataScreen extends ConsumerWidget {
  final Widget Function(dynamic data) data;
  final AsyncValue<dynamic>? varBuild;
  const LoadingDataScreen({super.key, required this.data, this.varBuild});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return varBuild!.when(
        error: (error, stackTrace) {
          return const Center(child: Text("Error"));
        },
        loading: () => Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const LoadingIndicator(),
                  heightSizedBox(10.0),
                  Text("Loading...",
                      style: Theme.of(context).textTheme.labelMedium)
                ])),
        data: (snap) {
          log("Snap :$snap");
          if (snap != null) {
            if (snap.isEmpty) {
              return Center(
                  child: Text(Msg.noTasksAvailable,
                      style: Theme.of(context).textTheme.titleMedium));
            } else {
              return data(snap);
            }
          } else {
            return Center(
                child: Text("Oops! Something went wrong.",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color.fromARGB(255, 233, 16, 0))));
          }
        });
  }
}

//! loading class =====?
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: _controller,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const SweepGradient(colors: [
                  Colors.amber,
                  Colors.red,
                  Colors.green,
                  Colors.indigo,
                  Colors.black,
                  Colors.pink,
                  Colors.purple,
                  Colors.amber,
                ])),
            width: 50,
            height: 50,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 10,
                  width: 10,
                  color: Colors.white,
                ))));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LoadingBtn {
  final dynamic ref;
  LoadingBtn(this.ref);
  void disableButton() {
    try {
      ref.read(btnEnableProvider.notifier).state = true;
    } catch (e) {
      log("Loading btn disable :$e");
    }
  }

  void enableButton() {
    Future.delayed(const Duration(seconds: 1), () {
      ref.read(btnEnableProvider.notifier).state = false;
    });
  }
}
