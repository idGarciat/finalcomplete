import 'package:flutter/material.dart';
import 'package:finalcomplete/otros_producto.dart';

class ProductoScreen extends StatefulWidget {
  @override
  _ProductoScreenState createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  final TextEditingController _numero1Controller = TextEditingController();
  final TextEditingController _numero2Controller = TextEditingController();
  String _resultado = '';
  List<String> _pasos = [];

  @override
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }

  void _calcularProducto() {
    String num1Str = _numero1Controller.text;
    String num2Str = _numero2Controller.text;

    if (!ProductoOperaciones.validarEntrada(num1Str) || 
        !ProductoOperaciones.validarEntrada(num2Str)) {
      setState(() {
        _resultado = 'Por favor ingrese ambos números válidos';
        _pasos = [];
      });
      return;
    }

    try {
      int num1 = ProductoOperaciones.convertirAEntero(num1Str);
      int num2 = ProductoOperaciones.convertirAEntero(num2Str);

      int resultado = ProductoOperaciones.calcularProducto(num1, num2);
      List<String> pasos = ProductoOperaciones.multiplicacionTradicional(num1, num2);

      setState(() {
        _resultado = 'Resultado: $resultado';
        _pasos = pasos;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Error: Ingrese números válidos';
        _pasos = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiplicación Tradicional'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Método de Multiplicación Tradicional',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _numero1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Multiplicando',
                border: OutlineInputBorder(),
                hintText: 'Ingrese el primer número',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _numero2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Multiplicador',
                border: OutlineInputBorder(),
                hintText: 'Ingrese el segundo número',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularProducto,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Calcular Producto',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_resultado.isNotEmpty)
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
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
                        'Proceso de Multiplicación',
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
                          border: Border.all(color: Colors.blue.shade200, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _pasos.map((paso) => Text(
                            paso,
                            style: TextStyle(
                              fontSize: 18,
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
