import 'package:tarea3/donativos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentSelectedRadio;
  String dropdownValue = "0";
  int total = 0;
  int paypal = 0;
  int tarjeta = 0;

  var radioGroup = {
    0: 'PayPal',
    1: 'Tarjeta',
  };

  var assetRadioGroup = {
    0: 'assets/paypal.png',
    1: 'assets/creditcard.png',
  };

  dropDownItemsGenerator() {
    return <String>["0", "100", "350", "500", "850", "1100"]
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Donaciones'),
        ),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Es para una buena causa',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              Text(
                'Elija modo de donativo',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      children: radioGroup.entries
                          .map(
                            (radioItem) => ListTile(
                              leading: Image.asset(
                                assetRadioGroup[radioItem.key]!,
                                height: 64,
                                width: 44,
                              ),
                              title: Text(radioItem.value),
                              trailing: Radio(
                                value: radioItem.key,
                                groupValue: currentSelectedRadio,
                                onChanged: (int? newSelectedRadio) {
                                  currentSelectedRadio = newSelectedRadio!;
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                          .toList()),
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              ListTile(
                  title: Text("Cantidad a donar:"),
                  trailing: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: dropDownItemsGenerator())),
              LinearProgressIndicator(
                value: (paypal + tarjeta) / 10000,
                minHeight: 20,
                backgroundColor: Colors.white10,
              ),
              Align(
                child: (paypal + tarjeta < 10000)
                    ? Text(
                        ((paypal + tarjeta) / 100).toString() + "%",
                        style: TextStyle(fontSize: 18),
                      )
                    : Text(
                        '100%',
                        style: TextStyle(fontSize: 18),
                      ),
                alignment: Alignment.center,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      currentSelectedRadio == 0
                          ? paypal += int.parse(dropdownValue)
                          : tarjeta += int.parse(dropdownValue);

                      setState(() {});
                    },
                    child: Text(
                      "DONAR",
                      style: TextStyle(fontSize: 16),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          tooltip: "Ver donativos",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    Donativos(paypal: paypal, tarjeta: tarjeta),
              ),
            );
          },
        ));
  }
}
