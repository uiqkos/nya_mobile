import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const NyaNeuralApp());
}

class NyaNeuralApp extends StatelessWidget {
  const NyaNeuralApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Nyaural networks",
      theme: ThemeData(

      ),
      home: _CounterPage(),
    );
  }
}

class _CounterPage extends StatefulWidget {

  @override
  State createState() => _CounterPageState();
}

class _CounterPageState extends State<_CounterPage> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(child: const Text("Увеличить"), onPressed: () => {
                setState(() {
                  _counter++;
                })
              }),
              Text("$_counter"),
            ],
          ),
        ),
      ),
    );
  }
}
