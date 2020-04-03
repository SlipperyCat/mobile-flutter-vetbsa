import 'package:bsadosecalculator/app_state.dart';
import 'package:bsadosecalculator/app_state_interactor.dart';
import 'package:bsadosecalculator/ui/screens/about.dart';
import 'package:bsadosecalculator/ui/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bsadosecalculator/ui/screens/dose_calculator.dart';
import 'package:bsadosecalculator/utils.dart';

class Home extends StatefulWidget {
  final int index;
  final String title;

  Home({Key key, this.title, this.index}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _calculateDose() {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    appStateInteractor.calculateDose(context);
  }

  void _displayLegalDialog() {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    appStateInteractor.displayLegalDialog(context, _calculateDose);
  }

  void _displayLegalDialogAbout() {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    appStateInteractor.displayLegalDialogAbout(context);
  }

  void _displayDialog(int dialogIndex) {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    appStateInteractor.displayDialog(context, dialogIndex);
  }

  void _displayDrugDialog(int dialogIndex) {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    appStateInteractor.displayDrugDialog(context, dialogIndex);
  }

  void _displayBSADialog(int dialogIndex) {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    appStateInteractor.displayBSADialog(context, dialogIndex);
  }

  @override
  Widget build(BuildContext context) {
    AppStateInteractorState appStateInteractor = AppStateInteractor.of(context);
    AppState appState = appStateInteractor.appState;

    //setDevice(MediaQuery.of(context));
    setGoldenMeasurements(MediaQuery.of(context));

    //print('[App] build()');
    //appState.printState();

    return CupertinoTabView(
      builder: (BuildContext context) {
        switch (widget.index) {
          case 0:
            return buildPlatformScaffold(
                context,
                "Dose Calculator",
                DoseCalculator(_displayLegalDialog, _displayDialog,
                    _displayDrugDialog, _displayBSADialog));
            break;
          case 1:
            return buildPlatformScaffold(
              context,
              "Settings",
              Settings(),
            );
            break;
          case 2:
            return buildPlatformScaffold(
              context,
              "About",
              About(_displayLegalDialogAbout),
            );
            break;
        }
        return null;
      },
    );
  }
}
