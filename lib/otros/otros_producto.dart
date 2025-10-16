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

      String acarreoLinea = _calcularAcarreos(num1, digito, i);
      if (acarreoLinea.isNotEmpty) {
        pasos.add(acarreoLinea);
      }

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

    String acarreosSuma = _calcularAcarreosSuma(productosPariciales);
    if (acarreosSuma.isNotEmpty) {
      pasos.add(acarreosSuma);
    }

    int total = productosPariciales.reduce((a, b) => a + b);
    pasos.add('        $total');

    return pasos;
  }

  static String _calcularAcarreos(int num1, int digito, int posicion) {
    String strNum1 = num1.toString();
    List<int> digitosNum1 = strNum1.split('').map((e) => int.parse(e)).toList().reversed.toList();
    
    List<String> acarreos = [];
    int acarreo = 0;
    
    for (int i = 0; i < digitosNum1.length; i++) {
      int producto = digitosNum1[i] * digito + acarreo;
      acarreo = producto ~/ 10;
      
      if (acarreo > 0) {
        acarreos.insert(0, acarreo.toString());
      } else {
        acarreos.insert(0, ' ');
      }
    }
    
    if (acarreos.isEmpty || acarreos.every((a) => a == ' ')) {
      return '';
    }
    
    String acarreoStr = acarreos.join(' ');
    String cerosExtras = '  ' * posicion;
    return '       $acarreoStr$cerosExtras';
  }

  static String _calcularAcarreosSuma(List<int> numeros) {
    if (numeros.length < 2) return '';
    
    int maxLongitud = numeros.map((n) => n.toString().length).reduce((a, b) => a > b ? a : b);
    
    List<String> acarreos = [];
    int acarreo = 0;
    
    for (int pos = 0; pos < maxLongitud; pos++) {
      int suma = acarreo;
      for (int num in numeros) {
        String strNum = num.toString().padLeft(maxLongitud, '0');
        int digito = int.parse(strNum[maxLongitud - 1 - pos]);
        suma += digito;
      }
      acarreo = suma ~/ 10;
      
      if (acarreo > 0) {
        acarreos.insert(0, acarreo.toString());
      } else {
        acarreos.insert(0, ' ');
      }
    }
    
    if (acarreos.isEmpty || acarreos.every((a) => a == ' ')) {
      return '';
    }
    
    String acarreoStr = acarreos.join(' ');
    return '       $acarreoStr';
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
