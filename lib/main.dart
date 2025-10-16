import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalcomplete/calculadora_screen.dart';
import 'package:finalcomplete/graficos_screen.dart';
import 'package:finalcomplete/basedatos_screen.dart';
import 'package:finalcomplete/webservices_screen.dart';
import 'package:finalcomplete/otros/otros_screen.dart';

void main() {
  runApp(const Principal());
}

class Principal extends StatelessWidget {
  const Principal({super.key});
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Principal',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/details1': (BuildContext context) => new CalculadoraScreen(),
        '/graficos': (BuildContext context) => new GraficosScreen(),
        '/basedatos': (BuildContext context) => new BaseDatosScreen(),
        '/webservices': (BuildContext context) => new WebServicesScreen(),
        '/otros': (BuildContext context) => new OtrosScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: const Text('TestProject'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: const Text('Calculadora de numeros complejos'),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/details1')),
                const SizedBox(height: 10),
                ElevatedButton(
                    child: const Text('Gráficos'),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/graficos')),
                const SizedBox(height: 10),
                ElevatedButton(
                    child: const Text('Base de Datos'),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/basedatos')),
                const SizedBox(height: 10),
                ElevatedButton(
                    child: const Text('Web Services'),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/webservices')),
                const SizedBox(height: 10),
                ElevatedButton(
                    child: const Text('Otros'),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/otros')),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Salir'),
                    onPressed: () {
                      // Salir de la aplicación
                      SystemNavigator.pop();
                    }),
              ],
            )));
  }
}

