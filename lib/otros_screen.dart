import 'package:flutter/material.dart';
import 'package:finalcomplete/producto_screen.dart';

class OtrosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Otras weas'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Producto'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
