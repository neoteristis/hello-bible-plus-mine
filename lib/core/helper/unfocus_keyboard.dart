import 'package:flutter/material.dart';

void unfocusKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void requestFocus() {
  FocusManager.instance.primaryFocus?.requestFocus();
}
