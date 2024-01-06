import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFfef9f3);
const Color secondaryColor = Color(0xFFde9151);
const Color tertiaryColor = Color(0xFF424242);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.openSans(fontSize: 46, fontWeight: FontWeight.w400),
  displayMedium: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w700),
  displaySmall: GoogleFonts.openSans( fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.15),
  titleLarge: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  titleMedium: GoogleFonts.merriweather(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  titleSmall: GoogleFonts.merriweather(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5),
);