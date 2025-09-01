import 'package:bsadosecalculator/model/animal.dart';
import 'dart:math';

class Dog extends Animal {
  int id = 2;

  Dog() : super('Dog') {
    this.bsaStandard = 0.0;
    this.bsaNew = 0.0;
    this.imagePath = 'assets/Illinois-Logo-Full-Color-RGB.png';
    this.bsaStandardCitation =
        "Gustafson D and Page R (2013). Cancer Chemotherapy.  In Withrow SJ, Vail DM, Page R (Eds) Small Animal Clinical Oncology. 6th ed (pg 164). St. Louis, MO: Saunders.";
    this.bsaNewCitation =
        "Girens R, et al. J Vet Intern Med. 2019 Mar;33(2):792-799";
  }

  @override
  void calculateBSA() {
    if (weightKG != 0.0) {
      bsaStandard = 0.101 * pow(weightKG, (2 / 3));
    } else {
      bsaStandard = 0.0;
    }

    if (weightKG != 0.0 && lengthCM != 0.0) {
      bsaNew = 0.0134 * pow(weightKG, 0.4746) * pow(lengthCM, 0.6393);
    } else {
      bsaNew = 0.0;
    }
  }

  @override
  double getBSA(String calculationType) {
    double bodySurfaceAreaResult = 0.0;

    switch (calculationType) {
      case 'BSA (New)':
        bodySurfaceAreaResult = double.parse((bsaNew).toStringAsFixed(3));
        break;
      case 'BSA (Standard)':
        bodySurfaceAreaResult = double.parse((bsaStandard).toStringAsFixed(3));
        break;
    }

    return bodySurfaceAreaResult;
  }
}
