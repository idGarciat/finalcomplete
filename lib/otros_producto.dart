class ProductoOperaciones {
  static int calcularProducto(int num1, int num2) {
    return num1 * num2;
  }

  static List<String> multiplicacionTradicional(int num1, int num2) {
    List<String> pasos = [];
    
    String strB = num2.toString();

    pasos.add('        $num1');
    pasos.add('    X   $num2');
    pasos.add('  ════════════');
    pasos.add('');

    List<int> digitosB = strB
        .split('')
        .map((e) => int.parse(e))
        .toList()
        .reversed
        .toList();
    
    List<int> productosPariciales = [];

    for (int i = 0; i < digitosB.length; i++) {
      int digito = digitosB[i];
      int productoParcial = num1 * digito;

      String productoStr = productoParcial.toString();
      for (int j = 0; j < i; j++) {
        productoStr += '0';
      }

      int productoConPosicion = productoParcial * _getPotencia10(i);
      productosPariciales.add(productoConPosicion);

      if (i == digitosB.length - 1 && digitosB.length > 1) {
        pasos.add('    +   $productoStr');
      } else {
        pasos.add('        $productoStr');
      }
    }

    pasos.add('  ════════════');

    int total = productosPariciales.reduce((a, b) => a + b);
    pasos.add('        $total');

    return pasos;
  }

  static int _getPotencia10(int posicion) {
    int resultado = 1;
    for (int i = 0; i < posicion; i++) {
      resultado *= 10;
    }
    return resultado;
  }

  static bool validarEntrada(String texto) {
    if (texto.trim().isEmpty) {
      return false;
    }
    
    try {
      int.parse(texto.trim());
      return true;
    } catch (e) {
      return false;
    }
  }

  static int convertirAEntero(String texto) {
    return int.parse(texto.trim());
  }
}
