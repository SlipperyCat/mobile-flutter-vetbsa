import 'dart:async';
import 'package:bsadosecalculator/app_state.dart';
import 'package:bsadosecalculator/constants.dart';
import 'package:bsadosecalculator/model/dosage.dart';
import 'package:bsadosecalculator/ui/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppStateInteractor extends StatefulWidget {
  final AppState appState;
  final Widget child;

  AppStateInteractor({
    @required this.child,
    this.appState,
  });

  static AppStateInteractorState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  AppStateInteractorState createState() => AppStateInteractorState();
}

class AppStateInteractorState extends State<AppStateInteractor> {
  AppState appState;

  @override
  void initState() {
    print("[App State Interactor] initState()");
    super.initState();

    if (widget.appState != null) {
      appState = widget.appState;
    } else {
      appState = AppState.loading();

      //_loadPreferences();
    }
  }

  Future<Null> _loadPreferences() async {
    appState.mySharedPreferences.getPrimaryWeightUnitIndex().then((value) {
      setState(() {
        appState.primaryWeightUnitIndex = value;
        appState.primaryWeightUnit = weightUnits[value];
      });
    });

    appState.mySharedPreferences.getSecondaryWeightUnitIndex().then((value) {
      setState(() {
        appState.secondaryWeightUnitIndex = value;
        appState.secondaryWeightUnit = weightUnits[value];
      });
    });

    appState.mySharedPreferences.getPrimaryLengthUnitIndex().then((value) {
      setState(() {
        appState.primaryLengthUnitIndex = value;
        appState.primaryLengthUnit = lengthUnits[value];
      });
    });

    appState.mySharedPreferences.getSecondaryLengthUnitIndex().then((value) {
      setState(() {
        appState.secondaryLengthUnitIndex = value;
        appState.secondaryLengthUnit = lengthUnits[value];
      });
    });

    appState.mySharedPreferences.getDosageUnit1Index().then((value) {
      setState(() {
        appState.dosageUnits1Index = value;
      });
    });

    appState.mySharedPreferences.getDosageUnit2Index().then((value) {
      setState(() {
        appState.dosageUnits2Index = value;
      });
    });
  }

  void setSpecies(int selectedSpeciesIndex) {
    setState(() {
      appState.animal = animals[selectedSpeciesIndex];

      setWeight(appState.weightController.text);
      setLength(appState.lengthController.text);

      setDrug(appState.drugIndex); // Recalculate all dosages
    });
  }

  void setWeight(String weight) {
    setState(() {
      if (weight.length == 0) {
        weight = "0.0";
      }

      appState.animal
          .setWeight(appState.primaryWeightUnit, double.parse(weight));
      setBSACalculation();
    });
  }

  void setBSACalculation() {
    appState.bsaDouble = appState.animal.getBSA(appState.bsaCalculationType);

    if (appState.bsaDouble != null) {
      if (appState.bsaDouble < 0.0) {
        appState.bsaDisplayText = 'Need Species';
      } else {
        if (appState.animal.weightKG <= 0.0) {
          appState.bsaDisplayText = 'Need Weight';
        } else {
          if (appState.bsaCalculationType == bsaTypes[1]) {
            // Standard
            appState.bsaDisplayText =
                appState.bsaDouble.toString() + ' ' + dosageUnits2[0];
          } else if (appState.bsaCalculationType == bsaTypes[0]) {
            // None
            appState.bsaDisplayText = 'Need BSA Type';
          } else if (appState.bsaCalculationType == bsaTypes[2]) {
            // New
            if (appState.animal.lengthCM <= 0.0) {
              appState.bsaDisplayText = 'Need Length';
            } else {
              appState.bsaDisplayText =
                  appState.bsaDouble.toString() + ' ' + dosageUnits2[0];
            }
          }
        }
      }
    } else {
      appState.bsaDisplayText =
          bsaTypes[2] + ' is not available yet for this species';
    }

    validateFinalCalculation();
  }

