import 'package:flutter/material.dart';

class CuentaItem extends StatelessWidget {
  String tipoCuenta = "Cuenta";
  String terminacion = "0000";
  String saldoDisponible = "0.0";

  CuentaItem(String tc, String t, String sd) {
    this.tipoCuenta = tc;
    this.terminacion = t;
    this.saldoDisponible = sd;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "$tipoCuenta",
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text("~$terminacion"),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "\$$saldoDisponible",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Saldo disponible",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
