import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageGet>(cargarImage);
  }
  final String urlImage = "https://picsum.photos/v2/list";

  void cargarImage(ImageEvent evento, Emitter emit) async {
    var image = await _getData();
    if (image == null) {
      emit(ImageError(error: "Se murió :("));
    } else {
      emit(ImageReady(image: image[Random().nextInt(30)]["download_url"]));
    }
  }

  Future _getData() async {
    try {
      Response res = await get(Uri.parse(urlImage));
      if (res.statusCode == HttpStatus.ok) {
        print(res.body);
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
