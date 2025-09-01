import 'package:bsadosecalculator/app_state_interactor.dart';
import 'package:bsadosecalculator/model/dosage.dart';
import 'package:bsadosecalculator/my_flutter_app_icons.dart';
import 'package:bsadosecalculator/my_keyboard_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bsadosecalculator/constants.dart';
import 'package:bsadosecalculator/app_state.dart';
import 'package:bsadosecalculator/utils.dart';

class DoseCalculator extends StatelessWidget {
  final Function _displayLegalDialog;
  final Function _displayDialog;
  final Function _displayDrugDialog;
  final Function _displayBSADialog;

  DoseCalculator(this._displayLegalDialog, this._displayDialog,
      this._displayDrugDialog, this._displayBSADialog) {
    print('[DoseCalculator] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[DoseCalculator] build()');

    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    AppState appState = appStateInteractor.appState;

    FormKeyboardActions.setKeyboardActions(
        context, _buildKeyboardActionsConfig(appStateInteractor));

    double secondaryWeight = appState.animal.weightLB;
    if (appState.secondaryWeightUnit == 'kg') {
      secondaryWeight = appState.animal.weightKG;
    }

    double secondaryLength = appState.animal.lengthIN;
    if (appState.secondaryLengthUnit == 'cm') {
      secondaryLength = appState.animal.lengthCM;
    }

    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 4.0,
              runSpacing: defaultSpaceBetweenRows / 3,
              children: <Widget>[
                buildLabel(context, 'Species'),
                buildPickerDropDown(context, animals, appState.animal.id,
                    appState.speciesFocusNode, appState.isSpeciesPickerEnabled),
              ],
            )),
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            child: Wrap(
              spacing: 4.0,
              runSpacing: defaultSpaceBetweenRows / 3,
              children: <Widget>[
                Row(children: <Widget>[
                  buildLabel(context, 'BSA Type'),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        //_displayDialog(0);
                        _displayBSADialog(0);
                      },
                      child: Icon(
                        MyFlutterApp.more_info,
                        size: defaultIconSize,
                        color: accentColor,
                      ),
                    ),
                  ),
                ]),
                buildPickerDropDown(context, bsaTypes, appState.bsaTypeIndex,
                    appState.bsaFocusNode, appState.isBSAPickerEnabled),
              ],
            )),
        Container(
            padding: EdgeInsets.only(
                top: defaultSpaceBetweenRows,
                bottom: defaultSpaceBetweenRows / 2),
            child: Wrap(
              spacing: 4.0,
              runSpacing: defaultSpaceBetweenRows / 3,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildLabel(context, 'Weight'),
                    /*GestureDetector(
                      onTap: appStateInteractor.toggleWeightContainerLocked,
                      child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: appState.isWeightContainerEnabled
                              ? getLockIcon('open', false)
                              : getLockIcon('closed', false)),
                    ),*/
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: goldenScreenWidth,
                        child: buildTextField(
                            appState.weightController,
                            "Enter Weight",
                            appStateInteractor.setWeight,
                            appState.isWeightContainerEnabled,
                            primaryColor,
                            appState.weightFocusNode)),
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(appState.primaryWeightUnit),
                    ),
                  ],
                ),
                _buildSecondaryMeasurement(
                    secondaryWeight, appState.secondaryWeightUnit)
              ],
            )),
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            child: Wrap(
                spacing: 4.0,
                runSpacing: defaultSpaceBetweenRows / 3,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      buildLabel(context, 'Length'),
                      /*Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            onTap:
                                appStateInteractor.toggleLengthContainerLocked,
                            child: appState.isLengthContainerEnabled
                                ? getLockIcon('open', false)
                                : getLockIcon('closed', false),
                          )),*/
                      Container(
                        padding: EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            _displayDialog(2);
                          },
                          child: Icon(
                            MyFlutterApp.more_info,
                            size: defaultIconSize,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),


                  Row(
                    children: <Widget>[
                      Text(
                        "Manubrium to ishium",
                        style: baseTextStyle,
                        textScaleFactor: DOUBLE_85,
                      ),

                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Container(
                          width: goldenScreenWidth,
                          child: buildTextField(
                              appState.lengthController,
                              appState.lengthPlaceholderText,
                              appStateInteractor.setLength,
                              appState.isLengthContainerEnabled,
                              primaryColor,
                              appState.lengthFocusNode)),
                      Container(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(appState.primaryLengthUnit)),
                    ],
                  ),
                  _buildSecondaryMeasurement(
                      secondaryLength, appState.secondaryLengthUnit),
                ])),
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            child: Wrap(
              spacing: 4.0,
              runSpacing: defaultSpaceBetweenRows / 3,
              children: <Widget>[

                /*Row(children: <Widget>[
                  buildLabel(context, 'BSA Result'),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        _displayDialog(3);
                      },
                      child: Icon(
                        MyFlutterApp.more_info,
                        size: defaultIconSize,
                        color: accentColor,
                      ),
                    ),
                  ),
                ]),*/

                buildLabel(context, 'BSA Result'),
                  Text(
                    "Commonly used charts might round numbers and results might differ from the precise calculation here.",
                    style: baseTextStyle,
                    textScaleFactor: DOUBLE_85,
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 8.0),
                        child:
                            !appState.bsaDisplayText.contains(dosageUnits2[0])
                                ? Icon(
                                    MyFlutterApp.warning,
                                    color: warningColor,
                                    size: defaultIconSize,
                                  )
                                : null),
                    Expanded(
                      child: Text(
                        appState.bsaDisplayText,
                        style: baseTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            )),
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            child: Wrap(
                spacing: 4.0,
                runSpacing: defaultSpaceBetweenRows / 3,
                children: <Widget>[
                  Row(children: <Widget>[
                    buildLabel(context, 'Drug'),
                    Container(
                      padding: EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          _displayDrugDialog(1);
                        },
                        child: Icon(
                          MyFlutterApp.more_info,
                          size: defaultIconSize,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ]),
                  buildPickerDropDown(context, drugs, appState.drugIndex,
                      appState.drugFocusNode, appState.isDrugPickerEnabled),
                ])),
        appState.selectedDrug.name == "Other/Override..."
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(
                      MyFlutterApp.warning,
                      size: defaultIconSize,
                      color: warningColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "ALERT! This selection can be used to calculate any drug at any dosage. Use caution when verifying your calculations.",
                      style: baseTextStyle,
                      textScaleFactor: DOUBLE_85,
                    ),
                  ),
                ],
              )
            : Container(),
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            alignment: Alignment.centerLeft,
            child: Wrap(
                spacing: 4.0,
                runSpacing: defaultSpaceBetweenRows / 3,
                children: <Widget>[
                  buildLabel(context, 'Dosing Schedule'),
                  buildPickerDropDown(
                      context,
                      appState.currentScheduleList,
                      appState.scheduleIndex,
                      appState.scheduleFocusNode,
                      appState.isSchedulePickerEnabled),

                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                            getFrequencyText(context),
                            style: baseTextStyle,
                            textScaleFactor: DOUBLE_85,
                          ),
                  ),
                ])),
        Container(
            padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
            child: Wrap(
                spacing: 4.0,
                runSpacing: defaultSpaceBetweenRows / 3,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        buildLabel(context, 'Dosage'),
                        /*Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: GestureDetector(
                              onTap: appStateInteractor
                                  .toggleDosageContainerLocked,
                              child: appState.isDosageContainerEnabled
                                  ? getLockIcon('open', false)
                                  : getLockIcon('closed', false),
                            )),*/
                      ]),
                  Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 0.0),
                        child: Text(
                          "Calculated for single agent use.",
                          style: baseTextStyle,
                          textScaleFactor: DOUBLE_85,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          width: goldenScreenWidth,
                          padding: EdgeInsets.only(right: 8.0),
                          child: buildTextField(
                              appState.dosageController,
                              getDosageHint(context),
                              appStateInteractor.setDosage,
                              appState.isDosageContainerEnabled,
                              appState.dosageTextFieldColor,
                              appState.dosageFocusNode)),
                      Text(dosageUnits1[appState.dosageUnits1Index] +
                          "/" +
                          dosageUnits2[appState.dosageUnits2Index]),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          getRangeText(appState),
                          style: baseTextStyle.copyWith(
                              color: appState.dosageTextFieldColor),
                          textScaleFactor: DOUBLE_85,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 16.0),
                        child: getNoteText(appState) == ""
                            ? null
                            : Text(
                                getNoteText(appState),
                                style: baseTextStyle.copyWith(
                                    color: appState.dosageTextFieldColor),
                                textScaleFactor: DOUBLE_85,
                              ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: appState.dosageOutOfRange
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  MyFlutterApp.warning,
                                  size: defaultIconSize,
                                  color: warningColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Dosages outside of the recommended range can be calculated by using \"Other/Override\" in the drug selection field.",
                                  style: baseTextStyle,
                                  textScaleFactor: DOUBLE_85,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ])),
        Container(
            padding:
                EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows / 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      "Calculate",
                      textAlign: TextAlign.center,
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(color: CupertinoColors.white),
                    ),
                    color: accentColor,
                    onPressed: appState.isDoseCalculationReady
                        ? _displayLegalDialog
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: defaultSpaceBetweenRows / 2),
                    child: CupertinoButton(
                      child: Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        style: baseTextStyle,
                      ),
                      onPressed: appStateInteractor.resetAllFields,
                    ),
                  ),
                ])),
      ],
    );
  }

  String getDosageHint(BuildContext context) {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    AppState appState = appStateInteractor.appState;

    String dosageHint = "Enter Dosage";

    if (appState.selectedDrug.name == "Chlorambucil" &&
        appState.animal.species == "Cat" &&
        appState.schedule == "Metronomic") {
      appState.dosageController.clear();
      appState.dosageOutOfRange = false;
      appState.dosageTextFieldColor = Colors.black;

      dosageHint = "N/A";
    }

    return dosageHint;
  }

  String getRangeText(AppState _appState) {
    String rangeText = "Range: " +
        _appState.drugLowDosage.toString() +
        "-" +
        _appState.drugHighDosage.toString();

    rangeText += " " +
        dosageUnits1[_appState.dosageUnits1Index] +
        "/" +
        dosageUnits2[_appState.dosageUnits2Index];

    if (_appState.dosageUnits2Index != 0 &&
        _appState.drugLowDosage == 0.0 &&
        _appState.drugHighDosage == 0.0) {
      rangeText = "Range: " +
          dosageUnits1[0] +
          "/" +
          dosageUnits2[0] +
          " only. Check settings.";
    }

    if (_appState.dosageUnits2Index == 0 &&
        _appState.drugLowDosage == 0.0 &&
        _appState.drugHighDosage == 0.0) {
      rangeText = "Range: " +
          dosageUnits1[0] +
          "/" +
          dosageUnits2[1] +
          " only. Check settings.";
    }
    if (_appState.drugDosagePerAnimal != null) {
      if (_appState.drugDosagePerAnimal.lowMgKg == 0.0 &&
          _appState.drugDosagePerAnimal.highMgKg == 0 &&
          _appState.drugDosagePerAnimal.lowMgM2 == 0.0 &&
          _appState.drugDosagePerAnimal.highMgM2 == 0) {
        rangeText = "Range: N/A";

      }

      if (_appState.selectedDrug.name == "Other/Override...") {
        rangeText = "Range: " +
            _appState.drugLowDosage.toString() +
            "-" +
            _appState.drugHighDosage.toString();

        rangeText += " " +
            dosageUnits1[_appState.dosageUnits1Index] +
            "/" +
            dosageUnits2[_appState.dosageUnits2Index];
      }
    }

    if (_appState.selectedDrug.name == "Chlorambucil" &&
        _appState.animal.species == "Cat" &&
        _appState.schedule == "Metronomic") {
      rangeText = "Range: 2.0 mg per cat";
    }

    if (_appState.schedule == "Select...") {
      rangeText = "Range: Need Schedule";
    }

    if (_appState.selectedDrug.name == "Select...") {
      rangeText = "Range: Need Drug";
    }

    if (_appState.animal.species == "Select...") {
      rangeText = "Range: Need Species";
    }

    if (_appState.selectedDrug.name == "Other/Override...") {

        rangeText = "Range: " +
            _appState.drugLowDosage.toString() +
            "-" +
            _appState.drugHighDosage.toString();

        rangeText += " " +
            dosageUnits1[_appState.dosageUnits1Index] +
            "/" +
            dosageUnits2[_appState.dosageUnits2Index];
    }

    return rangeText;
  }

  String getFrequencyText(BuildContext context) {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    AppState appState = appStateInteractor.appState;

    String frequencyText = "";

    if (appState.drugDosagePerAnimal != null){
      if (appState.drugDosagePerAnimal.forAnimal != "Select..."){
        //if (_appState.drugDosagePerAnimal.frequency != "N/A") {
          frequencyText =
              "Frequency: " + appState.drugDosagePerAnimal.frequency;
        //}
      }
    }

    if (appState.schedule == "Select...") {
      frequencyText = "Frequency: Need Dosing Schedule";
    }

    if (appState.selectedDrug.name == "Select...") {
      frequencyText = "Frequency: Need Drug";
    }

    if (appState.animal.species == "Select...") {
      frequencyText = "Frequency: Need Species";
    }

    if (appState.selectedDrug.name == "Other/Override...") {
      frequencyText = "Frequency: User Specified";
    }

    return frequencyText;
  }

  String getNoteText(AppState _appState) {
    String otherInfoText = "";

    if (_appState.drugDosagePerAnimal != null) {
      if (_appState.drugDosagePerAnimal.otherInfo != "") {
        if (_appState.selectedDrug.name == "Select...") {
          otherInfoText = "Note: Need Drug";
        }

        if (_appState.animal.species == "Select...") {
          otherInfoText = "Note: Need Species";
        }

        if (_appState.drugLowDosage != 0.0 && _appState.drugHighDosage != 0.0) {
          if (_appState.selectedDrug.name != "Select..." &&
              _appState.animal.species != "Select...") {
            otherInfoText = "Note: " + _appState.drugDosagePerAnimal.otherInfo;
          }
        }
      }
    }

    return otherInfoText;
  }

  Widget _buildSecondaryMeasurement(double amount, String unitString) {
    return Container(
        padding: EdgeInsets.only(left: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            amount.toString(),
            textScaleFactor: DOUBLE_85,
          ),
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              unitString,
              textScaleFactor: DOUBLE_85,
            ),
          ),
        ]));
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(
      AppStateInteractorState appStateInteractor) {
    AppState _appState = appStateInteractor.appState;

    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: CupertinoColors.extraLightBackgroundGray,
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _appState.speciesFocusNode,
          closeWidget: closeWidget,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("species"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.animal.id,
                  _appState.speciesFocusNode,
                  appStateInteractor.setSpecies,
                  animals)),
        ),
        KeyboardAction(
          focusNode: _appState.bsaFocusNode,
          closeWidget: closeWidget,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("bsa"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(_appState.bsaTypeIndex, _appState.bsaFocusNode,
                  appStateInteractor.setBSAType, bsaTypes)),
        ),
        KeyboardAction(
          focusNode: _appState.weightFocusNode,
          closeWidget: closeWidget,
        ),
        KeyboardAction(
          focusNode: _appState.lengthFocusNode,
          closeWidget: closeWidget,
          enabled: _appState.isLengthContainerEnabled,
        ),
        KeyboardAction(
          focusNode: _appState.drugFocusNode,
          closeWidget: closeWidget,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("drug"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(_appState.drugIndex, _appState.drugFocusNode,
                  appStateInteractor.setDrug, drugs)),
        ),
        KeyboardAction(
          focusNode: _appState.scheduleFocusNode,
          closeWidget: closeWidget,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("schedule"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.scheduleIndex,
                  _appState.scheduleFocusNode,
                  appStateInteractor.setSchedule,
                  _appState.currentScheduleList)),
        ),
        KeyboardAction(
          focusNode: _appState.dosageFocusNode,
          closeWidget: closeWidget,
        ),
      ],
    );
  }
}
