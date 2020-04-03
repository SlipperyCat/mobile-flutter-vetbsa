import 'package:bsadosecalculator/constants.dart';

class Animal {
  int id = 0;

  String imagePath;
  String species;

  double weightKG = 0.0;
  double weightLB = 0.0;
  double lengthCM = 0.0;
  double lengthIN = 0.0;
  double bsaStandard = -1.0;
  double bsaNew = -1.0;

  String bsaStandardCitation = "No citation available.";
  String bsaNewCitation = "No citation available.";

  Animal(this.species) {
    this.imagePath =
        'assets/Illinois-Logo-Full-Color-RGB.png'; //Todo change to generic animal
  }

  void setWeight(String unit, double weight) {
    if (unit == "kg") {
      weightKG = weight;
      weightLB = double.parse((weight * kgToLbFactor).toStringAsFixed(1));
    } else if (unit == "lb") {
      weightLB = weight;
      weightKG = double.parse((weight / kgToLbFactor).toStringAsFixed(1));
    }

    calculateBSA();
  }

  void setLength(String unit, double length) {
    if (unit == "cm") {
      lengthCM = length;
      lengthIN = double.parse((length * cmToInFactor).toStringAsFixed(1));
    } else if (unit == "in") {
      lengthIN = length;
      lengthCM = double.parse((length / cmToInFactor).toStringAsFixed(1));
    }

    calculateBSA();
  }

  void calculateBSA() {}

  double getBSA(String calculationType) {
    double bsaResult = -1.0;

    switch (calculationType) {
      case 'BSA (Standard)':
        bsaResult = bsaStandard;
        break;
      case 'BSA (New)':
        bsaResult = bsaNew;
        break;
    }

    return bsaResult;
  }

  void resetAllFields() {
    setWeight('kg', 0.0);
    setLength('cm', 0.0);

    bsaStandard = -1.0;
    bsaNew = -1.0;
  }

  @override
  String toString() {
    return 'Animal{species: $species, weightKG: $weightKG, '
        'weightLB: $weightLB, lengthCM: $lengthCM, lengthIN: $lengthIN, '
        'bsaOld: $bsaStandard, bsaNew: $bsaNew}';
  }
}
