import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:http/http.dart' as http;

import '../../models/catelog.dart';
import '../catelogDetails/catelog_list.dart';

class sem6Page extends StatefulWidget {
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluisColor = const Color(0xff403b58);

  const sem6Page({super.key});

  @override
  State<sem6Page> createState() => _sem6PageState();
}

class _sem6PageState extends State<sem6Page> {
  // final url = "https://upcdn.io/kW15awi/raw/catelog-4Kgi.json";
  final url = "https://mrharsh007.github.io/GtuMaterialJson/sem6.json";
  List iteams = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    // await Future.delayed(const Duration(seconds: 2));
    final response = await http.get(Uri.parse(url));
    final catJson = response.body;
    // var catJson = await rootBundle.loadString("assets/files/catelog.json");
    var decodeData = jsonDecode(catJson);
    var productData = decodeData["products"];
    CatelogModel.catiteams = List.from(productData)
        .map<catIteam>((catiteams) => catIteam.fromMap(catiteams))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Sem - 6".text.xl3.bold.color(Colors.black).make(),
                  "Computer Engineering".text.xl2.make(),
                  "PDF loading takes time , wait for 30 second"
                      .text
                      .caption(context)
                      .make()
                ],
              ),
              if (CatelogModel.catiteams != null &&
                  CatelogModel.catiteams.isNotEmpty)
                CatelogList().py16().expand()
              else
                const CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}