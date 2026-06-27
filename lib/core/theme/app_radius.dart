import 'package:flutter/material.dart';

class AppRadius {
  static const double sm = 4.0;  // Base controls
  static const double md = 8.0;  // Mobile forms/buttons
  static const double lg = 12.0; // Editorial shapes
  static const double xl = 16.0;
  static const double full = 9999.0;

  static BorderRadius get base => BorderRadius.circular(sm);
  static BorderRadius get mobileInput => BorderRadius.circular(md);
  static BorderRadius get editorial => BorderRadius.circular(lg);
  static BorderRadius get pill => BorderRadius.circular(full);
}