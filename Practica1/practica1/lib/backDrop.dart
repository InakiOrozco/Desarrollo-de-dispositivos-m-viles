import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/bloc/frase_bloc.dart';
import 'package:practica1/bloc/image_bloc.dart';
import 'package:practica1/bloc/time_bloc.dart';

class Country extends StatelessWidget {
  Image flag = Image.network(
    "https://flagcdn.com/16x12/mx.png",
  );
  String countryName = "México";

  Country(Image flag, String cn) {
    this.flag = flag;
    this.countryName = cn;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<TimeBloc>(context).pais = countryName;
        BlocProvider.of<TimeBloc>(context).add(TimeGet());
        BlocProvider.of<ImageBloc>(context).add(ImageGet());
        BlocProvider.of<FraseBloc>(context).add(FraseGet());
      },
      child: Container(
          height: 40,
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: flag,
            ),
            Text(countryName, style: TextStyle(color: Colors.white))
          ])),
    );
  }
}

class backDrop extends StatefulWidget {
  backDrop({Key? key}) : super(key: key);

  @override
  State<backDrop> createState() => _backDropState();
}

class _backDropState extends State<backDrop> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        stickyFrontLayer: false,
        headerHeight: 500,
        appBar: BackdropAppBar(
          title: const Text("La frase diaria"),
          actions: const <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: Center(
          heightFactor: 1,
          child: Container(
              height: 250,
              child: ListView(scrollDirection: Axis.vertical, children: [
                Country(Image.network("https://flagcdn.com/16x12/ad.png"),
                    "Andorra"),
                Country(Image.network("https://flagcdn.com/16x12/mx.png"),
                    "Mexico"),
                Country(
                    Image.network("https://flagcdn.com/16x12/pe.png"), "Peru"),
                Country(Image.network("https://flagcdn.com/16x12/ar.png"),
                    "Argentina"),
                Country(Image.network("https://flagcdn.com/16x12/ca.png"),
                    "Canada"),
              ])),
        ),
        frontLayer: Container(child: frontLayer()));
  }
}

Stack frontLayer() {
  return (Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
          child: BlocConsumer<ImageBloc, ImageState>(
              builder: ((context, state) {
                if (state is ImageError) {
                  return Text("Image error");
                } else if (state is ImageReady) {
                  return Image.network(state.image,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill);
                } else {
                  return CircularProgressIndicator();
                }
              }),
              listener: ((context, state) {}))),
      Container(
        height: 1000,
        width: 550,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.center,
            colors: [
              const Color(0xCC000000),
              const Color(0x00000000),
              const Color(0x00000000),
              const Color(0xCC000000),
            ],
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 60),
              child: BlocConsumer<TimeBloc, TimeState>(
                  builder: ((context, state) {
                    if (state is TimeError) {
                      return Text("Time error");
                    } else if (state is TimeReady) {
                      return Text(
                        "${state.time.substring(11, 19)}",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
                  listener: ((context, state) {})))
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<FraseBloc, FraseState>(
              builder: ((context, state) {
                if (state is FraseError) {
                  return Text("Se marnat :(");
                } else if (state is FraseReady) {
                  return Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(children: [
                        Text(
                          "${state.frase}",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "-${state.autor}",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ]));
                } else {
                  return CircularProgressIndicator();
                }
              }),
              listener: ((context, state) {}))
        ],
      )
    ],
  ));
}
