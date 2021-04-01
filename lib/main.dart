import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";

    _formKey.currentState.reset();

    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double heigth = double.parse(heigthController.text) / 100;
      double weigth = double.parse(weigthController.text);

      double imc = weigth / (heigth * heigth);
      String imcWithPrecision = imc.toStringAsPrecision(4);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso ($imcWithPrecision)";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal ($imcWithPrecision)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso ($imcWithPrecision)";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I ($imcWithPrecision)";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II ($imcWithPrecision)";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III ($imcWithPrecision)";
      }
    });
  }

  Function _required({ String message }) {
    return (value) => value.isEmpty ? (message ?? "Este campo é obrigatório!") : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 140.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso (kg)", labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weigthController,
                validator: _required(),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Altura (cm)", labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heigthController,
                validator: _required(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25)),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ),
              Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25),)
            ],
          ),
        ),
      )
    );
  }
}
