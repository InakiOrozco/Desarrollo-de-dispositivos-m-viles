import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'dart:convert';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountEvent>(_request);
  }
  final String url =
      "https://api.sheety.co/f386175add37b57b868d5f8c1f25d7e2/hojaDeC%C3%A1lculoSinT%C3%ADtulo/hoja1";

  void _request(AccountEvent event, Emitter emmiter) async {
    print("request");
    var MapInfo = await _getInfo();
    if (MapInfo == null) {
      emmiter(AccountError(errorMsg: "No hay datos"));
    } else {
      emmiter(AccountSuccess(successMsg: MapInfo));
    }
  }

  Future _getInfo() async {
    try {
      Response res = await get(Uri.parse(url));
      if (res.statusCode == HttpStatus.ok) {
        print('correct');
        return jsonDecode(res.body);
      }
    } catch (error) {
      print(error);
    }
  }
}
