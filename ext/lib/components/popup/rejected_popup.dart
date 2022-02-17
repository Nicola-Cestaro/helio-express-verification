import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ext/globals.dart' as globals;
import 'package:ext/ui/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ext/services/dataclasses.dart';
import 'dart:html' as html;
import 'package:ext/components/rejected_item_element.dart';
import 'dart:math';
import 'dart:convert';
class RejectedPopup extends StatelessWidget {


  final List<ProductData> rejectedProducts;
  final Function callback;
  final ScrollController scrollController = ScrollController();

  RejectedPopup({required this.rejectedProducts,required this.callback});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          width: screenSize.width * 0.90,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Color(0xfffafafa),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: orangeDarkColor,
                size: 40,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Container(
                width: screenSize.width * 0.70,
                alignment: Alignment.center,
                child: Text(
                  "These Products are not allowed",
                  style: GoogleFonts.poppins(
                      color: blueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
              SizedBox(
                height: min(300, rejectedProducts.length * 100),
                width: screenSize.width * 0.85,
                child: Scrollbar(
                  isAlwaysShown: rejectedProducts.length > 3 ? true : false,
                  controller: scrollController,
                  child: ListView.builder(
                    itemCount: rejectedProducts.length,
                    controller: scrollController,
                    itemBuilder: (context, i) {
                      return RejectedItemElement(
                        productData: rejectedProducts[i],
                        callback: (){

                        },
                      );
                    },
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      elevation: 0,
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: blueColor,width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "GO BACK",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: blueColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: RawMaterialButton(
                      onPressed: () async{
                        callback.call();
                        Navigator.pop(context);
                      },
                      elevation: 0,
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "GO TO CHECKOUT",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}