  void validateFinalCalculation() {
    appState.isDoseCalculationReady = false;

    if (appState.bsaDouble != null) {
      if (appState.bsaDouble > 0.0) {
        if (appState.drugLowDosage <=
                appState.dosage // Todo Multiply lowdosage by 0.75 if we are allowing for a 25% adjustment
            &&
            appState.dosage <= appState.drugHighDosage) {
          if (appState.dosage != 0.0) {
            appState.isDoseCalculationReady = true;
          }
        }
      }
    }

    if (appState.selectedDrug.name == "Chlorambucil" &&
        appState.animal.species == "Cat" &&
        appState.schedule == "Metronomic") {
      appState.isDoseCalculationReady = true;
    }
  }

  void setBSAType(int index) {
    setState(() {
      appState.bsaTypeIndex = index;
      appState.bsaCalculationType = bsaTypes[index];

      switch (index) {
        case 0:
        case 1:
          appState.isLengthContainerEnabled = false;
          break;
        case 2:
          appState.isLengthContainerEnabled = true;
          break;
      }

      setBSACalculation();

      if (index == 2) {
        appState.lengthPlaceholderText = 'Enter Length';
      } else {
        setLength("0.0");
        appState.lengthController.clear();
        appState.lengthPlaceholderText = 'Not Required';
      }
    });
  }

  void setLength(String length) {
    setState(() {
      if (length.length == 0) {
        length = "0.0";
      }

      appState.animal
          .setLength(appState.primaryLengthUnit, double.parse(length));

      setBSACalculation();
    });
  }

  void setDrug(int index) {
    setState(() {
      appState.drugIndex = index;
      appState.selectedDrug = drugs[appState.drugIndex];

      buildScheduleList();

      appState.isDosageContainerEnabled = true;

      if (appState.selectedDrug.name == "Chlorambucil" &&
          appState.animal.species == "Cat" &&
          appState.schedule == 'Metronomic') {
        appState.isDosageContainerEnabled = false;
      }

      _validateDosageRange();

      if (appState.dosageController.text.length == 0) {
        setDosage("0.0");
      } else {
        setDosage(appState.dosageController.text);
      }
    });
  }

  void buildScheduleList(){
    bool mtd = false;
    bool metronomic = false;

    if (appState.selectedDrug.dosages != null) {
      for (Dosage dosage in appState.selectedDrug.dosages) {
        if (dosage.schedule == "MTD") {
          mtd = true;
        }

        if (dosage.schedule == "Metronomic") {
          metronomic = true;
        }
      }
    }

    if (mtd && !metronomic) {
      appState.currentScheduleList = schedulesMTD;
      appState.schedule = "MTD";
      appState.scheduleIndex = 0;

      /*if (appState.currentScheduleList.length - 1 < appState.scheduleIndex) {
        if (appState.scheduleIndex == 2) {
          appState.scheduleIndex -= 1;
          appState.schedule = "MTD";
        }
      }*/
    }

    if (mtd && metronomic) {
      appState.currentScheduleList = schedulesAll;
      if (appState.schedule == "MTD"){
        appState.scheduleIndex = 1;
      }
    }

    if (appState.selectedDrug.name == "Other/Override...") {
      appState.currentScheduleList = schedulesNone;
      appState.scheduleIndex = 0;
      appState.schedule = "Select...";
      appState.isSchedulePickerEnabled = false;
    }

    else {
      appState.isSchedulePickerEnabled = true;
    }
  }

  void setSchedule(int scheduleIndex) {
    setState(() {
      appState.schedule = schedulesAll[scheduleIndex];
      appState.scheduleIndex = scheduleIndex;

      appState.isDosageContainerEnabled = true;

      if (appState.selectedDrug.name == "Chlorambucil" &&
          appState.animal.species == "Cat" &&
          appState.schedule == 'Metronomic') {
        appState.isDosageContainerEnabled = false;
      }

      _validateDosageRange();

      validateFinalCalculation();
    });
  }

