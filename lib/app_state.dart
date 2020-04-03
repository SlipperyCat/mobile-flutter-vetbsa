import 'package:bsadosecalculator/model/dosage.dart';
import 'package:bsadosecalculator/my_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bsadosecalculator/model/animal.dart';
import 'constants.dart';
import 'package:bsadosecalculator/model/drug.dart';

class AppState {
  final MySharedPreferences mySharedPreferences = MySharedPreferences();

  bool isLoading;

  Animal animal = animals[0];

  String primaryWeightUnit = weightUnits[0];
  int primaryWeightUnitIndex = 0;

  String secondaryWeightUnit = weightUnits[1];
  int secondaryWeightUnitIndex = 1;

  String primaryLengthUnit = lengthUnits[0];
  int primaryLengthUnitIndex = 0;

  String secondaryLengthUnit = lengthUnits[1];
  int secondaryLengthUnitIndex = 1;

  int bsaTypeIndex = 0;
  String bsaCalculationType = bsaTypes[0];

  String bsaDisplayText = 'Need species';
  double bsaDouble;

  int drugIndex = 0;
  Drug selectedDrug = drugs[0];

  Dosage drugDosagePerAnimal = drugs[0].catDosage;

  double drugLowDosage = 0.0;
  double drugHighDosage = 0.0;
  double dosage = 0.0;

  int dosageUnits1Index = 0;
  int dosageUnits2Index = 0;

  int dosageUnitsIndex = 0;

  String calculatedDose = '0.0';

  bool isDoseCalculationReady = false;
  bool isWeightContainerEnabled = true;
  bool isLengthContainerEnabled = false;
  bool isDosageContainerEnabled = true;

  TextEditingController weightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController dosageController = TextEditingController();

  final FocusNode speciesFocusNode = FocusNode();
  final FocusNode bsaFocusNode = FocusNode();
  final FocusNode weightFocusNode = FocusNode();
  final FocusNode lengthFocusNode = FocusNode();
  final FocusNode drugFocusNode = FocusNode();
  final FocusNode scheduleFocusNode = FocusNode();
  final FocusNode dosageFocusNode = FocusNode();

  final FocusNode weightUnitFocusNode = FocusNode();
  final FocusNode lengthUnitFocusNode = FocusNode();
  final FocusNode dosageUnit1FocusNode = FocusNode();
  final FocusNode dosageUnit2FocusNode = FocusNode();

  final FocusNode dosageUnitsFocusNode = FocusNode();

  String lengthPlaceholderText = "Not Required";
  Color dosageTextFieldColor = primaryColor;

  bool bottomNavVisible = false;
  bool dosageOutOfRange = false;

  Widget currentBuildBar;

  String schedule = schedulesAll[0];
  int scheduleIndex = 0;

  List<String> currentScheduleList = schedulesAll;

  bool isSpeciesPickerEnabled = true;
  bool isBSAPickerEnabled = true;
  bool isDrugPickerEnabled = true;
  bool isSchedulePickerEnabled = true;

  AppState({
    this.isLoading = false,
  });

  factory AppState.loading() {
    return AppState(isLoading: true);
  }

  void printState() {
    String prefix = '[App State] printState() ';
    print('------------------------------------------------------------------');
    print(prefix + 'Weight Container Locked: ' + isWeightContainerEnabled.toString());
    print(prefix + 'Length Container Locked: ' + isLengthContainerEnabled.toString());
    print(prefix + 'Dosage Container Locked: ' + isDosageContainerEnabled.toString());

    print(prefix + animal.toString());
    print(prefix + 'Primary Weight Unit: ' + primaryWeightUnit);
    print(prefix + 'BSA Calculation Type: ' + bsaCalculationType);
    print(prefix + 'Calculated BSA: ' + bsaDouble.toString());
    print(prefix + 'BSA Display Text: ' + bsaDisplayText);
    print(prefix + selectedDrug.toString());
    print(prefix + 'Drug Dosage for Specific Animal: ' + drugDosagePerAnimal.toString());

    print(prefix + 'Drug Low Dosage for Species: ' + drugLowDosage.toString());
    print(prefix + 'Dosage: ' + dosage.toString());
    print(prefix + 'Drug High Dosage for Species: ' + drugHighDosage.toString());

    print(prefix + 'Dosage Unit 1: ' + dosageUnits1[dosageUnits1Index]);
    print(prefix + 'Dosage Unit 2: ' + dosageUnits2[dosageUnits2Index]);

    print(prefix + 'Calculation Ready?: ' + isDoseCalculationReady.toString());
    print(prefix + 'Calculated Dose: ' + calculatedDose);

    print(prefix + 'Schedule: ' + schedule);
    print('------------------------------------------------------------------');
  }


}
