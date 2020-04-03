import 'package:bsadosecalculator/app_state.dart';
import 'package:bsadosecalculator/app_state_interactor.dart';
import 'package:bsadosecalculator/constants.dart';
import 'package:bsadosecalculator/my_keyboard_actions.dart';
import 'package:bsadosecalculator/utils.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('[Settings] build()');

    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    AppState _appState = appStateInteractor.appState;

    FormKeyboardActions.setKeyboardActions(
        context, _buildKeyboardActionsConfig(appStateInteractor));

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
          child: Wrap(
            spacing: 4.0,
            runSpacing: defaultSpaceBetweenRows / 3,
            children: <Widget>[
              buildLabel(context, 'Weight Unit'),
              Container(
                  child: buildPickerDropDown(
                      context,
                      weightUnits,
                      _appState.primaryWeightUnitIndex,
                      _appState.weightUnitFocusNode, true)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
          child: Wrap(
            spacing: 4.0,
            runSpacing: defaultSpaceBetweenRows / 3,
            children: <Widget>[
              buildLabel(context, 'Length Unit'),
              Container(
                  child: buildPickerDropDown(
                      context,
                      lengthUnits,
                      _appState.primaryLengthUnitIndex,
                      _appState.lengthUnitFocusNode, true)),
            ],
          ),
        ),
        /*Container(
          padding: EdgeInsets.only(top: defaultSpaceBetweenRows),
          child: buildLabel(context, 'Default Dosage'),
        ),*/


        /*Container(
          padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
          child: Wrap(
            spacing: 4.0,
            runSpacing: defaultSpaceBetweenRows / 3,
            children: <Widget>[
              buildLabel(context, 'Units'),
              Container(
                  child: buildPickerDropDown(
                      context,
                      dosageUnits1,
                      _appState.dosageUnits1Index,
                      _appState.dosageUnit1FocusNode, true)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
          child: Wrap(
            spacing: 4.0,
            runSpacing: defaultSpaceBetweenRows / 3,
            children: <Widget>[
              buildLabel(context, 'Weight'),
              Container(
                  child: buildPickerDropDown(
                      context,
                      dosageUnits2,
                      _appState.dosageUnits2Index,
                      _appState.dosageUnit2FocusNode, true)),
            ],
          ),
        )*/

        Container(
          padding: EdgeInsets.symmetric(vertical: defaultSpaceBetweenRows),
          child: Wrap(
            spacing: 4.0,
            runSpacing: defaultSpaceBetweenRows / 3,
            children: <Widget>[
              buildLabel(context, 'Dosage Units'),
              Container(
                  child: buildPickerDropDown(
                      context,
                      dosageUnits,
                      _appState.dosageUnitsIndex,
                      _appState.dosageUnitsFocusNode, true)),
            ],
          ),
        )
      ],
    );
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
          closeWidget: closeWidget,
          focusNode: _appState.weightUnitFocusNode,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("weight"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.primaryWeightUnitIndex,
                  _appState.weightUnitFocusNode,
                  appStateInteractor.setPrimaryWeightUnit,
                  weightUnits)),
        ),
        KeyboardAction(
          closeWidget: closeWidget,
          focusNode: _appState.lengthUnitFocusNode,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("length"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.primaryLengthUnitIndex,
                  _appState.lengthUnitFocusNode,
                  appStateInteractor.setPrimaryLengthUnit,
                  lengthUnits)),
        ),
        KeyboardAction(
          focusNode: _appState.dosageUnitsFocusNode,
          closeWidget: closeWidget,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("dosage"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.dosageUnitsIndex,
                  _appState.dosageUnitsFocusNode,
                  appStateInteractor.setDosageUnits,
                  dosageUnits)),
        ),
        /*KeyboardAction(
          closeWidget: closeWidget,
          focusNode: _appState.dosageUnit1FocusNode,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("dosage1"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.dosageUnits1Index,
                  _appState.dosageUnit1FocusNode,
                  appStateInteractor.setDosageUnits1,
                  dosageUnits1)),
        ),
        KeyboardAction(
          focusNode: _appState.dosageUnit2FocusNode,
          closeWidget: closeWidget,
          footerBuilder: (BuildContext context) => PreferredSize(
              key: Key("dosage2"),
              preferredSize: Size.fromHeight(kPickerSheetHeight),
              child: buildPicker(
                  _appState.dosageUnits2Index,
                  _appState.dosageUnit2FocusNode,
                  appStateInteractor.setDosageUnits2,
                  dosageUnits2)),
        ),*/
      ],
    );
  }
}
