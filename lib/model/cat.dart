import 'package:bsadosecalculator/model/animal.dart';
import 'dart:math';

class Cat extends Animal {
  int id = 1;

  Cat() : super('Cat') {
    this.bsaStandard = 0.0;
    this.bsaNew = null;
    this.imagePath = 'assets/Illinois-Logo-Full-Color-RGB.png';
    this.bsaStandardCitation =
    "Gustafson D and Page R (2013). Cancer Chemotherapy.  In Withrow SJ, Vail DM, Page R (Eds) Small Animal Clinical Oncology. 6th ed (pg 164). St. Louis, MO: Saunders.";

  }

  @override
  void calculateBSA() {
    if (weightKG != 0.0) {
      bsaStandard = 0.10 * pow(weightKG, (2 / 3));
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
