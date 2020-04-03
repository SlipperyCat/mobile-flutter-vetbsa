import 'package:bsadosecalculator/constants.dart';

class Dosage {
  final String forAnimal;

  final double lowMgM2;
  final double highMgM2;

  double lowMgKg = 0.0;
  double highMgKg = 0.0;

  double lowMgLb = 0.0;
  double highMgLb = 0.0;

  final String frequency;
  final String otherInfo;
  final String citation;

  final String schedule;

  /*Dosage(){
    this.forAnimal = "";
    this.mtdMetronomic = "?";
    this.lowMgM2 = 0.0;
    this.highMgM2 = 0.0;
    this.frequency = "";
    this.otherInfo = "";
    this.citation = "N/A";
  }*/

  Dosage.explicit(
      this.forAnimal,
      this.schedule,
      this.lowMgM2,
      this.highMgM2,
      this.frequency,
      this.otherInfo,
      this.citation);

  Dosage.withWeight(
      this.forAnimal,
      this.schedule,
      this.lowMgM2,
      this.highMgM2,
      this.lowMgKg,
      this.highMgKg,
      this.frequency,
      this.otherInfo,
      this.citation) {
    this.lowMgLb = double.parse((lowMgKg * kgToLbFactor).toStringAsFixed(2));
    this.highMgLb = double.parse((highMgKg * kgToLbFactor).toStringAsFixed(2));
  }

  @override
  String toString() {
    return 'Dosage{forAnimal: $forAnimal, lowMgM2: $lowMgM2, highMgM2: $highMgM2, lowMgKg: $lowMgKg, highMgKg: $highMgKg, lowMgLb: $lowMgLb, highMgLb: $highMgLb}';
  }
}
