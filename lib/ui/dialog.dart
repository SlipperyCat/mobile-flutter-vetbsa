import 'package:bsadosecalculator/app_state.dart';
import 'package:bsadosecalculator/app_state_interactor.dart';
import 'package:bsadosecalculator/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bsadosecalculator/constants.dart';
import 'package:bsadosecalculator/model/animal.dart';
import 'package:bsadosecalculator/model/drug.dart';
import 'dart:io';

void buildLegalDialog(BuildContext context, Function function) {
  List<dynamic> sharedData() {
    return [
      Column(
        children: <Widget>[
          Text('Legal Disclaimer'),
        ],
      ),
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: legalDisclaimerRichText,
        ),
      ]),
      <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: actionTextStyle,
            )),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              function();
            },
            child: Text(
              "Ok",
              style: actionTextStyle,
            ))
      ],
    ];
  }

  displayPlatformDialog(context, sharedData());
}

void buildLegalDialogAbout(BuildContext context) {
  List<dynamic> sharedData() {
    return [
      Column(
        children: <Widget>[
          Text('Legal Disclaimer'),
        ],
      ),
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: legalDisclaimerRichText,
        ),
      ]),
      <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Ok",
              style: actionTextStyle,
            ))
      ],
    ];
  }

  displayPlatformDialog(context, sharedData());
}

void displayDoseDialog(
    BuildContext context,
    Animal _selectedAnimal,
    double _calculatedBSA,
    Drug _selectedDrug,
    double _selectedDosage,
    int _selectedDosageUnits1Index,
    int _selectedDosageUnits2Index,
    String _calculatedDose) {
  AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
  AppState appState = appStateInteractor.appState;

  List<dynamic> sharedData() {
    return [
      Column(
        children: <Widget>[
          /*
          Icon(
            Icons.healing,
            color: accentColor,
            size: defaultIconSize,
          ),
          */
          Text(
            'Calculation Summary',
            style: titleTextStyle,
          ),
        ],
      ),
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: '\n',
                style: baseTextStyleSmaller,
                children: <TextSpan>[
                  TextSpan(text: 'Species: '),
                  TextSpan(
                      text: _selectedAnimal.species + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Weight: '),
                  TextSpan(
                      text: _selectedAnimal.weightKG.toString() +
                          ' kg = ' +
                          _selectedAnimal.weightLB.toString() +
                          ' lb' +
                          '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Length: '),
                  TextSpan(
                      text: _selectedAnimal.lengthCM.toString() +
                          ' cm = ' +
                          _selectedAnimal.lengthIN.toString() +
                          ' in' +
                          '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'BSA: '),
                  TextSpan(
                      text: _calculatedBSA.toString() +
                          ' ' +
                          dosageUnits2[0] +
                          '\n \n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Drug: '),
                  TextSpan(
                      text: _selectedDrug.name + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Schedule: '),
                  TextSpan(
                      text: appState.schedule + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  TextSpan(text: 'Dosage: '),
                  TextSpan(
                      text: getDosageText(context) + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: getFrequencyText(context)),
                  TextSpan(
                      text: appState.drugDosagePerAnimal.frequency + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: getNoteText(context)),
                  TextSpan(
                      text: appState.drugDosagePerAnimal.otherInfo,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )),
        Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Dose: ' +
                  _calculatedDose +
                  ' ' +
                  dosageUnits1[_selectedDosageUnits1Index],
              textAlign: TextAlign.center,
              style: titleTextStyleLarger,
            )),
        /*Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(
                text: '',
                style: baseTextStyleSmaller,
                children: <TextSpan>[
                  TextSpan(text: getFrequencyText(context)),
                  TextSpan(
                      text: appState.drugDosagePerAnimal.frequency + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )),*/
      ]),
      <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Ok",
              style: actionTextStyle,
            ))
      ]
    ];
  }

  displayPlatformDialog(context, sharedData());
}

String getNoteText(BuildContext context) {
  AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
  AppState appState = appStateInteractor.appState;

  String noteText = "";

  if (appState.drugDosagePerAnimal.otherInfo != "") {
    noteText = "Note: ";
  }

  return noteText;
}

String getFrequencyText(BuildContext context) {
  AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
  AppState appState = appStateInteractor.appState;

  String frequencyText = "";

  if (appState.drugDosagePerAnimal.frequency != "") {
    frequencyText = "Frequency: ";
  }

  return frequencyText;
}

