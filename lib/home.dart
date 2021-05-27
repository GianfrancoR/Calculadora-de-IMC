import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informar Datos";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informar Datos";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height*height);
      print(imc);
      if (imc < 18.6){
        _infoText = "Abajo del peso (IMC ""${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (IMC ""${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente por encima del Peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidad Grado I (IMC ""${imc.toStringAsPrecision(3)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidad Grado II (IMC ""${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40){
        _infoText = "Obesidad Grado III (IMC ""${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text ("Calculadora de Indice de Masa Corporal"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person, size: 120.0, color: Colors.black),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.black)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: weightController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese su peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm) sin comas o puntos",
                        labelStyle: TextStyle(color: Colors.black)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: heightController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese su altura sin comas o puntos!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),)
                ],
              ),
            )
        )
    );
  }
}