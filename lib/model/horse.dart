import 'package:bsadosecalculator/model/animal.dart';
import 'dart:math';

class Horse extends Animal {
  int id = 3;

  Horse() : super('Horse') {
    this.bsaStandard = 0.0;
    this.bsaNew = null;
    this.imagePath = 'assets/Illinois-Logo-Full-Color-RGB.png';
    this.bsaStandardCitation = "Theilen GH, Madewell BR. Clinical application of cancer chemotherapy. In: Theilen GH, Madewell BR, eds. Veterinary Cancer Medicine, 2nd ed. Philadelphia, PA: Lea and Febiger; 1987:183–196.";
  }

  @override
  void calculateBSA() {
    if (weightKG != 0.0) {
      bsaStandard = 0.105 * pow(weightKG, (2 / 3));
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