String getDosageText(BuildContext context) {
  AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
  AppState appState = appStateInteractor.appState;

  String dosageText = appState.dosage.toStringAsFixed(2) +
      ' ' +
      dosageUnits1[appState.dosageUnits1Index] +
      '/' +
      dosageUnits2[appState.dosageUnits2Index];

  if (appState.selectedDrug.name == "Chlorambucil" &&
      appState.schedule == "Metronomic" &&
      appState.animal.species == "Cat") {
    dosageText = "2.0 mg per cat";
  }

  return dosageText;
}

void buildDialog(BuildContext context, int dialogIndex) {
  Widget imageWidget = Container();

  if (dialogIndex == 2) {
    // Length info
    imageWidget = Image.asset(
      "assets/dog_measurement.png",
      scale: 9,
    );
  }

  List<dynamic> sharedData() {
    return [
      Column(
        children: <Widget>[
          Text(
            dialogTitles[dialogIndex],
            style: titleTextStyle,
            textAlign: TextAlign.center,
          ),
          imageWidget
        ],
      ),
      Text(
        dialogContent[dialogIndex],
        style: baseTextStyleSmaller,
        textAlign: TextAlign.left,
      ),
      <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Ok",
              style: actionTextStyle,
            ))
      ]
    ];
  }

  displayPlatformDialog(context, sharedData());
}

void buildDrugDialog(BuildContext context, int dialogIndex, Drug selectedDrug) {
  AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
  AppState appState = appStateInteractor.appState;

  String displayText = "";

  if (appState.animal.id != 0) {
    displayText += "Species: " + appState.animal.species + "\n\n";

    if (selectedDrug.name != "Select...") {
      displayText += "Drug: " + selectedDrug.name + "\n\n";
      displayText += "Citation: " + appState.drugDosagePerAnimal.citation;
    } else {
      displayText += "Drug: Select a drug.";
    }
  } else {
    displayText += "Species: Select a species";
  }

  List<dynamic> sharedData() {
    return [
      Column(
        children: <Widget>[
          Text(
            dialogTitles[dialogIndex],
            style: titleTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      Text(
        displayText,
        style: baseTextStyleSmaller,
        textAlign: TextAlign.left,
      ),

      /*Text(
        selectedDrug.name != "Select..."
            ? selectedDrug.name + "\n\n" + selectedDrug.citation
            : selectedDrug.citation,
        style: baseTextStyleSmaller,
        textAlign: TextAlign.left,
      ),*/
      <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Ok",
              style: actionTextStyle,
            ))
      ]
    ];
  }

  displayPlatformDialog(context, sharedData());
}

void buildBSADialog(
    BuildContext context, int dialogIndex, Animal selectedAnimal) {
  AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
  AppState appState = appStateInteractor.appState;

  String displayText = "";

  if (selectedAnimal.species != "Select...") {
    displayText += "Species: " + selectedAnimal.species + "\n\n";

    if (appState.bsaTypeIndex == 1) {
      displayText += "BSA Type: " + bsaTypes[appState.bsaTypeIndex] + "\n\n";
      displayText += "Citation: " + selectedAnimal.bsaStandardCitation;
    } else if (appState.bsaTypeIndex == 2) {
      displayText += "BSA Type: " + bsaTypes[appState.bsaTypeIndex] + "\n\n";

      if (selectedAnimal.species == "Dog"){
        displayText += "This new BSA formula was developed to provide a more accurate starting point for drug dosing, and might be especially helpful for dosing small patients more accurately. To learn more about how this formula was developed, see Girens R, et al. J Vet Intern Med. 2019 Mar;33(2):792-799" + "\n\n";
      }

      else{
        displayText += "This new BSA formula was developed to provide a more accurate starting point for drug dosing, and might be especially helpful for dosing small patients more accurately. It is currently only available for dogs." + "\n\n";
      }
      //displayText += "Citation: " + selectedAnimal.bsaNewCitation;

    } else {
      displayText += "Select a BSA Type.";
    }
  } else {
    displayText = "Select a Species." + "\n\n";
    displayText += "Select a BSA Type.";
  }

  List<dynamic> sharedData() {
    return [
      Column(
        children: <Widget>[
          Text(
            dialogTitles[dialogIndex],
            style: titleTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      Text(
        displayText,
        style: baseTextStyleSmaller,
        textAlign: TextAlign.left,
      ),
      <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Ok",
              style: actionTextStyle,
            ))
      ]
    ];
  }

  displayPlatformDialog(context, sharedData());
}

void displayPlatformDialog(BuildContext context, List<dynamic> sharedDataList) {
  if (Platform.isIOS) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: sharedDataList[0],
        content: sharedDataList[1],
        actions: sharedDataList[2],
      ),
    );
  } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: sharedDataList[0],
        content: SingleChildScrollView(child: sharedDataList[1]),
        actions: sharedDataList[2],
      ),
    );
  }
}
