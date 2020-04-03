import 'package:bsadosecalculator/constants.dart';
import 'package:bsadosecalculator/model/dosage.dart';

class Drug {
  String name;

  Dosage noDosage = emptyDosage;
  Dosage catDosage;
  Dosage dogDosage;
  Dosage horseDosage;
  Dosage ferretDosage;
  Dosage rabbitDosage;

  String mtdMetronomic;

  List<Dosage> dosages;

  Drug();

  Drug.withDosages(this.name,
      this.catDosage,
      this.dogDosage,
      this.horseDosage);

  Drug.withDosageList(this.name,
      this.dosages);

  @override
  String toString() {
    return 'Drug{name: $name, \n noDosage: $noDosage, \n catDosage: $catDosage, \n dogDosage: $dogDosage, \n horseDosage: $horseDosage}';
  }
}
