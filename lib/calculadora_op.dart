import 'dart:math';

class NumeroComplejo {
  final double real;
  final double imaginario;

  NumeroComplejo(this.real, this.imaginario);

  @override
  String toString() {
    if (imaginario >= 0) {
      return '$real + ${imaginario}i';
    } else {
      return '$real - ${imaginario.abs()}i';
    }
  }
}

class CalculadoraComplejos {
  static NumeroComplejo suma(NumeroComplejo z1, NumeroComplejo z2) {
    double real = z1.real + z2.real;
    double imaginario = z1.imaginario + z2.imaginario;
    return NumeroComplejo(real, imaginario);
  }

  static NumeroComplejo resta(NumeroComplejo z1, NumeroComplejo z2) {
    double real = z1.real - z2.real;
    double imaginario = z1.imaginario - z2.imaginario;
    return NumeroComplejo(real, imaginario);
  }

  static NumeroComplejo multiplicacion(NumeroComplejo z1, NumeroComplejo z2) {
    double real = (z1.real * z2.real) - (z1.imaginario * z2.imaginario);
    double imaginario = (z1.real * z2.imaginario) + (z1.imaginario * z2.real);
    return NumeroComplejo(real, imaginario);
  }

  static NumeroComplejo division(NumeroComplejo z1, NumeroComplejo z2) {
    double denominador = (z2.real * z2.real) + (z2.imaginario * z2.imaginario);
    
    if (denominador == 0) {
      throw Exception('No se puede dividir entre cero');
    }
    
    double real = ((z1.real * z2.real) + (z1.imaginario * z2.imaginario)) / denominador;
    double imaginario = ((z1.imaginario * z2.real) - (z1.real * z2.imaginario)) / denominador;
    
    return NumeroComplejo(real, imaginario);
  }

  static double modulo(NumeroComplejo z) {
    return sqrt((z.real * z.real) + (z.imaginario * z.imaginario));
  }

  static NumeroComplejo conjugado(NumeroComplejo z) {
    return NumeroComplejo(z.real, -z.imaginario);
  }
}
