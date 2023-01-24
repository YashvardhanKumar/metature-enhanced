import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metature2/models/friend_model.dart';
import 'package:screenshot/screenshot.dart';

import '../models/post_model.dart';
import '../models/profile_model.dart';

class EditTextPostNotifier extends DB {
  bool colorPaletteEnabled = false;
  bool textColorPaletteEnabled = false;
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  bool isEditText = false;
  bool textBoxTapped = false;
  Color bgColor = Colors.black;
  Color textColor = Colors.white;
  TextEditingController textController = TextEditingController();
  String postText = '';
  double fontSize = 20;
  TextAlign alignOption = TextAlign.left;
  String fontFamily = 'Roboto';
  Map<String, dynamic> googleFonts = GoogleFonts.asMap();
  Uint8List? bytes;
  bool disableButton = false;

  void resetTextFormatting() {
    colorPaletteEnabled = textColorPaletteEnabled = isBold = isItalic =
        isUnderline = isEditText = textBoxTapped = disableButton = false;
    bgColor = Colors.black;
    textColor = Colors.white;
    postText = '';
    fontSize = 20;
    alignOption = TextAlign.left;
    fontFamily = 'Roboto';
    bytes = null;
    notifyListeners();
  }

  void onTextColorPaletteEnabled() {
    if (colorPaletteEnabled == true) {
      colorPaletteEnabled = false;
    }
    textColorPaletteEnabled = !textColorPaletteEnabled;
    notifyListeners();
  }

  void onBGColorPaletteEnabled() {
    if (textColorPaletteEnabled == true) {
      textColorPaletteEnabled = false;
    }
    colorPaletteEnabled = !colorPaletteEnabled;
    notifyListeners();
  }

  void onFontStyleMenuEnabled() {
    isEditText = !isEditText;
    notifyListeners();
  }

  void onTextAlignmentChange() {
    if (alignOption == TextAlign.left) {
      alignOption = TextAlign.center;
    } else if (alignOption == TextAlign.center) {
      alignOption = TextAlign.right;
    } else {
      alignOption = TextAlign.left;
    }
    notifyListeners();
  }

  void onWillPop() async {
    isEditText = false;
    textController.clear();
    notifyListeners();
  }

  void onColorPickerClick(Color color) {
    if (textColorPaletteEnabled) {
      textColor = color;
      textColorPaletteEnabled = false;
    } else {
      bgColor = color;
      colorPaletteEnabled = false;
    }
    notifyListeners();
  }

  void onColorPickerDismiss() {
    textColorPaletteEnabled = colorPaletteEnabled = false;
    notifyListeners();
  }

  void onBoldClick() {
    isBold = !isBold;
    notifyListeners();
  }

  void onItalicClick() {
    isItalic = !isItalic;
    notifyListeners();
  }

  void onUnderlineClick() {
    isUnderline = !isUnderline;
    notifyListeners();
  }

  void onFontSizeChanged(double value) {
    fontSize = value;
    print(value);
    notifyListeners();
  }

  void onFontFamilyChanged(String? value) {
    fontFamily = value ?? 'Roboto';
    notifyListeners();
  }

  void onChangeText(value) {
    postText = value;
    notifyListeners();
  }

  void onTextBoxTapped() {
    textBoxTapped = true;
    notifyListeners();
  }

  void enableButton() {
    disableButton = false;
    notifyListeners();
  }

  void createByteImage(Widget child) async {
    final sscontroller = ScreenshotController();
    disableButton = true;
    bytes = await sscontroller.captureFromWidget(
      child,
    );
    notifyListeners();
  }

  
}
