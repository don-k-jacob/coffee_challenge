import 'package:coffee_challenge/ui/coffee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.brown,
          primaryColor: Colors.white,
          textTheme: TextTheme(
            headline5: GoogleFonts.poppins(
                color: Colors.brown[700],
                fontWeight: FontWeight.w600,
                fontSize: 28,
                height: 1.2),
            headline2: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 64),
            headline6: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 22),
            subtitle1: GoogleFonts.poppins(
              color: Colors.brown[400],
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          )),
      home: CoffeeListPage(),
    );
  }
}
