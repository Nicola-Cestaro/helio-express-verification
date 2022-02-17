import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Manages operations on the firebase user

class ProductData {

  String? title;
  double? price;
  String? asin;
  String? site;
  String? img;
  String? url;
  int? qt;


  ProductData({
    this.title,
    this.price,
    this.asin,
    this.site,
    this.img,
    this.url,
    this.qt
  });


  Map<String, dynamic> getMap() {
    return {
      'title': title,
      'price': price,
      'asin': asin,
      'site': site,
      'img': img,
      'url': url,
      'qt': qt
    };
  }

  void fromMap(Map<String, dynamic> map) {
    title = map['title'] ?? "";
    price = map['price'] ?? "";
    asin = map['asin'] ?? "";
    site = map['site'] ?? "";
    img = map['img'] ?? "";
    url = map['url'] ?? "";
    qt = map['qt'] ?? 1;
  }

  /*static EventData fromMapReturn(DocumentSnapshot map) {
    EventData ed = EventData();
    ed.documentID = map.id;
    ed.title = map['title'] ?? "";
    ed.subtitle = map['subtitle'] ?? "";
    ed.startDate = map['startDate'].toDate();
    ed.endDate = map['endDate'].toDate();
    ed.category = map.get('category') ?? "";
    ed.photoUrl = map['photoUrl'];
    ed.city = map['city'] ?? "";
    ed.address = map['address'] ?? "";
    ed.isRemote = map['isRemote'] ?? false;
    ed.uid = map['uid'];
    return ed;
  }*/

}