  List<dynamic> _validateDosageRange() {
    switch (appState.animal.species) {
      case 'Select...':
        appState.drugDosagePerAnimal = emptyDosage;
        break;
      case 'Cat':
        for (Dosage dosage in appState.selectedDrug.dosages) {
          if (dosage.schedule == appState.schedule &&
              dosage.forAnimal == appState.animal.species) {
            appState.drugDosagePerAnimal = dosage;
            break;
          } else {
            appState.drugDosagePerAnimal = emptyDosage;
          }
        }

        break;
      case 'Dog':
        for (Dosage dosage in appState.selectedDrug.dosages) {
          if (dosage.schedule == appState.schedule &&
              dosage.forAnimal == appState.animal.species) {
            appState.drugDosagePerAnimal = dosage;
            break;
          } else {
            appState.drugDosagePerAnimal = emptyDosage;
          }
        }

        break;
      case 'Horse':
        for (Dosage dosage in appState.selectedDrug.dosages) {
          if (dosage.schedule == appState.schedule &&
              dosage.forAnimal == appState.animal.species) {
            appState.drugDosagePerAnimal = dosage;
            break;
          } else {
            appState.drugDosagePerAnimal = emptyDosage;
          }
        }

        break;
    }

    if (appState.selectedDrug.name == "Other/Override..."){
      appState.drugDosagePerAnimal = OtherOverrideDosages[0];
    }

    double normalTarget;
    double lowTarget;
    double highTarget;
    String adjustmentType;

    switch (dosageUnits2[appState.dosageUnits2Index]) {
      case 'm' + '\u00B2':
        if (appState.dosage < appState.drugDosagePerAnimal.lowMgM2) {
          normalTarget = appState.drugDosagePerAnimal.lowMgM2;
          adjustmentType = 'low';
        } else if (appState.drugDosagePerAnimal.highMgM2 < appState.dosage) {
          normalTarget = appState.drugDosagePerAnimal.highMgM2;
          adjustmentType = 'high';
        }

        lowTarget = appState.drugDosagePerAnimal.lowMgM2;
        highTarget = appState.drugDosagePerAnimal.highMgM2;
        break;
      case 'kg':
        if (appState.dosage < appState.drugDosagePerAnimal.lowMgKg) {
          normalTarget = appState.drugDosagePerAnimal.lowMgKg;
          adjustmentType = 'low';
        } else if (appState.drugDosagePerAnimal.highMgKg < appState.dosage) {
          normalTarget = appState.drugDosagePerAnimal.highMgKg;
          adjustmentType = 'high';
        }

        lowTarget = appState.drugDosagePerAnimal.lowMgKg;
        highTarget = appState.drugDosagePerAnimal.highMgKg;
        break;
      case 'lb':
        if (appState.dosage < appState.drugDosagePerAnimal.lowMgLb) {
          normalTarget = appState.drugDosagePerAnimal.lowMgLb;
          adjustmentType = 'low';
        } else if (appState.drugDosagePerAnimal.highMgLb < appState.dosage) {
          normalTarget = appState.drugDosagePerAnimal.highMgLb;
          adjustmentType = 'high';
        }

        lowTarget = appState.drugDosagePerAnimal.lowMgLb;
        highTarget = appState.drugDosagePerAnimal.highMgLb;
        break;
    }
    appState.drugLowDosage = lowTarget;
    appState.drugHighDosage = highTarget;

    //validateFinalCalculation();

    List returnData() {
      return [normalTarget, adjustmentType];
    }

    return returnData();
  }

