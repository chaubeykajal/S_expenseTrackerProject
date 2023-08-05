import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget titletext(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

Widget outlinetext(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    ),
  );
}

Widget expencetext(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

Widget totalexpencetext(String text) {
  return Text(
    "₹" + text,
    style: GoogleFonts.poppins(
      fontSize: 50,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}

Widget expencecontainer(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
        height: 80,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        )),
  );
}