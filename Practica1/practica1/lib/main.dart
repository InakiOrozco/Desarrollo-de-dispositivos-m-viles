import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:practica1/backDrop.dart';
import 'package:practica1/bloc/time_bloc.dart';

import 'bloc/frase_bloc.dart';
import 'bloc/image_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      title: 'Material App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FraseBloc()..add(FraseGet())),
          BlocProvider(create: (context) => ImageBloc()..add(ImageGet())),
          BlocProvider(create: (context) => TimeBloc()..add(TimeGet())),
        ],
        child: backDrop(),
      ),
    );
  }
}
