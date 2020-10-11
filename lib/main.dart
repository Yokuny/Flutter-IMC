import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //espera como parametro um widget
    home: Home(),
  ));
}

//inicia aqui o widgte de statuFull
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  //recebe valores de dentro dos input
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Fill your data!";
  void _resetFields() {
    //limpa os campos
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Fill your data!";
      _formKey = GlobalKey<FormState>();
    });
  } //fim do stateFull widget

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      //pega o valor dos input recebido e transforma em valor numerico
      double height = double.parse(heightController.text);
      double imc = weight / (height * height);
      if (imc < 17) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are thinness";
        // toStringAsPrecision(4) define os numeros depois da virgula
      } else if (imc >= 17 && imc < 18.4) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are under weight";
      } else if (imc >= 18.5 && imc < 24.9) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are normal weight";
      } else if (imc >= 25 && imc < 29.9) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are overweight";
      } else if (imc >= 30 && imc < 34.9) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are grade 1 obese";
      } else if (imc >= 35 && imc < 39.9) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are grade 2 obese";
      } else if (imc > 40) {
        _infoText =
            "Your BMI is ${imc.toStringAsPrecision(4)} and you are grade 3 obese";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scafoold é um wigete que adiciona barras com opções nos aplicativos
      appBar: AppBar(
        title: Text("BMI calculator"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          //um widget de ação na status bar
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields, //função que reseta os campos de dados
          )
        ],
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        //habilita rolar pagina tornando-a continua
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        //margens para a pagina
        child: Form(
          key: _formKey, //variavel criada p verificar inputs foram preenchido
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.black),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Weight(kg)",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 25.0),
                controller: weightController,
                //passa os valores recebidos dentro do iput
                validator: (value) {
                  //TextFormField aceita um parametro de validator para verificação
                  if (value.isEmpty) {
                    return "insert your weight!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Height(m)",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insert your height!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //se os campos foram preenchidos chame a função
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