  void setDosage(String dosage) {
    print("[App] SetDosage()");
    setState(() {
      appState.dosage = double.parse(dosage);

      if (appState.drugLowDosage <= double.parse(dosage) && // Todo Multiply lowdosage by 0.75 if we are allowing for a 25% adjustment
          double.parse(dosage) <= appState.drugHighDosage) {
        appState.dosageTextFieldColor = primaryColor;
        appState.dosageOutOfRange = false;
      } else {
        if (appState.dosageController.text.length == 0) {
          appState.dosageTextFieldColor = primaryColor;
          appState.dosageOutOfRange = false;
        } else {
          appState.dosageTextFieldColor = Colors.red;
          appState.dosageOutOfRange = true;
        }
      }
      validateFinalCalculation();
    });
  }

  void displayLegalDialog(BuildContext context, Function _calculateDose) {
    buildLegalDialog(context, _calculateDose);
  }

  void displayLegalDialogAbout(BuildContext context) {
    buildLegalDialogAbout(context);
  }

  void displayDialog(BuildContext context, int dialogIndex) {
    buildDialog(context, dialogIndex);
  }

  void displayDrugDialog(BuildContext context, int dialogIndex) {
    buildDrugDialog(context, dialogIndex, appState.selectedDrug);
  }

  void displayBSADialog(BuildContext context, int dialogIndex) {
    buildBSADialog(context, dialogIndex, appState.animal);
  }

  void calculateDose(BuildContext context) {
    setState(() {
      switch (dosageUnits2[appState.dosageUnits2Index]) {
        case 'm' + '\u00B2':
          if (appState.bsaCalculationType == bsaTypes[1]) {
            // Standard
            appState.calculatedDose =
                (appState.animal.getBSA(appState.bsaCalculationType) *
                        appState.dosage)
                    .toStringAsFixed(2);
          } else if (appState.bsaCalculationType == bsaTypes[2]) {
            // New
            appState.calculatedDose =
                (appState.animal.getBSA(appState.bsaCalculationType) *
                        appState.dosage)
                    .toStringAsFixed(2);
          }
          break;
        case 'kg':
          appState.calculatedDose =
              (appState.animal.weightKG * appState.dosage).toStringAsFixed(2);
          break;
        case 'lb':
          appState.calculatedDose =
              (appState.animal.weightLB * appState.dosage).toStringAsFixed(2);
          break;
      }

      if (appState.selectedDrug.name == "Chlorambucil" &&
          appState.animal.species == "Cat" &&
          appState.schedule == 'Metronomic') {
        appState.dosage = 2.0;
        appState.calculatedDose = appState.dosage.toStringAsFixed(2);
      }
    });

    displayDoseDialog(
        context,
        appState.animal,
        appState.bsaDouble,
        appState.selectedDrug,
        appState.dosage,
        appState.dosageUnits1Index,
        appState.dosageUnits2Index,
        appState.calculatedDose);
  }

/*  void setDosageUnits1(int index) {
    setState(() {
      appState.dosageUnits1Index = index;
      appState.mySharedPreferences.setDosageUnit1Index(index);

      _validateDosageRange();

      if (appState.dosageController.text.length != 0) {
        setDosage(appState.dosageController.text);
      } else {
        setDosage("0.0");
      }
    });
  }

  void setDosageUnits2(int index) {
    setState(() {
      appState.dosageUnits2Index = index;
      appState.mySharedPreferences.setDosageUnit2Index(index);

      _validateDosageRange();

      if (appState.dosageController.text.length != 0) {
        setDosage(appState.dosageController.text);
      } else {
        setDosage("0.0");
      }
    });
  }*/

  void setDosageUnits(int index) {
    setState(() {
      appState.dosageUnitsIndex = index;
      appState.mySharedPreferences.setDosageUnitsIndex(index);

      // Todo set legacy units here
      String dosageUnit1 = dosageUnits[index].split("/")[0];
      String dosageUnit2 = dosageUnits[index].split("/")[1];

      appState.dosageUnits1Index = findDosageIndex(dosageUnits1, dosageUnit1);
      appState.dosageUnits2Index = findDosageIndex(dosageUnits2, dosageUnit2);

      _validateDosageRange();

      if (appState.dosageController.text.length != 0) {
        setDosage(appState.dosageController.text);
      } else {
        setDosage("0.0");
      }
    });
  }

