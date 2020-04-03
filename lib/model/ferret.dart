import 'package:bsadosecalculator/model/animal.dart';
import 'dart:math';

class Ferret extends Animal {
  int id = 4;

  Ferret() : super('Ferret') {
    this.bsaStandard = 0.0;
    this.bsaNew = null;
    this.imagePath = 'assets/Illinois-Logo-Full-Color-RGB.png';
    this.bsaStandardCitation = "Jones KL, et al. Am J Vet Res. 2015;76(2):142-8.";
  }

  @override
  void calculateBSA() {
    if (weightKG != 0.0) {
      bsaStandard = 0.0994 * pow(weightKG, (2 / 3));
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
