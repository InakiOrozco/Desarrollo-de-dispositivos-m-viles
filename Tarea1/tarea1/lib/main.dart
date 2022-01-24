import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 1',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Tarea 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color correo = Colors.grey;
  Color llamada = Colors.grey;
  Color ruta = Colors.grey;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset("lib/assets/images/descarga.jpg"),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "El ITESO, Universidad Jesuita de Guadalajara",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "San Pedro Tlaquepaque, Jal.",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: _decrementCounter, icon: Icon(Icons.thumb_down)),
                IconButton(
                    onPressed: _incrementCounter, icon: Icon(Icons.thumb_up)),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(children: [
                IconButton(
                    iconSize: 50,
                    color: correo,
                    onPressed: () {
                      setState(() {
                        if (correo == Colors.grey) {
                          correo = Colors.blueAccent;
                        } else {
                          correo = Colors.grey;
                        }
                      });
                      const snackBar = SnackBar(
                        content: Text('Correo'),
                        duration: Duration(milliseconds: 400),
                      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(Icons.mail)),
                Text("Correo"),
              ]),
              Column(children: [
                IconButton(
                    iconSize: 50,
                    color: llamada,
                    onPressed: () {
                      setState(() {
                        if (llamada == Colors.grey) {
                          llamada = Colors.blueAccent;
                        } else {
                          llamada = Colors.grey;
                        }
                      });
                      const snackBar = SnackBar(
                        content: Text('Llamada'),
                        duration: Duration(milliseconds: 400),
                      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(Icons.phone)),
                Text("Llamada"),
              ]),
              Column(children: [
                IconButton(
                    iconSize: 50,
                    color: ruta,
                    onPressed: () {
                      setState(() {
                        if (ruta == Colors.grey) {
                          ruta = Colors.blueAccent;
                        } else {
                          ruta = Colors.grey;
                        }
                      });
                      const snackBar = SnackBar(
                        content: Text('Ruta'),
                        duration: Duration(milliseconds: 400),
                      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(Icons.map)),
                Text("Ruta"),
              ]),
            ]),
            const Text(
              'El ITESO, Universidad Jesuita de Guadalajara, es una universidad privada ubicada en la Zona Metropolitana de Guadalajara, Jalisco, México, fundada en el año 1957. La institución forma parte del Sistema Universitario Jesuita que integra a ocho universidades en México. Fundada en el año de 1957 por el ingeniero José Fernández del Valle y Ancira, entre otros, la universidad ha tenido una larga trayectoria. A continuación se presenta la historia de la institución en periodos de décadas.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
