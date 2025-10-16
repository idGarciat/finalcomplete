class DivisionOperaciones {
  static int calcularCociente(int dividendo, int divisor) {
    if (divisor == 0) {
      throw Exception('No se puede dividir por cero');
    }
    return dividendo ~/ divisor;
  }

  static int calcularResiduo(int dividendo, int divisor) {
    if (divisor == 0) {
      throw Exception('No se puede dividir por cero');
    }
    return dividendo % divisor;
  }

  static List<String> divisionTradicional(int dividendo, int divisor) {
    if (divisor == 0) {
      return ['ERROR: No se puede dividir por cero'];
    }

    List<String> pasos = [];
    String cociente = '';
    int residuoActual = 0;
    String strDividendo = dividendo.toString();
    int posicion = 0;

    pasos.add('$dividendo ┃ $divisor');
    pasos.add('${_repetir('─', strDividendo.length)}┃${_repetir('─', divisor.toString().length + 2)}');

    while (posicion < strDividendo.length) {
      residuoActual = residuoActual * 10 + int.parse(strDividendo[posicion]);
      
      if (residuoActual < divisor) {
        if (cociente.isNotEmpty) {
          cociente += '0';
        }
        posicion++;
        if (posicion < strDividendo.length) {
          pasos.add('  $residuoActual bajamos ${strDividendo[posicion]}');
        }
        continue;
      }

      int vecesCabe = residuoActual ~/ divisor;
      int producto = vecesCabe * divisor;
      int nuevoResiduo = residuoActual - producto;

      cociente += vecesCabe.toString();

      pasos.add('  $residuoActual │ $vecesCabe × $divisor = $producto');
      pasos.add(' -${_espacios(residuoActual.toString().length - producto.toString().length)}$producto');
      pasos.add('  ${_repetir('─', residuoActual.toString().length)}');
      
      residuoActual = nuevoResiduo;
      
      if (residuoActual > 0 && posicion < strDividendo.length - 1) {
        posicion++;
        int siguienteDigito = int.parse(strDividendo[posicion]);
        pasos.add('  $residuoActual ↓ bajamos $siguienteDigito');
        residuoActual = residuoActual * 10 + siguienteDigito;
      }
      
      posicion++;
    }

    pasos.add('${_repetir(' ', strDividendo.length)}┃ $cociente');
    pasos.add('');
    pasos.add('Residuo: $residuoActual');

    return pasos;
  }

  static List<String> divisionTradicionalDetallada(int dividendo, int divisor) {
    if (divisor == 0) {
      return ['ERROR: No se puede dividir por cero'];
    }

    List<String> pasos = [];
    String strDividendo = dividendo.toString();
    int cocienteNum = dividendo ~/ divisor;
    String cociente = cocienteNum.toString();

    pasos.add('$strDividendo|$divisor');
    pasos.add('${_repetir('-', strDividendo.length)}|${_repetir('-', cociente.length)}');

    int idx = 0;
    int lenDividendo = strDividendo.length;
    int posCociente = 0;

    String bloque = '';
    while (idx < lenDividendo && int.parse((bloque + strDividendo[idx])) < divisor) {
      bloque += strDividendo[idx];
      idx++;
    }
    if (idx < lenDividendo) {
      bloque += strDividendo[idx];
      idx++;
    }

    int actual = int.parse(bloque);
    int prod = (actual ~/ divisor) * divisor;
    int resto = actual - prod;
    String linea1 = _espacios(lenDividendo - bloque.length) + actual.toString() + '|' + cociente[posCociente];
    pasos.add(linea1);
    posCociente++;

    String linea2 = _espacios(lenDividendo - bloque.length) + prod.toString() + '|';
    pasos.add(linea2);

    pasos.add(_espacios(lenDividendo - bloque.length) + _repetir('-', bloque.length) + '|');

    while (idx < lenDividendo) {
      resto = resto * 10 + int.parse(strDividendo[idx]);
      idx++;
      while (resto < divisor && idx < lenDividendo) {
        String linea = _espacios(lenDividendo - (bloque.length + (idx - bloque.length))) + resto.toString() + '|';
        pasos.add(linea);
        resto = resto * 10 + int.parse(strDividendo[idx]);
        idx++;
        posCociente++;
      }
      if (resto < divisor) break;
      int prod2 = (resto ~/ divisor) * divisor;
      String lineaA = _espacios(lenDividendo - (bloque.length + (idx - bloque.length))) + resto.toString() + '|' + (posCociente < cociente.length ? cociente[posCociente] : '');
      pasos.add(lineaA);
      String lineaB = _espacios(lenDividendo - (bloque.length + (idx - bloque.length))) + prod2.toString() + '|';
      pasos.add(lineaB);
      pasos.add(_espacios(lenDividendo - (bloque.length + (idx - bloque.length))) + _repetir('-', prod2.toString().length) + '|');
      resto = resto - prod2;
      posCociente++;
    }
    if (resto > 0) {
      String lineaFinal = _espacios(lenDividendo - resto.toString().length) + resto.toString() + '|';
      pasos.add(lineaFinal);
    }
    return pasos;
  }

  static String _repetir(String char, int veces) {
    return char * veces;
  }

  static String _espacios(int cantidad) {
    return ' ' * cantidad;
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

  static bool validarDivisor(String texto) {
    if (!validarEntrada(texto)) {
      return false;
    }
    
    int valor = int.parse(texto.trim());
    return valor != 0;
  }

  static int convertirAEntero(String texto) {
    return int.parse(texto.trim());
  }
}
