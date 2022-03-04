import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'frase_event.dart';
part 'frase_state.dart';

class FraseBloc extends Bloc<FraseEvent, FraseState> {
  FraseBloc() : super(FraseInitial()) {
    on<FraseGet>(cargarFrase);
  }
  final String urlFrase = "https://zenquotes.io/api/random";

  void cargarFrase(FraseEvent evento, Emitter emit) async {
    var frase = await _getData();
    if (frase == null) {
      emit(FraseError(error: "Se murió :("));
    } else {
      emit(FraseReady(frase: frase[0]['q'], autor: frase[0]['a']));
    }
  }

  Future _getData() async {
    try {
      Response res = await get(Uri.parse(urlFrase));
      if (res.statusCode == HttpStatus.ok) {
        print(res.body);
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
