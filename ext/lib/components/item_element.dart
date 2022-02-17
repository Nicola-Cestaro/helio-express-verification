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

class ItemElement extends StatefulWidget {

  final ProductData productData;
  final Function callback;
  ItemElement({
    Key? key,
    required this.productData,
    required this.callback
  }) : super(key: key);


  @override
  State<StatefulWidget> createState(){
    return ItemElementState();
  }
}
class ItemElementState extends State<ItemElement> {


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
          width: screenSize.width * 0.9,
          height: 120,
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
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          widget.productData.img!,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: RawMaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => Center(
                                      child: SingleChildScrollView(
                                          child: RemovePopup(
                                            productData: widget.productData,
                                            callback: widget.callback,
                                          )
                                      )
                                  )
                              );
                            },
                            elevation: 4,
                            shape: CircleBorder(),
                            child: Ink(
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 15,
                                height: 15,
                                alignment: Alignment.center,
                                child: const Icon(
                                  FontAwesomeIcons.times,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
              Container(
                width: screenSize.width * 0.9 - 75,
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: (){
                                    launch(widget.productData.url!);
                                  },
                                  child: Text(
                                    widget.productData.title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 14,
                                        color: blackColor,
                                        fontWeight: FontWeight.w900
                                    ),
                                  ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "\$" + widget.productData.price!.toStringAsFixed(2),
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: blackColor,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: orangeGradient
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      if(qt == 1){
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) => Center(
                                                child: SingleChildScrollView(
                                                    child: RemovePopup(
                                                      productData: widget.productData,
                                                      callback: widget.callback,
                                                    )
                                                )
                                            )
                                        );
                                      } else {
                                        setState(() {
                                          qt--;
                                          globals.productsList.firstWhere((element) => element.title == widget.productData.title!).qt = qt;
                                        });
                                        widget.callback.call();
                                      }
                                    },
                                    elevation: 4,
                                    shape: CircleBorder(),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: blackColor, width: 1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: blackColor,
                                        size: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                   qt.toString().padLeft(2,"0"),
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: blackColor,
                                        fontWeight: FontWeight.w900
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        qt++;
                                        globals.productsList.firstWhere((element) => element.title == widget.productData.title!).qt = qt;
                                      });
                                      widget.callback.call();
                                    },
                                    elevation: 4,
                                    shape: CircleBorder(),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        color: blackColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.add,
                                          color: orangeLightColor,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
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