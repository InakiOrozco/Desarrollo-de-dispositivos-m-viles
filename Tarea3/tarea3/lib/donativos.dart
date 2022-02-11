import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  dynamic tarjeta = 0;
  dynamic paypal = 0;

  Donativos({Key? key, required this.tarjeta, required this.paypal})
      : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donativos obtenidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/paypal.png"),
              trailing: Text(
                "${widget.paypal}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset("assets/creditcard.png"),
              trailing: Text(
                "${widget.tarjeta}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money, size: 64),
              trailing: Text(
                "${widget.tarjeta + widget.paypal}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            Container(
              child: (widget.tarjeta + widget.paypal >= 10000)
                  ? Image.asset("assets/gracias.png")
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
