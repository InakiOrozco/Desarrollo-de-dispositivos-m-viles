import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_track/user_page/bloc/account_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:feature_discovery/feature_discovery.dart';

import 'bloc/picture_bloc.dart';
import 'bloc/account_bloc.dart';
import 'circular_button.dart';
import 'cuenta_item.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final screenShotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenShotController,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            DescribedFeatureOverlay(
              featureId: 'Share', // Unique id that identifies this overlay.
              tapTarget: const Icon(Icons
                  .share), // The widget that will be displayed as the tap target.
              title: Text('Store and Share'),
              description: Text('Store and share your screen.'),
              backgroundColor: Theme.of(context).primaryColor,
              targetColor: Colors.white,
              textColor: Colors.white,
              child: IconButton(
                tooltip: "Compartir pantalla",
                onPressed: () async {
                  double pixelRatio = MediaQuery.of(context).devicePixelRatio;
                  _storeAndShare((await screenShotController.capture(
                      pixelRatio: pixelRatio))!);
                },
                icon: Icon(Icons.share),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BlocConsumer<PictureBloc, PictureState>(
                  listener: (context, state) {
                    if (state is PictureErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${state.errorMsg}")),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PictureSelectedState) {
                      return CircleAvatar(
                        backgroundImage: FileImage(state.picture!),
                        minRadius: 40,
                        maxRadius: 80,
                      );
                    } else {
                      return CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 122, 113, 113),
                        minRadius: 40,
                        maxRadius: 80,
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                Text(
                  "Bienvenido",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text("Usuario${UniqueKey()}"),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DescribedFeatureOverlay(
                      featureId:
                          'Tarjeta', // Unique id that identifies this overlay.
                      tapTarget: const Icon(Icons
                          .credit_card), // The widget that will be displayed as the tap target.
                      title: Text('Ver tarjeta'),
                      description: Text('Tus tarjetas.'),
                      backgroundColor: Theme.of(context).primaryColor,
                      targetColor: Color(0xff123b5e),
                      textColor: Colors.white,
                      child: CircularButton(
                        textAction: "Ver tarjeta",
                        iconData: Icons.credit_card,
                        bgColor: Color(0xff123b5e),
                        action: null,
                      ),
                    ),
                    DescribedFeatureOverlay(
                      featureId:
                          'Foto', // Unique id that identifies this overlay.
                      tapTarget: const Icon(Icons
                          .camera_alt), // The widget that will be displayed as the tap target.
                      title: Text('Cambiar foto'),
                      description: Text('Cambiar tu foto de perfil.'),
                      backgroundColor: Theme.of(context).primaryColor,
                      targetColor: Colors.orange,
                      textColor: Colors.white,
                      child: CircularButton(
                        textAction: "Cambiar foto",
                        iconData: Icons.camera_alt,
                        bgColor: Colors.orange,
                        action: () {
                          BlocProvider.of<PictureBloc>(context).add(
                            ChangeImageEvent(),
                          );
                        },
                      ),
                    ),
                    DescribedFeatureOverlay(
                      featureId:
                          'Tutorial', // Unique id that identifies this overlay.
                      tapTarget: const Icon(Icons
                          .play_arrow), // The widget that will be displayed as the tap target.
                      title: Text('Ver de nuevo este tutorial'),
                      description: Text(
                          'Reproduce un tutorial de como usar la aplicación.'),
                      backgroundColor: Theme.of(context).primaryColor,
                      targetColor: Colors.green,
                      textColor: Colors.white,
                      child: CircularButton(
                        textAction: "Ver tutorial",
                        iconData: Icons.play_arrow,
                        bgColor: Colors.green,
                        action: () {
                          FeatureDiscovery.clearPreferences(context,
                              <String>{'Share', 'Tarjeta', 'Foto', 'Tutorial'});
                          FeatureDiscovery.discoverFeatures(
                            context,
                            const <String>{
                              // Feature ids for every feature that you want to showcase in order.
                              'Share',
                              'Tarjeta',
                              'Foto',
                              'Tutorial'
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48),
                BlocConsumer<AccountBloc, AccountState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is AccountSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.successMsg["hoja1"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return CuentaItem(
                            state.successMsg["hoja1"][index]["cuenta"]
                                .toString(),
                            state.successMsg["hoja1"][index]["tarjeta"]
                                .toString(),
                            state.successMsg["hoja1"][index]["dinero"]
                                .toString(),
                          );
                        },
                      );
                    } else if (state is AccountError) {
                      return Text("No hay datos disponibles");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _storeAndShare(Uint8List bytes) async {
    ///Store Plugin
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/img.png').create();
    await imagePath.writeAsBytes(bytes);

    /// Share Plugin
    await Share.shareFiles([imagePath.path]);
  }
}