  int findDosageIndex(List<String> list, String value){
    int result = 0;

    for(int i = 0; i < list.length; i++){
      if (list[i] == value){
        result = i;
      }
    }

    return result;
  }

  void setPrimaryWeightUnit(int index) {
    setState(() {
      appState.primaryWeightUnitIndex = index;
      appState.primaryWeightUnit = weightUnits[index];

      appState.mySharedPreferences.setPrimaryWeightUnitIndex(index);

      _setSecondaryWeightUnit();

      setWeight(appState.weightController.text);
    });
  }

  void _setSecondaryWeightUnit() {
    setState(() {
      switch (appState.primaryWeightUnit) {
        case 'kg':
          appState.secondaryWeightUnitIndex = 1;
          appState.secondaryWeightUnit = 'lb';
          break;
        case 'lb':
          appState.secondaryWeightUnitIndex = 0;
          appState.secondaryWeightUnit = 'kg';
          break;
      }
      appState.mySharedPreferences
          .setSecondaryWeightUnitIndex(appState.secondaryWeightUnitIndex);
    });
  }

  void setPrimaryLengthUnit(int index) {
    setState(() {
      appState.primaryLengthUnitIndex = index;
      appState.primaryLengthUnit = lengthUnits[index];

      appState.mySharedPreferences.setPrimaryLengthUnitIndex(index);

      _setSecondaryLengthUnit();

      setLength(appState.lengthController.text);
    });
  }

  void _setSecondaryLengthUnit() {
    setState(() {
      switch (appState.primaryLengthUnit) {
        case 'cm':
          appState.secondaryLengthUnitIndex = 1;
          appState.secondaryLengthUnit = 'in';
          break;
        case 'in':
          appState.secondaryLengthUnitIndex = 0;
          appState.secondaryLengthUnit = 'cm';
          break;
      }
      appState.mySharedPreferences
          .setSecondaryLengthUnitIndex(appState.secondaryLengthUnitIndex);
    });
  }

  void resetAllFields() {
    print("[App] ResetAllFields()");

    setState(() {
      appState.animal = animals[0];
      setPrimaryWeightUnit(0);

      appState.animal.setWeight(weightUnits[0], 0.0);
      appState.animal.setLength('cm', 0.0);

      setBSAType(0);

      appState.bsaDouble = 0.0;
      setDrug(0);

      appState.weightController = TextEditingController();
      appState.lengthController = TextEditingController();
      appState.dosageController = TextEditingController();

      appState.dosageTextFieldColor = primaryColor;

      appState.calculatedDose = '0.0';
      appState.dosageOutOfRange = false;
    });
  }

  void toggleWeightContainerLocked() {
    setState(() {
      appState.isWeightContainerEnabled = !appState.isWeightContainerEnabled;
    });
  }

  void toggleLengthContainerLocked() {
    setState(() {
      appState.isLengthContainerEnabled = !appState.isLengthContainerEnabled;
    });
  }

  void toggleDosageContainerLocked() {
    setState(() {
      appState.isDosageContainerEnabled = !appState.isDosageContainerEnabled;
    });
  }

  // WidgetTree is: AppStateContainer --> InheritedStateContainer --> Rest of app.
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  // The data is whatever this widget is passing down.
  final AppStateInteractorState data;

  // InheritedWidgets are always just wrappers.
  // So there has to be a child,
  // Although Flutter just knows to build the Widget thats passed to it
  // So you don't have have a build method or anything.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // There is a better way to do this, which you'll see later.
  // But basically, Flutter automatically calls this method when any data
  // in this widget is changed.
  // You can use this method to make sure that flutter actually should
  // repaint the tree, or do nothing.
  // It helps with performance.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
