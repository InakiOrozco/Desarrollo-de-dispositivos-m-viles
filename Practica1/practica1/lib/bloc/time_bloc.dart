import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeInitial()) {
    on<TimeGet>(cargarTime);
  }
  String pais = "Andorra";
  String urlTime = "http://worldtimeapi.org/api/timezone/Europe/Andorra";

  void cargarTime(TimeEvent evento, Emitter emit) async {
    if (pais != "Andorra") {
      if (pais == "Mexico") {
        urlTime =
            "http://worldtimeapi.org/api/timezone/America/" + pais + "_City";
      } else if (pais == "Argentina") {
        urlTime = "http://worldtimeapi.org/api/timezone/America/" +
            pais +
            "/Buenos_Aires";
      } else if (pais == "Peru") {
        urlTime = "http://worldtimeapi.org/api/timezone/America/Lima";
      } else if (pais == "Canada") {
        urlTime = "http://worldtimeapi.org/api/timezoneAmerica/Toronto";
      }

      print(urlTime);
    }
    var time = await _getData();
    if (time == null) {
      emit(TimeError(error: "Se murió :("));
    } else {
      emit(TimeReady(time: time["datetime"]));
    }
  }

  Future _getData() async {
    try {
      Response res = await get(Uri.parse(urlTime));
      if (res.statusCode == HttpStatus.ok) {
        print(res.body);
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
