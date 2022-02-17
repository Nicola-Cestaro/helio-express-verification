import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ext/services/dataclasses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ext/globals.dart' as globals;
import 'package:ext/ui/theme/style.dart';
import 'popup/remove_popup.dart';
import 'dart:ui';

class TotalElement extends StatefulWidget {

  TotalElement({
    Key? key,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState(){
    return TotalElementState();
  }
}
class TotalElementState extends State<TotalElement> {


  int qt = 0;
  @override
  void initState() {
    super.initState();
  }

  String getTotalPrice(){
    double tot = 0;
    for (var element in globals.productsList) {
      tot += element.price! * element.qt!;
    }
    return tot.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {

      },
      child: Center(
        child: Container(
          width: screenSize.width,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: blueGradient
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total parcial",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      "\$" + getTotalPrice(),
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              /*Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: primaryColor.withOpacity(0.7), width: 2))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Weight",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.black87
                      ),
                    ),
                    Text(
                      "1.5kg",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black87
                      ),
                    ),
                  ],
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}