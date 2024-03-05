// ignore_for_file: prefer_final_fields, file_names

import 'dart:async';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/smoothness.dart';
import 'package:cleaning_duty_project/feature/widget/BottomSheetActionBar/solid_bloc.dart';
import 'package:flutter/foundation.dart';

class SolidController extends ValueNotifier<bool> {
  SolidBloc _bloc = SolidBloc();

  // This is the current height of the bottomSheet's body
  double? _height;

  // This is the current smoothness of the bottomSheet
  Smoothness? smoothness;

  SolidController() : super(false);

  // Returns the value of the height as stream
  Stream<double> get heightStream => _bloc.height;

  // Returns the value of the visibility as stream
  Stream<bool> get isOpenStream => _bloc.isOpen;

  // This method sets the value of the height using streams
  set height(double value) {
    _height = value;
    _bloc.dispatch(value);
  }

  // Returns the value of the height
  double get height => _height!;

  //  Returns if the solid bottom sheet is opened or not
  bool get isOpened => value;

  void hide() {
    value = false;
  }

  void show() {
    value = true;
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
