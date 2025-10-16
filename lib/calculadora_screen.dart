import 'package:flutter/material.dart';
import 'calculadora_op.dart';

class CalculadoraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Suma', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OperacionScreen(
                      operacion: 'suma',
                      titulo: 'Suma',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Resta', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OperacionScreen(
                      operacion: 'resta',
                      titulo: 'Resta',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Multiplicación', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OperacionScreen(
                      operacion: 'multiplicacion',
                      titulo: 'Multiplicación',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('División', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OperacionScreen(
                      operacion: 'division',
                      titulo: 'División',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OperacionScreen extends StatefulWidget {
  final String operacion;
  final String titulo;

  const OperacionScreen({
    Key? key,
    required this.operacion,
    required this.titulo,
  }) : super(key: key);

  @override
  _OperacionScreenState createState() => _OperacionScreenState();
}

class _OperacionScreenState extends State<OperacionScreen> {
  final TextEditingController _real1Controller = TextEditingController();
  final TextEditingController _imag1Controller = TextEditingController();
  final TextEditingController _real2Controller = TextEditingController();
  final TextEditingController _imag2Controller = TextEditingController();
  
  String _resultado = '';

  void _calcular() {
    try {
      double real1 = double.parse(_real1Controller.text);
      double imag1 = double.parse(_imag1Controller.text);
      double real2 = double.parse(_real2Controller.text);
      double imag2 = double.parse(_imag2Controller.text);

      NumeroComplejo z1 = NumeroComplejo(real1, imag1);
      NumeroComplejo z2 = NumeroComplejo(real2, imag2);
      NumeroComplejo resultado;

      switch (widget.operacion) {
        case 'suma':
          resultado = CalculadoraComplejos.suma(z1, z2);
          break;
        case 'resta':
          resultado = CalculadoraComplejos.resta(z1, z2);
          break;
        case 'multiplicacion':
          resultado = CalculadoraComplejos.multiplicacion(z1, z2);
          break;
        case 'division':
          resultado = CalculadoraComplejos.division(z1, z2);
          break;
        default:
          resultado = NumeroComplejo(0, 0);
      }

      setState(() {
        _resultado = 'Resultado: ${resultado.toString()}';
      });
    } catch (e) {
      setState(() {
        _resultado = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Primer número complejo (a + bi)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _real1Controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                    decoration: InputDecoration(
                      labelText: 'Parte real (a)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _imag1Controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                    decoration: InputDecoration(
                      labelText: 'Parte imaginaria (b)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Segundo número complejo (c + di)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _real2Controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                    decoration: InputDecoration(
                      labelText: 'Parte real (c)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _imag2Controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                    decoration: InputDecoration(
                      labelText: 'Parte imaginaria (d)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: _calcular,
              child: Text('Calcular', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 30),
            if (_resultado.isNotEmpty)
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _real1Controller.dispose();
    _imag1Controller.dispose();
    _real2Controller.dispose();
    _imag2Controller.dispose();
    super.dispose();
  }
}


