import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ext/services/dataclasses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ext/globals.dart' as globals;
import 'package:ext/components/popup/rejected_popup.dart';
import 'package:ext/ui/theme/style.dart';
import 'popup/remove_popup.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

class RejectedItemElement extends StatefulWidget {

  final ProductData productData;
  final Function callback;
  const RejectedItemElement({
    Key? key,
    required this.productData,
    required this.callback
  }) : super(key: key);


  @override
  State<StatefulWidget> createState(){
    return RejectedItemElementState();
  }
}
class RejectedItemElementState extends State<RejectedItemElement> {


  int qt = 0;
  @override
  void initState() {
    qt = widget.productData.qt!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {

      },
      child: Center(
        child: Container(
          width: screenSize.width * 0.7,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 0
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    widget.productData.img!,
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: screenSize.width * 0.6 - 25,
                padding: EdgeInsets.only(left: 20,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                widget.productData.title!,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.productData.site!,
                                style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "\$" + widget.productData.price!.toStringAsFixed(2),
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}