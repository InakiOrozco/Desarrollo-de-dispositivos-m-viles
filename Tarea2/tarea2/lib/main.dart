import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Tarea 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fieldText = TextEditingController();
  final fieldText1 = TextEditingController();
  Color color = Colors.black87;
  Color color2 = Colors.black87;
  String genero = "todos.";
  String kg = " ";
  String altura = " ";
  double result = 0;

  void _cleartext() {
    fieldText.clear();
    fieldText1.clear();
    setState(() {
      color = Colors.black87;
      color2 = Colors.black87;
      genero = "todos.";
    });
  }

  void _showcontent() {
    result = double.parse(kg) / (double.parse(altura) * double.parse(altura));
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tu IMC:" + (result).toStringAsFixed(2)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Tabla del IMC para ' + genero),
                Text(''),
                Text('Edad  IMC ideal'),
                Text('16-17   19-24'),
                Text('18-18   19-24'),
                Text('19-24   19-24'),
                Text('25-34   20-25'),
                Text('35-44   21-26'),
                Text('45-54   22-27'),
                Text('55-64   23-28'),
                Text('65-90   25-30'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular IMC'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _cleartext, icon: Icon(Icons.delete_forever))
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Ingrese sus datos para calcular el IMC"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (color == Colors.black87) {
                          color = Colors.pink;
                          color2 = Colors.black87;
                          genero = "mujer.";
                        } else {
                          color = Colors.black87;
                        }
                      });
                    },
                    icon: const Icon(Icons.female),
                    color: color,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (color2 == Colors.black87) {
                            color2 = Colors.blue;
                            color = Colors.black87;
                            genero = "hombre.";
                          } else {
                            color2 = Colors.black87;
                          }
                        });
                      },
                      icon: const Icon(Icons.male),
                      color: color2)
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) => altura = value,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.square_foot,
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: "Ingresar altura (Metros)"),
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.number,
                  controller: fieldText,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value) => kg = value,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.monitor_weight),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: "Ingresar peso (KG)"),
                    keyboardType: TextInputType.number,
                    controller: fieldText1,
                  )),
              TextButton(
                onPressed: _showcontent,
                child: const Text(
                  "Calcular",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
