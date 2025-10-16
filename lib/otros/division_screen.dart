import 'package:flutter/material.dart';
import 'package:finalcomplete/otros/otros_division.dart';

class DivisionScreen extends StatefulWidget {
  @override
  _DivisionScreenState createState() => _DivisionScreenState();
}

class _DivisionScreenState extends State<DivisionScreen> {
  final TextEditingController _dividendoController = TextEditingController();
  final TextEditingController _divisorController = TextEditingController();
  String _resultado = '';
  List<String> _pasos = [];

  @override
  void dispose() {
    _dividendoController.dispose();
    _divisorController.dispose();
    super.dispose();
  }

  void _calcularDivision() {
    String dividendoStr = _dividendoController.text;
    String divisorStr = _divisorController.text;

    if (!DivisionOperaciones.validarEntrada(dividendoStr) || 
        !DivisionOperaciones.validarEntrada(divisorStr)) {
      setState(() {
        _resultado = 'Por favor ingrese ambos números válidos';
        _pasos = [];
      });
      return;
    }

    if (!DivisionOperaciones.validarDivisor(divisorStr)) {
      setState(() {
        _resultado = 'Error: No se puede dividir por cero';
        _pasos = [];
      });
      return;
    }

    try {
      int dividendo = DivisionOperaciones.convertirAEntero(dividendoStr);
      int divisor = DivisionOperaciones.convertirAEntero(divisorStr);

      int cociente = DivisionOperaciones.calcularCociente(dividendo, divisor);
      int residuo = DivisionOperaciones.calcularResiduo(dividendo, divisor);
      List<String> pasos = DivisionOperaciones.divisionTradicionalDetallada(dividendo, divisor);

      setState(() {
        _resultado = 'Cociente: $cociente | Residuo: $residuo';
        _pasos = pasos;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Error: ${e.toString()}';
        _pasos = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('División Tradicional'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Método de División Tradicional',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dividendoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Dividendo',
                border: OutlineInputBorder(),
                hintText: 'Ingrese el dividendo',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _divisorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Divisor',
                border: OutlineInputBorder(),
                hintText: 'Ingrese el divisor',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularDivision,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Calcular División',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_resultado.isNotEmpty)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (_pasos.isNotEmpty)
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Proceso de División',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.green.shade200, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _pasos.map((paso) => Text(
                            paso,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Courier New',
                              fontWeight: FontWeight.w500,
                            ),
                          )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
