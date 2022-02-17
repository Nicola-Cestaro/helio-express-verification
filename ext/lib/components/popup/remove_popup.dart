import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ext/globals.dart' as globals;
import 'package:ext/ui/theme/style.dart';
import 'package:ext/services/dataclasses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import 'dart:convert';

class RemovePopup extends StatelessWidget {

  final ProductData productData;
  final Function callback;
  const RemovePopup({required this.productData,required this.callback});
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
                  "¡Atención!",
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
                width: 253,
                child: Opacity(
                  opacity: 0.8,
                  child: Text(
                    "¿Está seguro de que desea eliminar este producto de su carrito?",
                    style: GoogleFonts.ptSans(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
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
                          "ANULAR",
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
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        if(globals.productsList.length == 1){
                          globals.productsList = [];
                          prefs.remove("products");
                          html.window.localStorage.remove("items");
                        } else {
                          html.window.localStorage.remove("items");
                          globals.productsList.removeWhere((element) => element.asin == productData.asin);
                          List<String> products = [];
                          globals.productsList.forEach((element) {
                            products.add(jsonEncode(element.getMap()));
                          });
                          prefs.setStringList("products", products);
                          html.window.localStorage.remove("items");
                        }
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
                          "ELIMINAR",
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
