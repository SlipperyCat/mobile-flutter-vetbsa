import 'package:bsadosecalculator/model/animal.dart';
import 'dart:math';

class Rabbit extends Animal {
  int id = 5;

  Rabbit() : super('Rabbit') {
    this.bsaStandard = 0.0;
    this.bsaNew = null;
    this.imagePath = 'assets/Illinois-Logo-Full-Color-RGB.png';
    this.bsaStandardCitation = "Zehnder AM, et al.  Am J Vet Res. 2012; 73(12):1859-63";
  }

  @override
  void calculateBSA() {
    if (weightKG != 0.0) {
      bsaStandard = 0.099 * pow(weightKG, (2 / 3));
    }

    else {
      bsaStandard = 0.0;
    }
  }

  @override
  double getBSA(String calculationType) {
    double bodySurfaceAreaResult = 0.0;

    switch (calculationType) {
      case 'BSA (New)':
        bodySurfaceAreaResult = null;
        break;
      case 'BSA (Standard)':
        bodySurfaceAreaResult = double.parse((bsaStandard).toStringAsFixed(3));
        break;
    }

    return bodySurfaceAreaResult;
  }

}
