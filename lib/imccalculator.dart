import 'package:imc_calculator/imcprovider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';

class IMCCalculator extends StatefulWidget {
  IMCCalculator({Key? key}) : super(key: key);

  @override
  State<IMCCalculator> createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  TextEditingController alturah = new TextEditingController();
  TextEditingController pesow = new TextEditingController();
  double valorimcactual = 0;
  double alturahd = 0;
  double pesowd = 0;
  String resultadoIMC = '';
  String nivelRiesgo = '';

  @override
  Widget build(BuildContext context) {
    final imcform = Provider.of<IMCProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Calculadora del IMC",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 30.h,
                width: 30.w,
                child: FadeInImage(
                    placeholder: AssetImage("assets/loading.gif"),
                    image: AssetImage("assets/imc-logo.png")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Instrucciones: Ingresa tu altura en metros y tu peso en kilogramos, para calcular tu Índice de Masa Corporal, recuerda añadir . y decimal (En caso de no tener, añadir .0)",
                  textAlign: TextAlign.center,
                  style: estiloinstrucciones(),
                ),
              ),
              Form(
                  key: imcform.formIMCKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: alturah,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Ingresa la altura',
                          labelText: 'Altura de la persona',
                        ),
                        onChanged: (value) {
                          setState(() {
                            imcform.altura = double.parse(value);
                            //  imcform.altura = value as double;
                            //print(dolaresapesos.toString());
                          });
                        },
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'La altura debe de ser 2  más caracteres';
                        },
                      ),
                      TextFormField(
                        controller: pesow,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Ingresa el peso',
                          labelText: 'Peso de la persona',
                        ),
                        onChanged: (value) {
                          setState(() {
                            imcform.peso = double.parse(value);
                            //  imcform.peso = value as double;
                            //print(dolaresapesos.toString());
                          });
                        },
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'El peso debe de ser 2  más caracteres';
                        },
                      ),
                      SizedBox(height: 4.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          if (!imcform.isValidForm()) return;

                          setState(() {
                            double alturaalcuadrado =
                                (imcform.altura) * (imcform.altura);
                            valorimcactual = (imcform.peso / alturaalcuadrado);

                            print(valorimcactual.toString());
                            if (valorimcactual < 18.5) {
                              resultadoIMC = "IMC muy bajo";
                              nivelRiesgo = 'Estas en riesgo';
                            }
                            if (valorimcactual > 18.5 &&
                                valorimcactual < 24.9) {
                              resultadoIMC = "IMC con clasificación de Normal";
                              nivelRiesgo = 'Tienes un riesgo Promedio';
                            }
                            if (valorimcactual > 25.0 &&
                                valorimcactual < 29.9) {
                              resultadoIMC =
                                  "IMC con clasificación de Sobrepeso";
                              nivelRiesgo = 'Tienes un riesgo Aumentado';
                            }
                            if (valorimcactual > 30.0 &&
                                valorimcactual < 34.9) {
                              resultadoIMC =
                                  "IMC con clasificación de Obesidad Grado I";
                              nivelRiesgo = 'Tienes un riesgo Moderado';
                            }
                            if (valorimcactual > 35.0 &&
                                valorimcactual < 39.9) {
                              resultadoIMC =
                                  "IMC con clasificación de Obesidad Grado II";
                              nivelRiesgo = 'Tienes un riesgo Severo';
                            }
                            if (valorimcactual > 40.0) {
                              resultadoIMC =
                                  "IMC con clasificación de Obesidad Grado III";
                              nivelRiesgo = 'Tienes un riesgo Muy Severo';
                            }
                          });
                        },
                        child: Text('Calcular IMC'),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        resultadoIMC +
                            ' = ' +
                            valorimcactual.toStringAsFixed(3),
                        style: estiloresultado(),
                      ),
                      Text(
                        nivelRiesgo,
                        style: estiloriesgo(),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  TextStyle estiloinstrucciones() => TextStyle(
        fontSize: 12,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      );

  TextStyle estiloresultado() => TextStyle(
        fontSize: 16,
        color: Colors.lightBlueAccent,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      );

  TextStyle estiloriesgo() => TextStyle(
        fontSize: 14,
        color: Colors.redAccent,
        fontStyle: FontStyle.italic,
      );
}
