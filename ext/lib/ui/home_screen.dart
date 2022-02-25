import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'theme/style.dart';
import 'package:flutter/foundation.dart';
import 'package:ext/components/item_element.dart';
import 'package:ext/components/promo_element.dart';
import 'package:ext/services/dataclasses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ext/globals.dart' as globals;
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ext/components/popup/removeall_popup.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:ext/components/total_element.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ext/components/popup/rejected_popup.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  String? text = " ";
  List<ProductData> rejectedProducts = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    /*globals.productsList.add(ProductData(
        url: "",
        asin: "",
        img: "",
        price: 12.23,
        title: "Colore Bianco",
        site: "amazon.it",
        qt: 2
    ));
    globals.productsList.add(ProductData(
        url: "",
        asin: "",
        img: "",
        price: 12.23,
        title: "Colore Bianco",
        site: "amazon.it",
        qt: 2
    ));
    globals.productsList.add(ProductData(
        url: "",
        asin: "",
        img: "",
        price: 12.23,
        title: "Colore Bianco",
        site: "amazon.it",
        qt: 2
    ));
    globals.productsList.add(ProductData(
        url: "",
        asin: "",
        img: "",
        price: 12.23,
        title: "Colore Bianco",
        site: "amazon.it",
        qt: 2
    ));*/
    getItem();
    super.initState();
  }

  void getItem() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();


    if(prefs.containsKey("products")){
      List<String> products = prefs.getStringList("products")!;
      products.forEach((element) {
        var json = jsonDecode(element);

        globals.productsList.add(ProductData(
            asin: json["asin"],
            img: json["img"],
            price: json["price"],
            title: json["title"],
            url: json["url"],
            site: "amazon.com",
            qt: 1
        ));
      });
      setState(() {
        //js.context.callMethod('consolelog',["caricaaaa2"]);
      });
    }
    if(html.window.localStorage.containsKey("items")){
      var json = jsonDecode(html.window.localStorage['items']!);
      text = json[0]["title"];
      if(!(globals.productsList.any((element) => element.getMap().containsValue(json[0]["asin"])))){
        globals.productsList.add(ProductData(
            asin: json[0]["asin"],
            img: json[0]["img"],
            price: double.parse(json[0]["price"].toString().replaceFirst("\$", "")),
            title: json[0]["title"],
            url: json[0]["url"],
            site: json[0]["website"],
            qt: 1
        ));
        setState(() {
          //js.context.callMethod('consolelog',["caricaaaa1"]);
        });
        List<String> products = [];
        globals.productsList.forEach((element) {
          products.add(jsonEncode(element.getMap()));

        });
        prefs.setStringList("products", products);
        html.window.localStorage.remove("items");
      }
    }
  }

  @override
  Widget build(BuildContext context){

    Size screenSize = MediaQuery.of(context).size;

    double widthSubButton = screenSize.width *  0.40;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: screenSize.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: blueGradient
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "img/logoOrange.png",

                    )
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    "HELIOEXPRESS",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900
                    ),
                  )
                ],
              ),
            ),
            globals.productsList.isNotEmpty ? SizedBox(
              height: 390,
              width: screenSize.width,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                child: ListView.builder(
                  itemCount: globals.productsList.length,
                  itemBuilder: (context, i) {
                    return ItemElement(
                      productData: globals.productsList[i],
                      callback: (){
                        setState(() {

                        });
                      },
                    );
                  },
                ),
              ),
            ) : Container(
              height: 385,
              width: screenSize.width,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.cartPlus,
                    color: Colors.black26,
                  ),
                  Text(
                    "Tu carrito esta vacío",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                      height: 1.5
                    ),
                  )
                ],
              ),
            ),
            TotalElement(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*SizedBox(
                  width: 40,
                  child: RawMaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => Center(
                              child: SingleChildScrollView(
                                  child: RemoveAllPopup(
                                    callback: (){
                                      setState(() {

                                      });
                                    },
                                  )
                              )
                          )
                      );
                    },
                    elevation: 4,
                    shape: CircleBorder(),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: 25,
                        height: 25,
                        alignment: Alignment.center,
                        child: const Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),*/
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: screenSize.width,
                    height: 50,
                    child: RawMaterialButton(
                      onPressed: () async{

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Center(
                              child: CircularProgressIndicator(color: blueColor,backgroundColor: Colors.white),
                            )
                        );

                        try {
                         var response = await Dio().post(
                            'https://execute-api.us-east-1.amazonaws.com/Prod/woocommerceProductCreation',
                            data: jsonEncode(globals.productsList.map((e) => jsonEncode(e.getMap())).toList()),
                            options: Options(
                              headers: {
                                HttpHeaders.contentTypeHeader: "application/json",
                              },
                              validateStatus: (status) {
                                return status! <= 500;
                              }
                            )
                         );
                          Navigator.pop(context);
                           if(response.data["listOfProductsRejected"].toString().length > 3){
                             List listOfProductsRejected = jsonDecode(response.data["listOfProductsRejected"]);
                             //js.context.callMethod('consolelog',[listOfProductsRejected]);
                             for(var product in listOfProductsRejected){
                               rejectedProducts.add(ProductData(
                                   qt: 1,
                                   site: product["site"],
                                   title: product["title"],
                                   price: double.parse(product["price"]),
                                   img: product["img"],
                                   asin: product["asin"],
                                   url: product["url"]
                               ));
                             }
                             showDialog(
                                 context: context,
                                 barrierDismissible: true,
                                 builder: (context) => Center(
                                     child: SingleChildScrollView(
                                         child: RejectedPopup(
                                           rejectedProducts: rejectedProducts,
                                           callback: (){
                                             js.context.callMethod('openURL',[response.data["message"]]);
                                           },
                                         )
                                     )
                                 )
                             );
                           } else {
                             js.context.callMethod('openURL',[response.data["message"]]);
                           }
                           //js.context.callMethod('consolelog',[jsonEncode(globals.productsList.map((e) => jsonEncode(e.getMap())).toList())]);
                          } catch (e) {

                        }
                      },
                      elevation: 0,
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        width: screenSize.width,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: blueGradient
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proceder al pago",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            const Icon(
                              FontAwesomeIcons.shoppingBasket,
                              color: Colors.white,
                              size: 22,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}