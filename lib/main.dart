import 'package:flutter/material.dart';
import 'package:imc_calculator/imccalculator.dart';
import 'package:imc_calculator/imcprovider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';



void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IMCProvider(),
        ),
 
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora del IMC',
        home: IMCCalculator(),
      );
    });
  }
}
