import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculadoraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Center(
        child: Text('Bienvenido a la Calculadora'),
      ),
    );
  }
}

