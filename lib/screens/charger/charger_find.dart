import 'package:flutter/material.dart';
import 'package:hycharge/widgets/charger/custom_navigation_bar.dart';
import 'package:hycharge/widgets/charger/naver_map_widget.dart';

class ChargerFind extends StatefulWidget {
  const ChargerFind({super.key});

  @override
  State<ChargerFind> createState() => _ChargerFindState();
}

class _ChargerFindState extends State<ChargerFind> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          NaverMapWidget(),
          Container(width: 200, height: 200, ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
