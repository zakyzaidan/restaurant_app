import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFfcfcfc);
const Color secondaryColor = Color(0xFFeb9b57);
const Color tertiaryColor = Color(0xFF7a5f4c);
const Color fourtyColor = Color(0xFFfcc782);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(fontSize: 36, fontWeight: FontWeight.w700),
  displayMedium: GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w700),
  displaySmall: GoogleFonts.roboto( fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.15),
  labelLarge: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w500),
  labelMedium: GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w500),
  labelSmall: GoogleFonts.openSans( fontSize: 16, fontWeight: FontWeight.w500,),
  titleLarge: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  titleMedium: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  titleSmall: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5),
);