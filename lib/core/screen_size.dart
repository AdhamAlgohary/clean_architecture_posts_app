import 'package:flutter/material.dart';

double screenWidth({required BuildContext context}) {
  return MediaQuery.of(context).size.width;
}

double screenHeight({required BuildContext context}) {
  return MediaQuery.of(context).size.height;
}
