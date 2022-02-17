import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ext/ui/theme/style.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PromoElement extends StatefulWidget {


  PromoElement({
    Key? key,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState(){
    return PromoElementState();
  }
}
class PromoElementState extends State<PromoElement> {


  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {

      },
      child: Center(
        child: Container(
          width: screenSize.width * 0.9,
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: Stack(
            children: [
              Container(
                  width: screenSize.width * 0.9,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 0
                        )
                      ]
                  ),
                  child: TextField(
                    controller: textEditingController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(64),
                    ],
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      height: 1
                  ),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      border: InputBorder.none,
                      hintText: "Promo Code",
                      hintStyle: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black26,
                          height: 0
                      ),
                    ),
                  ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: RawMaterialButton(
                      onPressed: () {
                      },
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: 100,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text(
                          "Apply",
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}